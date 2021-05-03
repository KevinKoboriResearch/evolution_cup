import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/common/custom_icon_button.dart';
import 'package:mewnu/common/empty_card.dart';
import 'package:mewnu/common/order/order_tile.dart';
import 'package:mewnu/models/admin/admin_orders_manager.dart';
import 'package:mewnu/models/orders/order.dart';

class AdminOrdersScreen extends StatefulWidget {
  @override
  _AdminOrdersScreenState createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  PersistentBottomSheetController _controller;
  final _adminOrdersScreenScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminOrdersManager>(
      builder: (_, ordersManager, __) {

        final filteredOrders = ordersManager.filteredOrders;

        return Scaffold(
          key: _adminOrdersScreenScaffoldKey,
          appBar: AppBar(
            elevation: 0,
            title: const Text('Pedidos de Clientes'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,),//_controller != null ? Icons.close : 
              iconSize: 22,
              onPressed: () {
                Navigator.of(context).pop();
                _controller = null;
              },
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if (_controller != null) {
                    _controller.close();
                    _controller = null;
                  }
                  _controller = _adminOrdersScreenScaffoldKey.currentState
                      .showBottomSheet<void>(
                    (BuildContext context) {
                      return Container(
                        height: 250,
                        color: Theme.of(context).accentColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        14.0, 0.0, 12.0, 0.0),
                                    child: Expanded(
                                      child: Row(children: [
                                        const Text(
                                          'Filtros',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              _controller = null;
                                              Navigator.of(context).pop();
                                            }),
                                      ]),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: Status.values.map((s) {
                                      return CheckboxListTile(
                                        title: Text(Order.getStatusText(s),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            )),
                                        dense: true,
                                        activeColor:
                                            Theme.of(context).accentColor,
                                        value: ordersManager.statusFilter
                                            .contains(s),
                                        onChanged: (v) {
                                          _controller.setState(() {
                                            ordersManager.setStatusFilter(
                                                status: s, enabled: v);
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text('Filtros',
                    style: TextStyle(color: Theme.of(context).accentColor)),
              ),
            ],
          ),
          body:
              Column(
            children: <Widget>[
              if (ordersManager.clientFilter != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Pedidos de ${ordersManager.clientFilter.name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      CustomIconButton(
                        iconData: Icons.close,
                        onTap: () {
                          ordersManager.setUserFilter(null);
                        },
                      )
                    ],
                  ),
                ),
              if (filteredOrders.isEmpty)
                const Expanded(
                  child: EmptyCard(
                    title: 'Verifique os filtros!',
                    svgPath: 'assets/mewnu/icons/mewnu_filter.svg',
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                      itemCount: filteredOrders.length,
                      itemBuilder: (_, index) {
                        return OrderTile(
                          filteredOrders[index],
                          showControls: true,
                        );
                      }),
                ),
            ],
          ),
        );
      },
    );
  }
}
