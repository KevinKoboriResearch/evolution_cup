import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/common/custom_surfix_icon.dart';
import 'package:mewnu/models/categories/category.dart';
import 'package:mewnu/models/categories/category_manager.dart';
import 'package:mewnu/screens/companies_categories/categories_screen.dart';
import 'package:mewnu/screens/companies_edit_category/components/images_form.dart';
import 'package:mewnu/screens/companies_edit_category/components/options_type_form.dart';
import 'package:mewnu/models/companies/company.dart';

// import 'dart:core';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:mewnu/../models/categories/category.dart';
// import 'package:mewnu/../models/categories/option_model.dart';
class EditCategoryScreen extends StatefulWidget {
  EditCategoryScreen(Category p)
      : editing = p != null,
        category = p != null ? p.clone() : Category();

  final Category category;
  final bool editing;
  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkedValue = true;
  int _selectedOption;
  dynamic _element;
  @override
  Widget build(BuildContext context) {
    final Company company = Provider.of(context, listen: false);
    return ChangeNotifierProvider.value(
      value: widget.category,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.editing
              ? 'Editando Categoria...'
              : 'Criando Categoria...'),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back),
          ),
          actions: <Widget>[
            if (widget.editing)
              // TextButton(
              //     onPressed: () async {
              //      context.read<CategoryManager>().delete(category);
              //       Navigator.of(context).pop();
              //     },
              //     child: Text('DELETAR  ',
              //         style: TextStyle(color: Theme.of(context).accentColor)),
              //   ),
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    //are you sure?
                    context.read<CategoryManager>().delete(widget.category);
                    Navigator.of(context).pop();
                  },
                ),
              ),
          ],
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              ImagesForm(widget.category),
              // SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(34),
                  child: Container(
                    color: Colors.grey[500],
                    padding: const EdgeInsets.all(1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(33),
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TextFormField(
                              initialValue: widget.category.name,
                              decoration: const InputDecoration(
                                labelText: "Título",
                                labelStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                hintText: "Insira um título",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: CustomSurffixIcon(
                                    svgIcon: "assets/mewnu/icons/mewnu_1.svg"),
                              ),
                              style: const TextStyle(fontSize: 16),
                              validator: (name) {
                                if (name.length < 2)
                                  return 'Título muito curto';
                                return null;
                              },
                              onSaved: (name) => widget.category.name = name,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              initialValue: widget.category.description,
                              style: const TextStyle(fontSize: 16),
                              decoration: const InputDecoration(
                                labelText: "Descrição",
                                labelStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                hintText: "Insira uma descrição",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: CustomSurffixIcon(
                                    svgIcon: "assets/mewnu/icons/mewnu_1.svg"),
                              ),
                              maxLines: null,
                              validator: (desc) {
                                if (desc.length < 6)
                                  return 'Descrição muito curta';
                                return null;
                              },
                              onSaved: (desc) =>
                                  widget.category.description = desc,
                            ),
                            CheckboxListTile(
                              title: Text('Manter painel em movimento'),
                              value: checkedValue,
                              onChanged: (newValue) {
                                setState(() {
                                  checkedValue = newValue;
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(38),
                              child: Container(
                                padding: const EdgeInsets.all(1.0),
                                color: Colors.grey,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(37),
                                  child: Container(
                                    color: Colors.white,
                                    child: OptionsTypeForm(widget.category),
                                  ),
                                ),
                              ),
                            ),
                            Consumer<Category>(
                              builder: (_, category, __) {
                                if (category.loading)
                                  return const LinearProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                  );
                                else
                                  return SizedBox(
                                    height: 44,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.pressed))
                                              return Theme.of(context)
                                                  .accentColor;
                                            return Theme.of(context)
                                                .accentColor;
                                          },
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(26.0),
                                          ),
                                        ),
                                      ),
                                      onPressed: !category.loading
                                          ? () async {
                                              if (formKey.currentState
                                                  .validate()) {
                                                formKey.currentState.save();
                                                widget.category.autoplay =
                                                    checkedValue;
                                                await category.save(
                                                    company.id, company.name);

                                                context
                                                    .read<CategoryManager>()
                                                    .update(category);
                                                Navigator.of(context).pop();
                                              }
                                            }
                                          : null,
                                      child:
                                          // category.loading
                                          //     ? const CircularProgressIndicator()
                                          //     :
                                          const Text(
                                        'Salvar',
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                  );
                              },
                            ),
                            // const SizedBox(
                            //   height: 32,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // MenuOptionsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
