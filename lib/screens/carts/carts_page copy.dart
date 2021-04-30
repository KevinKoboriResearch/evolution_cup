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
                      // onChanged: (value) => productManager.search = value,
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
              SliverToBoxAdapter(
                child: Consumer<CartManager>(
                  builder: (_, cartManager, __) {
                    return Column(
                      children: cartManager.carts.map((cartCompany) {
                        return MenuTile(
                          cartCompanyId: cartCompany.id,
                          text: "${cartCompany.data()['companyName']}",
                          icon: "assets/icons/cart_icon.svg",
                          label: "${cartCompany.data()['companyName']}",
                          width: 20,
                          press: () async {
                            await context
                                .read<CartManager>()
                                .loadCartItems(cartCompany.id);

                            await company.loadCurrentCompany(cartCompany.id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => CartScreen()),
                            );
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await Flushbar(
      //       title: 'Hey Ninja',
      //       message:
      //           'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
      //       // duration: Duration(seconds: 3),
      //       // title: title,
      // // message: message,
      // flushbarPosition: FlushbarPosition.TOP,
      // flushbarStyle: FlushbarStyle.GROUNDED,
      // isDismissible: true,
      // backgroundColor: Theme.of(context).accentColor,
      // duration: const Duration(seconds: 10),
      // icon: SvgPicture.asset(
      //   'assets/icons/cart_icon.svg',
      //   semanticsLabel: 'Carrinhos',
      //   height: 20,
      //   color: Theme.of(context).canvasColor,
      // ),
      //     ).show(context);
      //   },
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
