import 'package:flutter/material.dart';
import 'package:mewnu/common/order/cancel_order_dialog.dart';
// import 'package:mewnu/common/order/export_address_dialog.dart';
import 'package:mewnu/common/order/order_product_tile.dart';
import 'package:mewnu/models/orders/order.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(this.order, {this.showControls = false});

  final Order order;
  final bool showControls;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  order.formattedId,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(
              order.statusText,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: order.status == Status.canceled
                      ? Colors.red
                      : Theme.of(context).accentColor,
                  fontSize: 14),
            )
          ],
        ),
        children: <Widget>[
          Column(
            children: order.items.map((e) {
              return OrderProductTile(e);
            }).toList(),
          ),
          if (showControls && order.status != Status.canceled)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => CancelOrderDialog(order));
                    },
                    child: const Text('Cancelar',
                        style: TextStyle(
                          color: Colors.red,
                        )),
                  ),
                  TextButton(
                    onPressed: order.back,
                    child: const Text('Recuar'),
                  ),
                  TextButton(
                    onPressed: order.advance,
                    child: const Text('Avançar'),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     showDialog(context: context,
                  //       builder: (_) => ExportAddressDialog(order.address)
                  //     );
                  //   },
                  //   child: const Text('Endereço'),
                  // )
                ],
              ),
            )
        ],
      ),
    );
  }
}
