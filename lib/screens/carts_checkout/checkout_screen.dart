import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/common/price_card.dart';
import 'package:mewnu/models/carts/cart_manager.dart';
import 'package:mewnu/models/checkout/checkout_manager.dart';
import 'package:mewnu/models/checkout/credit_card.dart';
import 'package:mewnu/models/orders/order.dart';
import 'package:mewnu/screens/carts_cart/cart_screen.dart';
import 'package:mewnu/screens/carts_checkout/components/cpf_field.dart';
import 'package:mewnu/screens/carts_checkout/components/credit_card_widget.dart';
import 'package:mewnu/screens/carts_confirmation/confirmation_screen.dart';
import 'package:mewnu/models/companies/company.dart';

class CheckoutScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final CreditCard creditCard = CreditCard();

  @override
  Widget build(BuildContext context) {
    final Company company = Provider.of(context, listen: false);
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Pagamento'),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Consumer<CheckoutManager>(
            builder: (_, checkoutManager, __) {
              if (checkoutManager.loading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Processando seu pagamento...',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                );
              }

              return Form(
                key: formKey,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 144,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CreditCardWidget(creditCard),
                          CpfField(),
                          const Spacer(),
                          PriceCard(
                            buttonColor: Theme.of(context).accentColor,
                            buttonText: 'Finalizar Pedido',
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                print(
                                    '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${company.name}');
                                checkoutManager.checkout(
                                  // context: context,
                                    companyId: company.id,
                                    creditCard: creditCard,
                                    onStockFail: (e) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => CartScreen()),
                                      );
                                    },
                                    onPayFail: (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('$e'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    },
                                    onSuccess: (order) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ConfirmationScreen(
                                                order as Order)),
                                      );
                                      // Navigator.of(context).popUntil(
                                      //     (route) => route.settings.name == '/');
                                      // Navigator.of(context).pushNamed('/confirmation',
                                      //     arguments: order);
                                      //
                                    });
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
