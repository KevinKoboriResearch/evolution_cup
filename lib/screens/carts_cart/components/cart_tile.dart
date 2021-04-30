import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/carts/cart_product.dart';
import 'package:mewnu/screens/companies_product/product_screen.dart';

class CartTile extends StatelessWidget {
  const CartTile(this.cartProduct, this.showControls);

  final CartProduct cartProduct;
  final bool showControls;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context)
          //     .pushNamed('/product', arguments: cartProduct.product);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductScreen(cartProduct.product)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(cartProduct.product.images.first),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cartProduct.product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Medida: ${cartProduct.size}',
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                      Consumer<CartProduct>(
                        builder: (_, cartProduct, __) {
                          if (cartProduct.hasStock)
                            return Text.rich(
                              TextSpan(
                                text:
                                    "\$${cartProduct.unitPrice.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).accentColor,
                                ),
                                children: [
                                  TextSpan(
                                      text: " x${cartProduct.quantity}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ],
                              ),
                            );
                          else
                            return const Text(
                              'Sem estoque suficiente',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(
                builder: (_, cartProduct, __) {
                  return
                      // Column(
                      //   children: <Widget>[
                      //     CustomIconButton(
                      //       iconData: Icons.add,
                      //       // color: Theme.of(context).primaryColor,
                      //       onTap: cartProduct.increment,
                      //     ),
                      //     Text(
                      //       '${cartProduct.quantity}',
                      //       style: const TextStyle(fontSize: 20),
                      //     ),
                      //     CustomIconButton(
                      //       iconData: Icons.remove,
                      //       color: cartProduct.quantity > 1
                      //           ? Colors.black
                      //           : Colors.red,
                      //       onTap: cartProduct.decrement,
                      //     ),
                      //   ],
                      // );
                      Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: cartProduct.increment,
                        child: const Icon(
                          Icons.add_circle_outlined,
                        ),
                      ),
                      SizedBox(height: 12),
                      InkWell(
                        onTap: cartProduct.decrement,
                        child: Icon(
                          Icons.remove_circle_outlined,
                          color: cartProduct.quantity != 1
                              ? null
                              : Colors
                                  .red, //Theme.of(context).accentColor.withOpacity(1),
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
