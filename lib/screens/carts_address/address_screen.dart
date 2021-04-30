import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/common/whatsapp_card.dart';
import 'package:mewnu/common/price_card.dart';
import 'package:mewnu/models/carts/cart_manager.dart';
import 'package:mewnu/screens/carts_address/components/address_card.dart';
import 'package:mewnu/screens/carts_checkout/checkout_screen.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          return SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    const Spacer(flex: 2),
                    // Image.asset(
                    //   "assets/gifs/cat/cat_loading_5.gif",
                    //   // height: 50,
                    //   width: MediaQuery.of(context).size.width,
                    //   fit: BoxFit.cover,
                    // ),
                    const Spacer(),
                  ],
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 146,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AddressCard(),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 16),
                        //   child: PriceCard(
                        //     onPressed: cartManager.isAddressValid ? true : false,
                        //     buttonText: cartManager.isAddressValid
                        //         ? 'Continuar no whatsapp'
                        //         : 'Sem estoque suficiente',
                        //     buttonColor: cartManager.isAddressValid
                        //         ? Theme.of(context).accentColor
                        //         : Colors.red,
                        //   ),
                        // ),
                        // const Spacer(),
                        // WhatsappCard(
                        //   buttonText: 'Continuar no whatsapp',
                        //   onPressed: cartManager.isAddressValid ? true : false,
                        // ),
                        //

                        PriceCard(
                          buttonText: 'Continuar para o Pagamento',
                          onPressed: cartManager.isAddressValid
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CheckoutScreen()),
                                  );
                                }
                              : null,
                          buttonColor: cartManager.isAddressValid
                              ? Theme.of(context).accentColor
                              : Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
