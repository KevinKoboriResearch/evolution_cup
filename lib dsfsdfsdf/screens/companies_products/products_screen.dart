import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/categories/category.dart';
import 'package:mewnu/models/products/product_manager.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/companies_products/components/product_grid_item.dart';
import 'package:mewnu/screens/companies_edit_product/edit_product_screen.dart';
import 'package:mewnu/models/companies/company.dart';

class CompanyProductsScreen extends StatelessWidget {
  // const CompanyProductsScreen({this.companyId, this.categoryId});
  // final String companyId;
  // final String categoryId;

  @override
  Widget build(BuildContext context) {
    final Category category = Provider.of(context);
    final Company company = Provider.of(context, listen: false);
    Future<void> _loadPageData() async {
      final ProductManager productManagerFunc =
          Provider.of(context, listen: false);
      // Future<void> loaded = "";
      await productManagerFunc.loadCompanyCategoryProducts(
          company.id, category.id);
    }

    return FutureBuilder(
      future: _loadPageData(), // a Future<String> or null
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Text('Volte a página e tente novamente'),
              ),
            );
          case ConnectionState.waiting:
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          default:
            if (snapshot.hasError)
              return Text('Erro: ${snapshot.error}');
            else
              return Consumer<ProductManager>(
                builder: (_, productManager, __) {
                  final filteredProducts = productManager.filteredProducts;
                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: CustomScrollView(
                      slivers: <Widget>[
                        const SliverToBoxAdapter(child: SizedBox(height: 16)),
                        SliverAppBar(
                          floating: true,
                          snap: true,
                          elevation: 0,
                          toolbarHeight: 40,
                          // leadingWidth: 32,
                          // leading: Padding(
                          //   padding: const EdgeInsets.only(left: 18.0),
                          //   child: InkWell(
                          //     onTap: () {
                          //       Navigator.of(context).pop();
                          //     },
                          //     child: const Icon(Icons.arrow_back_ios),
                          //   ),
                          // ),
                          backgroundColor: Theme.of(context).canvasColor,
                          actions: <Widget>[
                            Consumer<UserManager>(
                              builder: (_, userManager, __) {
                                if (userManager.adminEnabled(context)) {
                                  return IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.grey[500],
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => EditProductScreen(
                                                  null)) //, categoryId, categoryTitle)),
                                          );
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            )
                          ],
                          title: Text(
                            '${category.name}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          titleSpacing: 0,
                        ),
                        SliverAppBar(
                          expandedHeight: 10,
                          toolbarHeight: 48,
                          pinned: true,
                          elevation: 0,
                          backgroundColor: Theme.of(context).canvasColor,
                          leading: Container(),
                          leadingWidth: 0,
                          title: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Container(
                              // width: SizeConfig.screenWidth * 0.64,
                              height: 38,
                              decoration: BoxDecoration(
                                // color: Colors.grey[200],
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                onChanged: (value) =>
                                    productManager.search = value,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: "Pesquisar produto...",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400]),
                                    prefixIcon: const Icon(Icons.search)),
                              ),
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 16,
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(
                            8.0,
                            0.0,
                            8.0,
                            8.0,
                          ),
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 203,
                              childAspectRatio: 0.74,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return ProductGridItem(filteredProducts[index],
                                    'store', category.id, category.name);
                              },
                              childCount: filteredProducts.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
        }
      },
    );
  }
}
