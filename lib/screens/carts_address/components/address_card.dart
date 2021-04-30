import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/checkout/address.dart';
import 'package:mewnu/models/carts/cart_manager.dart';
import 'package:mewnu/screens/carts_address/components/address_input_field.dart';
import 'package:mewnu/screens/carts_address/components/cep_input_field.dart';

class AddressCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Consumer<CartManager>(
        builder: (_, cartManager, __){
          final address = cartManager.address ?? Address();

          return Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Endereço de Entrega',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                CepInputField(address),
                AddressInputField(address),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
