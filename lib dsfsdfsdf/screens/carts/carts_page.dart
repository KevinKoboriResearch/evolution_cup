import 'package:flutter/material.dart';
import 'package:mewnu/models/carts/cart_manager.dart';
import 'package:mewnu/screens/carts_cart/cart_screen.dart';
import 'package:mewnu/common/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/common/menu_tile.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/user/components/image_profile_field.dart';
import 'package:mewnu/screens/user_google_sign_in/google_sign_in_screen.dart';
import 'package:mewnu/models/companies/company.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/user/components/image_profile_field.dart';
import 'package:mewnu/screens/user_google_sign_in/google_sign_in_screen.dart';
import 'package:mewnu/models/companies/company.dart';

class CartsPage extends StatefulWidget {
  @override
  _CartsPageState createState() => _CartsPageState();
}

class _CartsPageState extends State<CartsPage> {
  @override
  void initState() {
    context.read<CartManager>().loadCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Company company = Provider.of(context, listen: false);
    return Scaffold(
      body: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Consumer<CartManager>(
            builder: (_, cartManager, __) {
              if (!userManager.isLoggedIn) {
                return GoogleSignInScreen();
              }
              return CustomScrollView(
                slivers: <Widget>[
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    elevation: 0,
                    expandedHeight: 10,
                    toolbarHeight: 40,
                    backgroundColor: Theme.of(context).canvasColor,
                    title: const Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Text(
                        'Sacolas',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SliverAppBar(
                    expandedHeight: 10,
                    toolbarHeight: 48,
                    pinned: true,
                    elevation: 0,
                    backgroundColor: Theme.of(context).canvasColor,
                    leading: Container(),
                    leadingWidth: 0,
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: Container(
                        // width: SizeConfig.screenWidth * 0.64,
                        height: 38,
                        decoration: BoxDecoration(
                          // color: Colors.grey[200],
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          onChanged: (value) => cartManager.search = value,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: "Pesquisar sacola...",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              prefixIcon: const Icon(Icons.search)),
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return MenuTile(
                          cartCompanyId: cartManager.filteredCarts[index].id,
                          text:
                              "${cartManager.filteredCarts[index].data()['companyName']}",
                          icon: "assets/icons/cart_icon.svg",
                          label:
                              "${cartManager.filteredCarts[index].data()['companyName']}",
                          width: 20,
                          press: () async {
                            await context
                                .read<CartManager>()
                                .loadCartItems(cartManager.filteredCarts[index].id);

                            await company.loadCurrentCompany(
                                cartManager.filteredCarts[index].id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => CartScreen()),
                            );
                          },
                        );
                      },
                      childCount: cartManager.carts.length,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
