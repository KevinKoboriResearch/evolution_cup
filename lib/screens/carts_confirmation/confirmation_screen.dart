import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/common/order/order_product_tile.dart';
import 'package:mewnu/models/carts/cart_manager.dart';
import 'package:mewnu/models/orders/order.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen(this.order);

  final Order order;

  @override
  Widget build(BuildContext context) {
    final deliveryPrice = context.watch<CartManager>().deliveryPrice;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Pedido Confirmado'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16),
              const Text(
                "Compra confirmada!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: (28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Registre seu ticket-code em evolutioncup.com.br",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const SizedBox(height: 16),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
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
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     const Text('Entrega'),
                    //     Text('R\$ ${deliveryPrice.toStringAsFixed(2)}')
                    //   ],
                    // ),
                  ],
                ),
              ),
              Column(
                children: order.items.map((e) {
                  return OrderProductTile(
                      e); //CartTile(e,false);//ProductTile(e,false);//
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
