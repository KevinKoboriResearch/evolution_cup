import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/common/custom_surfix_icon.dart';
import 'package:mewnu/models/companies/company.dart';
import 'package:mewnu/models/companies/company_manager.dart';
import 'package:mewnu/screens/companies/companies_screen.dart';
import 'package:mewnu/screens/companies_edit_company/components/images_form.dart';
import 'package:mewnu/screens/companies_edit_company/components/options_type_form.dart';
import 'package:mewnu/screens/companies_categories/categories_screen.dart';
import 'package:mewnu/models/user/user_manager.dart';
// CompanyCategoriesScreen
// import 'dart:core';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:mewnu/models/companies/company.dart';
// import 'package:mewnu/models/companies/option_model.dart';
class EditCompanyScreen extends StatefulWidget {
  EditCompanyScreen(Company p)
      : editing = p != null,
        company = p != null ? p.clone() : Company();

  final Company company;
  final bool editing;
  @override
  _EditCompanyScreen createState() => _EditCompanyScreen();
}

class _EditCompanyScreen extends State<EditCompanyScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkedValue = true;
  int _selectedOption;
  dynamic _element;
  @override
  Widget build(BuildContext context) {
    
    final UserManager userManager = Provider.of(context, listen: false);
    return ChangeNotifierProvider.value(
      value: widget.company,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.editing
              ? 'Editando Empresa...'
              : 'Criando Empresa...'),
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
              //      context.read<CompanyManager>().delete(company);
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
                    context.read<CompanyManager>().delete(widget.company);
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
              ImagesForm(widget.company),
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
                              initialValue: widget.company.name,
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
                              onSaved: (name) => widget.company.name = name,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              initialValue: widget.company.description,
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
                                // if (desc.length < 6)
                                //   return 'Descrição muito curta';
                                return null;
                              },
                              onSaved: (desc) =>
                                  widget.company.description = desc,
                            ),
                            const SizedBox(height: 16),
                            // TextFormField(
                            //   initialValue: widget.company.whatsapp,
                            //   style: const TextStyle(fontSize: 16),
                            //   decoration: const InputDecoration(
                            //     labelText: "Whatsapp",
                            //     labelStyle: TextStyle(
                            //         fontSize: 20, fontWeight: FontWeight.bold),
                            //     hintText: "Insira o whatsapp da empresa",
                            //     floatingLabelBehavior:
                            //         FloatingLabelBehavior.always,
                            //     suffixIcon: CustomSurffixIcon(
                            //         svgIcon: "assets/mewnu/icons/mewnu_1.svg"),
                            //   ),
                            //   maxLines: null,
                            //   validator: (desc) {
                            //     // if (desc.length < 6)
                            //     //   return 'Descrição muito curta';
                            //     return null;
                            //   },
                            //   onSaved: (zap) =>
                            //       widget.company.whatsapp = zap,
                            // ),
                            Text('Adicionar contatos/whatsapp/email da empresa'),
                            Text('Adicionar delivery'),
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
                                    child: OptionsTypeForm(widget.company),
                                  ),
                                ),
                              ),
                            ),

                            //  FormField<double>(
                            //     initialValue: widget.company.type,
                            //     validator: (type) {
                            //       if (type == null) return 'selecione uma categoria';
                            //       return null;
                            //     },
                            //     builder: (state) {
                            //       return SizedBox(
                            //         height: 200,
                            //         child: ListView.builder(
                            //             itemCount: options.length,
                            //             itemBuilder: (BuildContext context, int index) {
                            //               return ExpansionTile(
                            //                 // backgroundColor: _selectedOption == index ? Colors.deepOrange : Colors.green,
                            //                 title: ListTile(
                            //                   leading: SvgPicture.asset(
                            //                     options[index].svg,
                            //                     height: 30,
                            //                     color: _selectedOption == index
                            //                         ? Colors.deepOrange
                            //                         : Colors.grey[600],
                            //                   ),
                            //                   title: Text(
                            //                     options[index].title,
                            //                     maxLines: 1,
                            //                     overflow: TextOverflow.ellipsis,
                            //                     style: TextStyle(
                            //                       fontSize: 18,
                            //                       fontWeight: FontWeight.bold,
                            //                       color: _selectedOption == index
                            //                           ? Colors.deepOrange
                            //                           : Colors.grey[600],
                            //                     ),
                            //                   ),
                            //                   selected: _selectedOption == index,
                            //                   // onTap: () {
                            //                   //   setState(() {
                            //                   //     _selectedOption = index;
                            //                   //   });
                            //                   // },
                            //                 ),
                            //                 // ),
                            //                 children: <Widget>[
                            //                   Column(
                            //                     children: options[index].items.map((element) {
                            //                       return ListTile(
                            //                         dense: true,
                            //                         title: Text(
                            //                           element['title'].toString(),
                            //                           maxLines: 1,
                            //                           overflow: TextOverflow.ellipsis,
                            //                           style: TextStyle(
                            //                             fontSize: 18,
                            //                             fontWeight: FontWeight.bold,
                            //                             color: _element == element
                            //                                 ? Colors.deepOrange
                            //                                 : Colors.grey[600],
                            //                           ),
                            //                         ),
                            //                         selected: _element == element,
                            //                         onTap: () {
                            //                           state.setValue(double.parse(element['value']));
                            //                           setState(() {
                            //                             _element = element;
                            //                             _selectedOption = index;
                            //                           });
                            //                         },
                            //                         // ),
                            //                       );
                            //                     }).toList(),
                            //                   ),
                            //                 ],
                            //                 // ),
                            //               );
                            //             }),
                            //       );
                            //     },
                            //     // onSaved: widget.company.type = element['value'];,
                            //     onSaved: (value) =>
                            //                                 widget.company.type = value,
                            //   ),

                            const SizedBox(
                              height: 16,
                            ),

                            Consumer<Company>(
                              builder: (_, company, __) {
                                 if (company.loading)
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
                                          if (states
                                              .contains(MaterialState.pressed))
                                            return Theme.of(context)
                                                .accentColor;
                                          return Theme.of(context).accentColor;
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
                                    onPressed: !company.loading
                                        ? () async {
                                            if (formKey.currentState
                                                .validate()) {
                                              formKey.currentState.save();
                                              widget.company.autoplay =
                                                  checkedValue;
                                              await company.firestoreAdd(userManager);

                                              context
                                                  .read<CompanyManager>()
                                                  .update(company);
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      CompanyCategoriesScreen(),
                                                ),
                                              );
                                              // Navigator.of(context).pop();
                                            }
                                          }
                                        : null,
                                    child: 
                                    // company.loading
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
