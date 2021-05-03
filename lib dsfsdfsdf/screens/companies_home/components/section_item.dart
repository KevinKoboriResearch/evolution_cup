



import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:mewnu/models/home/home_manager.dart';
import 'package:mewnu/models/products/product.dart';
import 'package:mewnu/models/products/product_manager.dart';
import 'package:mewnu/models/home/section.dart';
import 'package:mewnu/models/home/section_item.dart';
import 'package:mewnu/screens/companies_product/product_screen.dart';
import 'package:mewnu/screens/companies_select_product/select_product_screen.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item, this.companyTitle);
  final String companyTitle;
  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    final categoriesManager = context.watch<HomeManager>();
    // final categoryId = 'Rcs0G97QYwIxluHXAcMq';
    // final categoryTitle = 'zc c z c czz';
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: GestureDetector(
        onTap: () {
          if (item.product != null) {
            final product =
                context.read<ProductManager>().findProductById(item.product);
            if (product != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        ProductScreen(product)),//, categoryId, categoryTitle
              );
            }
          }
        },
        onLongPress: categoriesManager.editing
            ? () {
                showDialog(
                    context: context,
                    builder: (_) {
                      final product = context
                          .read<ProductManager>()
                          .findProductById(item.product);
                      return AlertDialog(
                        title: const Text('Editar Item'),
                        content: product != null
                            ? ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Image.network(product.images.first),
                                title: Text(product.name),
                                subtitle: Text(
                                    'R\$ ${product.basePrice.toStringAsFixed(2)}'),
                              )
                            : null,
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              context.read<Section>().removeItem(item);
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Excluir',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              if (product != null) {
                                item.product = null;
                              } else {
                                final Product product = await
                                    // Navigator.of(context)
                                    //         .pushNamed('/select_product')  as Product;
                                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SelectProductScreen()),
                                );

                                item.product = product?.id;
                              }
                              Navigator.of(context).pop();
                            },
                            child: Text(
                                product != null ? 'Desvincular' : 'Vincular'),
                          ),
                        ],
                      );
                    });
              }
            : null,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: item.image is String
                  ? FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: item.image as String,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      item.image as File,
                      fit: BoxFit.cover,
                    ),
            ),
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   child: Container(
            //     width: 200,
            //     height: 44,
            //     padding: const EdgeInsets.all(6.0),
            //     decoration: BoxDecoration(
            //         gradient: LinearGradient(
            //             begin: Alignment.topCenter,
            //             end: Alignment.bottomCenter,
            //             colors: [
            //           Colors.black.withOpacity(0.4),
            //           Colors.transparent
            //         ])),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       mainAxisSize: MainAxisSize.max,
            //       children: <Widget>[
            //         Flexible(
            //           fit: FlexFit.tight,
            //           flex: 5,
            //           child: Padding(
            //             padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: <Widget>[
            //                 Text(
            //                   companyTitle,
            //                   maxLines: 1,
            //                   overflow: TextOverflow.ellipsis,
            //                   style: const TextStyle(
            //                       color: Colors.white,
            //                       fontWeight: FontWeight.w600),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
