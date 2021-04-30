import 'package:flutter/material.dart';
import 'package:mewnu/models/carts/cart_manager.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({this.onPressed, this.buttonText, this.buttonColor});

  final String buttonText;
  final Color buttonColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    final deliveryPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Resumo do Pedido',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Subtotal'),
                Text('R\$ ${productsPrice.toStringAsFixed(2)}')
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            const Divider(),
            // if (deliveryPrice != null) ...[
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       const Text('Entrega'),
            //       Text('R\$ ${deliveryPrice.toStringAsFixed(2)}')
            //     ],
            //   ),
            //   const Divider(),
            // ],
            // const SizedBox(
            //   height: 12,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     const Text(
            //       'Total',
            //       style: TextStyle(fontWeight: FontWeight.w500),
            //     ),
            //     Text(
            //       'R\$ ${totalPrice.toStringAsFixed(2)}',
            //       style: TextStyle(
            //         color: Theme.of(context).accentColor,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16,
            //       ),
            //     )
            //   ],
            // ),
            // const SizedBox(
            //   height: 8,
            // ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return buttonColor;
                  },
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
