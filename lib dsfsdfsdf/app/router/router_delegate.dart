import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mewnu/app/router/app_state.dart';
import 'package:mewnu/app/app_shell.dart';
import 'package:mewnu/app/router/routes.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mewnu/providers/google_sign_in.dart';
// import 'package:mewnu/widgets/sign_up_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// Stack(
//       fit: StackFit.expand,
//       children: [
//         Center(child: CircularProgressIndicator()),
//       ],
//     );
// import 'package:mewnu/widgets/global/build_loading.dart';

class MewnuRouterDelegate extends RouterDelegate<MewnuRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MewnuRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  MewnuAppState appState = MewnuAppState();

  MewnuRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  MewnuRoutePath get currentConfiguration {
    if (appState.selectedProduct != null) {
      return ProductDetailsPath(appState.getSelectedProductById());
      // }
      // else if (appState.selectedStoreForm != null) {
      //   return ProductDetailsPath(appState.getSelectedUserById());
      // }
      // else if (appState.selectedCart != null) {
      //   return ProductDetailsPath(appState.getSelectedUserById());
      // }
      // else if (appState.selectedProfileConfig != null) {
      //   return ProductDetailsPath(appState.getSelectedUserById());
    } else {
      if (appState.selectedIndex == 0) {
        return SearchPath();
      } else if (appState.selectedIndex == 1) {
        return FavoritesPath();
      } else if (appState.selectedIndex == 2) {
        return StorePath();
      } else if (appState.selectedIndex == 3) {
        return CartsPath();
      } else if (appState.selectedIndex == 4) {
        return ProfilePath();
      } else {
        return Error404Path();
      }
    }
  }

  Widget build(BuildContext context) => Scaffold(
        body: Navigator(
          key: navigatorKey,
          pages: [
            MaterialPage(
              child: AppShell(appState: appState),
            ),
          ],
          onPopPage: (route, result) {
            if (!route.didPop(result)) {
              return true;
            }

            if (appState.selectedProduct != null) {
              appState.selectedProduct = null;
            }
            notifyListeners();
            return true;
          },
        ),
//         ChangeNotifierProvider(
//           create: (context) => GoogleSignInProvider(),
//           child: kIsWeb
//               ? FutureBuilder(
//                   future: Future.delayed(Duration(milliseconds: 1000))
//                       .then((_) => FirebaseAuth.instance.authStateChanges()),
//                   builder: (context, snapshot) {
//                     return StreamBuilder(
//                       stream: FirebaseAuth.instance.authStateChanges(),
//                       builder: (context, snapshot) {
//                         final provider =
//                             Provider.of<GoogleSignInProvider>(context);
// // appState.selectedIndex =null;
//                         if (provider.isSigningIn) {
//                           return buildLoading();
//                         } else if (!snapshot.hasData) {
//                           return SignUpWidget();
//                         } else {
//                           if (appState.selectedIndex == null) {
//                             appState.selectedIndex = 0;
//                           }
//                           return Navigator(
//                             key: navigatorKey,
//                             pages: [
//                               MaterialPage(
//                                 child: AppShell(appState: appState),
//                               ),
//                             ],
//                             onPopPage: (route, result) {
//                               if (!route.didPop(result)) {
//                                 return true;
//                               }

//                               if (appState.selectedProduct != null) {
//                                 appState.selectedProduct = null;
//                               }
//                               notifyListeners();
//                               return true;
//                             },
//                           );
//                         }
//                       },
//                     );
//                   },
//                 )
//               : StreamBuilder(
//                   stream: FirebaseAuth.instance.authStateChanges(),
//                   builder: (context, snapshot) {
//                     final provider = Provider.of<GoogleSignInProvider>(context);
// // appState.selectedIndex =null;
//                     if (provider.isSigningIn) {
//                       return buildLoading();
//                     } else if (!snapshot.hasData) {
//                       return SignUpWidget();
//                     } else {
//                       if (appState.selectedIndex == null) {
//                         appState.selectedIndex = 0;
//                       }
//                       return Navigator(
//                         key: navigatorKey,
//                         pages: [
//                           MaterialPage(
//                             child: AppShell(appState: appState),
//                           ),
//                         ],
//                         onPopPage: (route, result) {
//                           if (!route.didPop(result)) {
//                             return true;
//                           }

//                           if (appState.selectedProduct != null) {
//                             appState.selectedProduct = null;
//                           }
//                           notifyListeners();
//                           return true;
//                         },
//                       );
//                     }
//                   },
//                 ),
//         ),
      );

  @override
  Future<void> setNewRoutePath(MewnuRoutePath path) async {
    if (path is SearchPath) {
      appState.selectedIndex = 0;
      appState.selectedProduct = null;
    } else if (path is FavoritesPath) {
      appState.selectedIndex = 1;
    } else if (path is StorePath) {
      appState.selectedIndex = 2;
    } else if (path is CartsPath) {
      appState.selectedIndex = 3;
    } else if (path is ProfilePath) {
      appState.selectedIndex = 4;
    } else if (path is ProductDetailsPath) {
      appState.setSelectedUserById(path.id);
    }
  }
}
