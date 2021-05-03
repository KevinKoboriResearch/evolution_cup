import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/admin/admin_orders_manager.dart';
import 'package:mewnu/screens/companies_company_orders/company_orders_screen.dart';

class AdminClientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Clientes'),
      ),
      body: Consumer<AdminOrdersManager>(
        builder: (_, adminOrdersManager, __) {
          return AlphabetListScrollView(
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  adminOrdersManager.clients[index].name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                subtitle: Text(
                  adminOrdersManager.clients[index].email,
                ),
                onTap: () {
                  context
                      .read<AdminOrdersManager>()
                      .setUserFilter(adminOrdersManager.clients[index]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AdminOrdersScreen()),
                  );
                },
              );
            },
            highlightTextStyle: const TextStyle(
              // color: Colors.white,
              fontSize: 20,
            ),
            indexedHeight: (index) => 80,
            strList: adminOrdersManager.names,
            showPreview: true,
          );
        },
      ),
    );
  }
}
