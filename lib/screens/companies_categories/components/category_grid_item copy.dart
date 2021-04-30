import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/categories/category.dart';
import 'package:mewnu/models/products/product_manager.dart';
// import '../../categories/category/category_screen.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/companies_products/products_screen.dart';
import 'package:mewnu/screens/companies_edit_category/edit_category_screen.dart';
import 'package:mewnu/models/companies/company.dart';

class CategoryGridItem extends StatefulWidget {
  final Category category;
  final String pageType;
  const CategoryGridItem(this.category, this.pageType);

  // final String pageType;
  // CategoryGridItem(this.pageType);
  @override
  _CategoryGridItemState createState() => _CategoryGridItemState();
}

class _CategoryGridItemState extends State<CategoryGridItem> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // bool value = false;

  @override
  Widget build(BuildContext context) {
    final Category category = Provider.of(context, listen: false);
    final Company companyProvider = Provider.of(context, listen: false);
    return GestureDetector(
      onTap: () async {
        category.setCategory(widget.category);
        final ProductManager productManager =
            Provider.of(context, listen: false);
        await productManager.loadCompanyCategoryProducts(
            companyProvider.id, widget.category.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CompanyProductsScreen(),
          ),
        );
      },
      child: Column(
        children: [
          
          AspectRatio(
            aspectRatio: 2,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Stack(children: [
                    Container(
                      color: Colors.grey[100],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Image.network(
                        widget.category.images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ]),
                );
              },
              itemCount: widget.category.images.length, //10,
              viewportFraction: 0.5,
              scale: 1,
              autoplay: widget.category.images.length <= 1
                  ? false
                  : widget.category.autoplay != null
                      ? widget.category.autoplay
                      : false,
            ),
          ),
          
          Consumer<UserManager>(
            builder: (_, userManager, __) {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16.0,
                        right: userManager.adminEnabled(context)
                            ? 44.0
                            : 16.0),
                    child: LayoutBuilder(
                      builder: (context, size) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(height: 4),
                            Text(
                              widget.category.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            // Text(
                            //   widget.category.description,
                            //   maxLines: 1,
                            //   overflow: TextOverflow.ellipsis,
                            //   style: const TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 15,
                            //   ),
                            // ),
                          ],
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 8,
                    child: userManager.adminEnabled(context)
                        ? SizedBox(
                              height: 18.0,
                              width: 18.0,
                              child: IconButton(
                                onPressed: () {
                                   Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      EditCategoryScreen(widget.category),
                                ),
                              );
                                },
                                padding: const EdgeInsets.all(0.0),
                                icon: const Icon(Icons.edit, size: 16, color: Colors.grey),
                              )
                            )
                        // IconButton(
                        //     icon: Icon(
                        //       Icons.edit,
                        //       color: Colors.grey[500],
                        //     ),
                        //     onPressed: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (_) =>
                        //               EditCategoryScreen(widget.category),
                        //         ),
                        //       );
                        //     },
                        //   )
                        : Container(),
                  ),
                ],
              );
            },
          ),
          const Spacer(),
                   
        ],
      ),
    );
  }
}
