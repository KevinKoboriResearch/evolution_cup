import 'package:flutter/material.dart';
import 'package:mewnu/models/current_product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mewnu/router/app_state.dart';
import 'package:mewnu/router/animations/fade_animation_page.dart';
import 'package:mewnu/router/routes.dart';
import 'package:mewnu/screens/carts/carts_page.dart';
import 'package:mewnu/screens/favorites/favorites_page.dart';
import 'package:mewnu/screens/companies_manager/companies_manager_page.dart';
import 'package:mewnu/screens/search/search_page.dart';
import 'package:mewnu/screens/user/user_page.dart';

class InnerRouterDelegate extends RouterDelegate<MewnuRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MewnuRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  MewnuAppState get appState => _appState;
  MewnuAppState _appState;
  set appState(MewnuAppState value) {
    if (value == _appState) {
      return;
    }
    _appState = value;
    notifyListeners();
  }

  InnerRouterDelegate(this._appState);
  //     AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
  //     AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
  //     AppRoutes.CART: (ctx) => CartScreen(),
  //     AppRoutes.ORDERS: (ctx) => OrdersScreen(),
  //     AppRoutes.PRODUCTS: (ctx) => ProductsScreen(),
  //     AppRoutes.PRODUCT_FORM: (ctx) => ProductFormScreen(),
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (appState.selectedIndex == 0)
          FadeAnimationPage(
            child:
                SearchPage(), //Center(child: Container(child: Text('home'),)),//HomePage(),
            key: const ValueKey('SearchPage'),
          )
        //   ...[
        //   FadeAnimationPage(
        //     child: AllProductsListScreen(
        //       products: appState.listProductsProvider,
        //       onTapped: _handleProductTapped,
        //     ),
        //     key: ValueKey('UsersListPage'),
        //   ),
        //   if (appState.selectedProduct != null)
        //     MaterialPage(
        //       key: ValueKey(appState.selectedProduct),
        //       child: ProductDetailsScreen(product: appState.selectedProduct),
        //     ),
        // ]
        // else if (appState.selectedIndex == 1)
        //   FadeAnimationPage(
        //     child:
        //         FavoritesPage(), //Center(child: Container(child: Text('favorites'),)),//FavoritesPage(),
        //     key: ValueKey('FavoritesPage'),
        //   ),
        else if (appState.selectedIndex == 1)
          FadeAnimationPage(
            child: Center(
                child: Container(
              child: Text('Em Breve'),
            )), //CartsPage(), //
            key: const ValueKey('cartsPage'),
          ),
        if (appState.selectedIndex == 2)
          FadeAnimationPage(
            child: Center(
                child: Container(
              child: Text('Em Breve'),
            )), //CompaniesManagerPage(),
            key: const ValueKey('storePage'),
          ),
        if (appState.selectedIndex == 3)
          FadeAnimationPage(
            child:
                UserPage(), //Center(child: Container(child: Text('profile'),)),//ProfilePage(),
            key: const ValueKey('profilePage'),
          ),
      ],
      onPopPage: (route, result) {
        appState.selectedProduct = null;
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(MewnuRoutePath path) async {
    // This is not required for inner router delegate because it does not
    // parse route
    assert(false);
  }

  void _handleProductTapped(Product product) {
    appState.selectedProduct = product;
    notifyListeners();
  }
}
