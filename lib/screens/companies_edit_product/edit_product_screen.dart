import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/common/custom_surfix_icon.dart';
import 'package:mewnu/models/categories/category.dart';
import 'package:mewnu/models/products/product.dart';
import 'package:mewnu/models/products/product_manager.dart';
import 'package:mewnu/screens/companies_edit_product/components/images_form.dart';
import 'package:mewnu/screens/companies_edit_product/components/sizes_form.dart';
import 'package:mewnu/screens/companies_product/product_screen.dart';
import 'package:mewnu/screens/companies_categories/categories_screen.dart';
// import '../../categories/edit_category/components/images_form.dart';
import 'package:mewnu/models/companies/company.dart';
class EditProductScreen extends StatelessWidget {
  EditProductScreen(Product p)//, this.categoryId, this.categoryTitle)
      : editing = p != null,
        product = p != null ? p.clone() : Product();

  final Product product;
  final bool editing;
  // final String categoryId;
  // final String categoryTitle;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Category category = Provider.of(context);
    final Company company = Provider.of(context, listen: false);
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(category.name),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back),
          ),
          actions: <Widget>[
            if (editing)
              // TextButton(
              //     onPressed: () async {
              //      context.read<ProductManager>().delete(product);
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
                    context.read<ProductManager>().delete( company.id, product,category.id,9.6);
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
              ImagesForm(product),
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
                      child: Padding(
                        // color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TextFormField(
                              initialValue: product.name,
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
                              onSaved: (name) => product.name = name,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              initialValue: product.description,
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
                              onSaved: (desc) => product.description = desc,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizesForm(product),
                            const SizedBox(
                              height: 16,
                            ),
                          
                            Consumer<Product>(
                              builder: (_, product, __) {
          if (product.loading)
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
                                    onPressed: !product.loading
                                        ? () async {
                                            if (formKey.currentState
                                                .validate()) {
                                              formKey.currentState.save();

                                              await product.save(company.id, category.type,
                                                  category.id, category.name);

                                              context
                                                  .read<ProductManager>()
                                                  .update(product);
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => ProductScreen(
                                                      product), // categoryId, categoryTitle
                                                ),
                                              );
                                              // Navigator.of(context).pop();
                                            }
                                          }
                                        : null,
                                    child: 
                                    // product.loading
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
