import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/companies_categories/categories_screen.dart';
// import 'package:mewnu/screens/companies/company_clients/company_clients_screen.dart';
import 'package:mewnu/screens/companies_company_orders/company_orders_screen.dart';
// import 'package:mewnu/screens/user/sign_in/sign_in_screen.dart';
import 'package:mewnu/models/companies/company.dart';
import 'package:mewnu/screens/user_google_sign_in/google_sign_in_screen.dart';
import 'package:mewnu/common/menu_tile.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/companies/company.dart';
import 'package:mewnu/models/categories/category_manager.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/companies_categories/categories_screen.dart';
import 'package:mewnu/screens/companies_edit_company/edit_company_screen.dart';

class CompanyManagerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Company companyProvider = Provider.of(context, listen: false);
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
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.grey[500],
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (_) => EditProductScreen(null)),
                // );
              },
            ),
          ],
          title: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              '${companyProvider.name}',
              style: TextStyle(fontWeight: FontWeight.bold),
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
                    hintText: "Procurar produto...",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.search)),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              // MenuTile(
              //   text: "Clientes",
              //   icon: 'assets/mewnu/icons/mewnu_users.svg',
              //   label: 'Perfil',
              //   width: 30,
              //   press: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (_) => AdminClientsScreen()),
              //     );
              //   },
              // ),
              // MenuTile(
              //   text: "Pedidos de Clientes",
              //   icon: "assets/icons/cart_icon.svg",
              //   label: 'Perfil',
              //   width: 20,
              //   press: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (_) => AdminOrdersScreen()),
              //     );
              //   },
              // ),
              MenuTile(
                text: "Categorias da Loja",
                icon: "assets/icons/Shop Icon.svg",
                label: 'Perfil',
                width: 20,
                press: () async {
                  companyProvider.setCompany(companyProvider);
                  final CategoryManager categoryManager =
                      Provider.of(context, listen: false);
                  await categoryManager.loadCompanyCategories(companyProvider.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CompanyCategoriesScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
  // return Scaffold(
  //   appBar: AppBar(
  //     title: Text("Profile"),
  //   ),
  //   body: Body(),
  //   // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
  // );
}
