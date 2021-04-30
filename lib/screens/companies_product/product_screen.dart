import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:mewnu/models/carts/cart_manager.dart';
import 'package:mewnu/models/categories/category.dart';
import 'package:mewnu/models/products/product.dart';
import 'package:mewnu/models/products/product_manager.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/carts_cart/cart_screen.dart';
import 'package:mewnu/screens/companies_home/home_screen.dart';
import 'package:mewnu/screens/companies_edit_product/edit_product_screen.dart';
import 'package:mewnu/screens/companies_product/components/size_widget.dart';
// import 'package:mewnu/screens/user/sign_in/sign_in_screen.dart';
import 'package:social_share/social_share.dart';
import 'package:mewnu/screens/user_google_sign_in/google_sign_in_screen.dart';
import 'package:mewnu/models/companies/company.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);
  // this.categoryId, this.categoryTitle);

  final Product product;
  // final String categoryId;
  // final String categoryTitle;
// Consumer<ProductManager>(
//       builder: (_, productManager, __) {
//         final filteredProducts = productManager.filteredProducts;
  @override
  Widget build(BuildContext context) {
    // final Category category = Provider.of(context);
    final Company company = Provider.of(context, listen: false);
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: Colors.transparent,
          title: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompanyHomeScreen()),
              );
              // Navigator.of(context)
              //     .pushNamed('/store', arguments: product);
            },
            child: Text(company.name),
          ),
          actions: <Widget>[
            Consumer<UserManager>(
              builder: (_, userManager, __) {
                if (userManager.adminEnabled(context) && !product.deleted) {
                  return IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProductScreen(
                                  product)) //, category.id, category.name)),
                          );
                      // Navigator.of(context).pushReplacementNamed(
                      //     '/edit_product',
                      //     arguments: product);
                    },
                  );
                } else {
                  return Container();
                  // return TextButton(
                  //                   onPressed: () async {
                  //                     SocialShare.shareWhatsapp("Mewnu");
                  //                   },
                  //                   child:Text('Compartilhar')
                  //                 );
                }
              },
            )
          ],
        ),
        // backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.25,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  if (product.images[index] is String)
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.grey[100],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Image.network(
                              product.images[index] as String,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    );
                  else
                    Stack(
                      children: [
                        Container(
                          color: Colors.grey[100],
                        ),
                        Image.file(
                          product.images[index] as File,
                          fit: BoxFit.cover,
                        ),
                      ],
                    );
                },
                itemCount: product.images.length, //10,
                viewportFraction: 0.8,
                scale: 1,
                pagination: product.images.length <= 1
                    ? null
                    : SwiperPagination(
                        margin: EdgeInsets.all(0.0),
                        builder: SwiperCustomPagination(builder:
                            (BuildContext context, SwiperPluginConfig config) {
                          return ConstrainedBox(
                            child: Stack(
                              children: <Widget>[
                                // Container(color:Colors.black.withOpacity(0.5)),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(52.0, 12.0, 56.0, 0),
                                  child: Row(
                                    children: <Widget>[
                                      Spacer(),

//                            ClipRRect(
//              borderRadius: BorderRadius.circular(6),
//              child:
// Container(
//   padding:EdgeInsets.fromLTRB(4,1,4,2),
//   color:Colors.white.withOpacity(0.8),
//   child:
//                        Text(
//                               '${config.activeIndex + 1}/${config.itemCount}',
//                               style: TextStyle(fontSize: 20.0, fontWeight:FontWeight.bold, color: Theme.of(context).accentColor,),
//                             ),),),
                                    ],
                                  ),
                                ),
                                Center(
                                  // alignment: Alignment.center,
                                  child: DotSwiperPaginationBuilder(
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.4),
                                          activeColor:
                                              Theme.of(context).accentColor,
                                          size: 8.0,
                                          activeSize: 8.0)
                                      .build(context, config),
                                ),
                              ],
                            ),
                            constraints: BoxConstraints.expand(height: 50.0),
                          );
                        })),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    product.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ${product.basePrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  if (product.deleted)
                    const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Este produto não está mais disponível',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red),
                      ),
                    )
                  else ...[
                    const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Modos',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.sizes.map((s) {
                        return SizeWidget(size: s);
                      }).toList(),
                    ),
                  ],
                  const SizedBox(
                    height: 32,
                  ),
                  // const Spacer(),
                  if (product.hasStock)
                    Consumer2<UserManager, Product>(
                      builder: (_, userManager, product, __) {
                        return SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: product.selectedSize != null
                                ? () async {
                                    if (userManager.isLoggedIn) {
                                      // final CartManager cartManager = Provider.of(context);
                                      // await cartManager.loadCartItems(company.id);
                                      await context
                                          .read<CartManager>()
                                          .loadCartItems(company.id);
                                      context
                                          .read<CartManager>()
                                          .addToCart(company, product);
                                     
                                      // await company.loadCurrentCompany(company.id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CartScreen()),
                                      );
                                      // Navigator.of(context).pushNamed('/cart');
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GoogleSignInScreen()),
                                      );
                                      // Navigator.of(context).pushNamed('/login');
                                    }
                                  }
                                : null,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Theme.of(context).accentColor;
                                  return Theme.of(context).accentColor;
                                },
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26.0),
                                ),
                              ),
                            ),
                            child: Text(
                              userManager.isLoggedIn
                                  ? 'Colocar na sacola'
                                  : 'Faça Login para Comprar',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
