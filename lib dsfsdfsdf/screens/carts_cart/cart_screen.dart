import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/common/empty_card.dart';
import 'package:mewnu/common/login_card.dart';
import 'package:mewnu/common/price_card.dart';
import 'package:mewnu/models/carts/cart_manager.dart';
import 'package:mewnu/screens/carts_address/address_screen.dart';
import 'package:mewnu/screens/carts_cart/components/cart_tile.dart';
import 'package:social_share/social_share.dart';
import 'package:mewnu/models/companies/company.dart';
import 'package:flutter/material.dart';
import 'package:mewnu/screens/carts_cart/cart_screen.dart';
import 'package:mewnu/common/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/common/menu_tile.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/user/components/image_profile_field.dart';
import 'package:mewnu/screens/user_google_sign_in/google_sign_in_screen.dart';
import 'package:mewnu/models/companies/company.dart';

class CartScreen extends StatelessWidget {
  // const CartScreen(this.company);
  // final Company company;
  @override
  Widget build(BuildContext context) {
    final Company companyProvider = Provider.of(context, listen: false);

    // companyProvider.setCompany(company);
    return Consumer<CartManager>(
      builder: (_, cartManager, __) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Sacola / ${companyProvider.name}",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 2),
                        Text(
                          cartManager.items.length == 1
                              ? '${cartManager.items.length} item'
                              : '${cartManager.items.length} itens',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: cartManager.items.isEmpty
                    ? const EmptyCard(
                        title: 'Sua sacola está vazia',
                        svgPath: 'assets/icons/cart_icon.svg',
                      )
                    : SafeArea(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height - 144,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // TextButton(
                                //   onPressed: () async {
                                //     SocialShare.shareWhatsapp("Mewnu");
                                //   },
                                //   child:Text('Compartilhar')
                                // ),
                                Column(
                                  children: cartManager.items
                                      .map((cartProduct) =>
                                          CartTile(cartProduct, true))
                                      .toList(),
                                ),
                                // const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: PriceCard(
                                    onPressed: cartManager.isCartValid
                                        ? () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      AddressScreen()),
                                            );
                                          }
                                        : null,
                                    buttonText: cartManager.isCartValid
                                        ? 'Continuar para Entrega'
                                        : 'Sem estoque suficiente',
                                    buttonColor: cartManager.isCartValid
                                        ? Theme.of(context).accentColor
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
