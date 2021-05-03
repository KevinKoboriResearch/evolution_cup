import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/products/product_manager.dart';

class SelectProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vincular Produto'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Consumer<ProductManager>(
        builder: (_, productManager, __){
          return ListView.builder(
            itemCount: productManager.companyProducts.length,
            itemBuilder: (_, index){
              final product = productManager.companyProducts[index];
              return ListTile(
                leading: Image.network(product.images.first),
                title: Text(product.name),
                subtitle: Text('R\$ ${product.basePrice.toStringAsFixed(2)}'),
                onTap: (){
                  Navigator.of(context).pop(product);
                },
              );
            },
          );
        },
      ),
    );
  }
}
