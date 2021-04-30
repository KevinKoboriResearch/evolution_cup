import 'package:flutter/material.dart';
import 'package:mewnu/common/empty_card.dart';
import 'package:mewnu/common/login_card.dart';
import 'package:mewnu/common/order/order_tile.dart';
import 'package:mewnu/models/orders/orders_manager.dart';
import 'package:provider/provider.dart';

class UserOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Pedidos'),
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __){
          if(ordersManager.user == null){
            return LoginCard();
          }
          if(ordersManager.orders.isEmpty){
            return const EmptyCard(
              title: 'Nenhuma compra encontrada!',
              svgPath: 'assets/mewnu/icons/mewnu_filter.svg',
            );
          }
          return ListView.builder(
            itemCount: ordersManager.orders.length,
            itemBuilder: (_, index){
              return OrderTile(
                ordersManager.orders.reversed.toList()[index]
              );
            }
          );
        },
      ),
    );
  }
}
