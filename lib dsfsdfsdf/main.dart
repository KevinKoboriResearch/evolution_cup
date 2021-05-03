import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mewnu/models/admin/admin_orders_manager.dart';
import 'package:mewnu/models/carts/cart_manager.dart';
import 'package:mewnu/models/companies/company.dart';
import 'package:mewnu/models/companies/company_manager.dart';
import 'package:mewnu/models/categories/category.dart';
import 'package:mewnu/models/categories/category_manager.dart';
import 'package:mewnu/models/home/home_manager.dart';
import 'package:mewnu/models/orders/orders_manager.dart';
import 'package:mewnu/models/products/product_manager.dart';
import 'package:mewnu/models/store/stores_manager.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/app/router/route_information_parser.dart';
import 'package:mewnu/app/router/router_delegate.dart';
import 'package:mewnu/theme.dart';
// /// Define a top-level named handler which background/terminated messages will
// /// call.
// ///
// /// To verify things are working, check out the native platform logs.
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

// /// Create a [AndroidNotificationChannel] for heads up notifications
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );

// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
void main() async {
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  //

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MewnuRouterDelegate _routerDelegate = MewnuRouterDelegate();
  MewnuRouteInformationParser _routeInformationParser =
      MewnuRouteInformationParser();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      // statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      // systemNavigationBarIconBrightness: Brightness.dark,
      // systemNavigationBarColor: Colors.green,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => Company(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CompanyManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => Category(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => StoresManager(),
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (ctx, userManager, ordersManager) =>
              ordersManager..updateUser(ctx, userManager),
        ),
        // ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
        //   create: (_) => AdminOrdersManager(),
        //   lazy: false,
        //   update: (ctx, userManager, adminOrdersManager) => adminOrdersManager
        //     ..updateUserAdmin(ctx, userManager),
        // ),
        ChangeNotifierProxyProvider<Company, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          lazy: false,
          update: (ctx, company, adminOrdersManager) =>
              adminOrdersManager..updateCompanyAdmin(ctx, company),
        ),
      ],
      child: MaterialApp.router(
        // navigatorKey: navigatorKey,
        // theme: ThemeData(
        //   primaryColor: Colors.black,
        //   accentColor: Colors.grey,
        //   canvasColor: Colors.white,
        //   fontFamily: 'Lato',
        //   pageTransitionsTheme: PageTransitionsTheme(
        //     builders: {
        //       TargetPlatform.android: CustomPageTransitionsBuilder(),
        //       TargetPlatform.iOS: CustomPageTransitionsBuilder(),
        //     },
        //   ),
        // ),
        //
        //
        theme: theme(),
        //   theme: ThemeData(
        //     pageTransitionsTheme: PageTransitionsTheme(
        //       builders: {
        //         TargetPlatform.android: CustomPageTransitionsBuilder(),
        //         TargetPlatform.iOS: CustomPageTransitionsBuilder(),
        //       },
        //     ),
        //     appBarTheme: AppBarTheme(
        //       centerTitle: false,
        //       color: Colors.white,
        //       elevation: 0,
        //       brightness: Brightness.light,
        //       iconTheme: IconThemeData(color: Colors.black),
        //       textTheme: TextTheme(
        //         headline6: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        //       ),
        //     ),
        //     brightness: Brightness.light,
        //     canvasColor: Colors.white,
        //     primaryColor: Colors.black,
        //     accentColor: Colors.pinkAccent,
        //     // disabledColor: Colors.red,
        //     cardColor: Colors.white, //.grey[200],
        //     buttonColor: Colors.cyan,
        //     // buttonTheme: ButtonThemeData(),
        //     // cursorColor: Colors.red,
        //     // textSelectionColor: Colors.red,
        //     // indicatorColor: Colors.red,
        //     // highlightColor: Colors.red,
        //     // appBarTheme: AppBarTheme(backgroundColor: Colors.white, foregroundColor: Colors.red),
        //   ),
        debugShowCheckedModeBanner: false,
        title: 'Mewnu',
        routerDelegate: _routerDelegate,
        routeInformationParser: _routeInformationParser,
      ),

      // child: MaterialApp(
      //   title: 'Mewnu',
      //   debugShowCheckedModeBanner: false,
      //   // theme: ThemeData(
      //   //   primaryColor: const Color.fromARGB(255, 4, 125, 141),
      //   //   scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
      //   //   appBarTheme: const AppBarTheme(
      //   //     elevation: 0
      //   //   ),
      //   //   visualDensity: VisualDensity.adaptivePlatformDensity,
      //   // ),
      //   theme: ThemeData(
      //     pageTransitionsTheme: PageTransitionsTheme(
      //       builders: {
      //         TargetPlatform.android: CustomPageTransitionsBuilder(),
      //         TargetPlatform.iOS: CustomPageTransitionsBuilder(),
      //       },
      //     ),
      //     brightness: Brightness.light,
      //     canvasColor: Colors.white,
      //     primaryColor: Colors.white,
      //     accentColor: Colors.pinkAccent,
      //     // disabledColor: Colors.red,
      //     cardColor: Colors.white, //.grey[200],
      //     buttonColor: Colors.cyan,
      //     // buttonTheme: ButtonThemeData(),
      //     // cursorColor: Colors.red,
      //     // textSelectionColor: Colors.red,
      //     // indicatorColor: Colors.red,
      //     // highlightColor: Colors.red,
      //     // appBarTheme: AppBarTheme(backgroundColor: Colors.white, foregroundColor: Colors.red),
      //   ),
      //   onGenerateRoute: (settings) {
      //     switch (settings.name) {
      //       case '/company/categories':
      //         return MaterialPageRoute(
      //             builder: (_) => CompanyCategoriesScreen());
      //       case '/company/products':
      //         return MaterialPageRoute(builder: (_) => CompanyProductsScreen());
      //       case '/user/orders':
      //         return MaterialPageRoute(builder: (_) => UserOrdersScreen());
      //       case '/company/store-locations':
      //         return MaterialPageRoute(
      //             builder: (_) => CompanyStoresLocationsScreen());
      //       case '/company/admin-users':
      //         return MaterialPageRoute(builder: (_) => AdminUsersScreen());
      //       case '/company/admin-orders':
      //         return MaterialPageRoute(builder: (_) => AdminOrdersScreen());
      //       case '/login':
      //         return MaterialPageRoute(builder: (_) => LoginScreen());
      //       case '/signup':
      //         return MaterialPageRoute(builder: (_) => SignUpScreen());
      //       case '/product':
      //         return MaterialPageRoute(
      //             builder: (_) => ProductScreen(settings.arguments as Product));
      //       case '/cart':
      //         return MaterialPageRoute(
      //             builder: (_) => CartScreen(), settings: settings);
      //       case '/address':
      //         return MaterialPageRoute(builder: (_) => AddressScreen());
      //       case '/checkout':
      //         return MaterialPageRoute(builder: (_) => CheckoutScreen());
      //       case '/edit_product':
      //         return MaterialPageRoute(
      //             builder: (_) =>
      //                 EditProductScreen(settings.arguments as Product));
      //       case '/select_product':
      //         return MaterialPageRoute(builder: (_) => SelectProductScreen());
      //       case '/confirmation':
      //         return MaterialPageRoute(
      //             builder: (_) =>
      //                 ConfirmationScreen(settings.arguments as Order));
      //       case '/store':
      //       default:
      //         return MaterialPageRoute(
      //             builder: (_) => BaseScreen(), settings: settings);
      //     }
      //   },
      // ),
    );
  }
}
