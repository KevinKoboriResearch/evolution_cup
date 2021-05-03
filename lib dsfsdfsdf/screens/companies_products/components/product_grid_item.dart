import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:mewnu/models/products/product.dart';
import 'package:mewnu/screens/companies_product/product_screen.dart';

class ProductGridItem extends StatefulWidget {
  const ProductGridItem(
      this.product, this.pageType, this.categoryId, this.categoryTitle);
  final Product product;
  final String pageType;
  final String categoryId;
  final String categoryTitle;

  // final String pageType;
  // ProductGridItem(this.pageType);
  @override
  _ProductGridItemState createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // bool value = false;

  @override
  Widget build(BuildContext context) {
    // final Cart cart = Provider.of(context, listen: false);
    // final Product product = Provider.of(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ProductScreen(
                  widget.product)), //, widget.categoryId, widget.categoryTitle
        );
        // Navigator.of(context).pushNamed('/product', arguments: widget.product);
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 6.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: AspectRatio(
                aspectRatio: 1,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            color: Colors.grey[100],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              widget.product.images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: widget.product.images.length, //10,
                  viewportFraction: 1,
                  scale: 0.8,
                  // autoplay: true,
                  pagination: widget.product.images.length <= 1
                      ? null
                      : SwiperPagination(
                          margin: EdgeInsets.all(0.0),
                          builder: SwiperCustomPagination(
                            builder: (BuildContext context,
                                SwiperPluginConfig config) {
                              return ConstrainedBox(
                                constraints:
                                    BoxConstraints.expand(height: 20.0),
                                child: Center(
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
                              );
                            },
                          ),
                        ),
                ),
              ),
              // AspectRatio(
              //   aspectRatio: 1,
              //   child: Stack(
              //     children: [
              //       widget.widget.product.images.first is String
              //           ? FadeInImage.memoryNetwork(
              //               placeholder: kTransparentImage,
              //               image: widget.widget.product.images.first as String,
              //               fit: BoxFit.cover,
              //             )
              //           : Image.file(
              //               widget.widget.product.images.first as File,
              //               fit: BoxFit.cover,
              //             ),

              //       Positioned(
              //         top: 4,
              //         right: 4,
              //         child: InkWell(
              //           onTap: () async {
              //             // widget.product.toggleFavorite(ctx, widget.pageType,
              //             //     'remottelyCompanies/${widget.product.companyTitle}/productCategories/${widget.product.categoryTitle}/products/${widget.product.id}');
              //           },
              //           child: SvgPicture.asset(
              //             'assets/icons/Heart Icon.svg',
              //             semanticsLabel: 'Perfil',
              //             height: 18,
              //             color: Colors.black,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ),
            SizedBox(
              height: 4,
            ),
            Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 5.0, right: 5.0), //24.0),
                  child: LayoutBuilder(
                    builder: (context, size) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(height: 4),
                          Text(
                            // widget.product.subtitle,
                            'R\$ ${widget.product.basePrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Theme.of(context).accentColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            widget.product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                // Positioned(
                //   bottom: 4,
                //   right: 4,
                //   child: SvgPicture.asset(
                //     'assets/icons/Heart Icon.svg',
                //     semanticsLabel: 'Perfil',
                //     height: 18,
                //     color: Colors.black,
                //   ),
                // ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
