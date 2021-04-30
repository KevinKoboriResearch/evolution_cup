import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mewnu/router/app_state.dart';
import 'package:mewnu/router/inner_router_delegate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mewnu/screens/user_orders/user_orders_screen.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/services.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:mewnu/models/page_manager.dart';
// import 'package:mewnu/models/user_manager.dart';
// import 'package:mewnu/screens/admin_orders/admin_orders_screen.dart';
// import 'package:mewnu/screens/admin_users/admin_users_screen.dart';
// import 'package:mewnu/screens/categories/categories_screen.dart';
// import 'package:mewnu/screens/orders/orders_screen.dart';
// import 'package:mewnu/screens/products/products_screen.dart';
// import 'package:mewnu/screens/stores/stores_screen.dart';
import 'package:mewnu/screens/companies_company_clients/company_clients_screen.dart';

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

class AppShell extends StatefulWidget {
  final MewnuAppState appState;

  const AppShell({
    @required this.appState,
  });

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  InnerRouterDelegate _routerDelegate;
  ChildBackButtonDispatcher _backButtonDispatcher;

  void initState() {
    super.initState();
    _routerDelegate = InnerRouterDelegate(widget.appState);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // configFCM();
  }

  @override
  void didUpdateWidget(covariant AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.appState = widget.appState;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        .createChildBackButtonDispatcher();
  }

  // void configFCM() {
  //   if (Platform.isIOS) {
  //     FirebaseMessaging.instance
  //         .requestPermission(); //.then((value) => null);//requestNotificationPermissions(
  //     // const IosNotificationSettings(provisional: true));
  //     // //OR
  //     // setForegroundNotificationPresentationOptions(
  //     //   alert: true,
  //     //   badge: true,
  //     //   sound: true,
  //     // );
  //   }

  //   // fcm.configure(onLaunch: (Map<String, dynamic> message) async {
  //   //   print('onLaunch $message');
  //   //   if (message['notification']['dataType'] == 'onNewOrder') {
  //   //     Navigator.push(
  //   //       context,
  //   //       MaterialPageRoute(builder: (_) => AdminClientsScreen()),
  //   //     );
  //   //   } else if (message['notification']['dataType'] ==
  //   //       'onOrderStatusChanged') {
  //   //     Navigator.push(
  //   //       context,
  //   //       MaterialPageRoute(builder: (_) => UserOrdersScreen()),
  //   //     );
  //   //   }
  //   // }, onResume: (Map<String, dynamic> message) async {
  //   //   print('onResume $message');
  //   //   if (message['notification']['dataType'] == 'onNewOrder') {
  //   //     Navigator.push(
  //   //       context,
  //   //       MaterialPageRoute(builder: (_) => AdminClientsScreen()),
  //   //     );
  //   //   } else if (message['notification']['dataType'] ==
  //   //       'onOrderStatusChanged') {
  //   //     Navigator.push(
  //   //       context,
  //   //       MaterialPageRoute(builder: (_) => UserOrdersScreen()),
  //   //     );
  //   //   }
  //   // }, onMessage: (Map<String, dynamic> message) async {
  //   //   print('onMessage $message');
  //   //   showNotification(
  //   //     message['notification']['title'] as String,
  //   //     message['notification']['body'] as String,
  //   //   );
  //   //   //inserir na colecao de notificacoes do firestore
  //   // });
  //   // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   //   print('onMessage $message');
  //   //   showNotification(
  //   //     message
  //   //     message['notification']['title'] as String,
  //   //     message['notification']['body'] as String,
  //   //   );
  //   //   //inserir na colecao de notificacoes do firestore
  //   // });


  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification notification = message.notification;
  //     AndroidNotification android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       flutterLocalNotificationsPlugin.show(
  //           notification.hashCode,
  //           notification.title,
  //           notification.body,
  //           NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               channel.id,
  //               channel.name,
  //               channel.description,
  //               // TODO add a proper drawable resource to android, for now using
  //               //      one that already exists in example app.
  //               icon: 'launch_background',
  //             ),
  //           ));
  //     }
  //   });

  //   // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

  //   // FirebaseMessaging.onBackgroundMessage((message) {
  //   //   return;
  //   // });
  // }

  void showNotification(String title, String message) {
    Flushbar(
      title: title,
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      isDismissible: true,
      backgroundColor: Theme.of(context).accentColor,
      duration: const Duration(seconds: 10),
      icon: SvgPicture.asset(
        'assets/icons/cart_icon.svg',
        semanticsLabel: 'Sacolas',
        height: 20,
        color: Theme.of(context).canvasColor,
      ),
      // Icon(
      //   Icons.shopping_cart,
      //   color: Colors.white,
      // ),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    var appState = widget.appState;

    // Claim priority, If there are parallel sub router, you will need
    // to pick which one should take priority;
    _backButtonDispatcher.takePriority();

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Router(
            routerDelegate: _routerDelegate,
            backButtonDispatcher: _backButtonDispatcher,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        // height: 50,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          iconSize: 30.0,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/search_icon.svg',
                semanticsLabel: 'Pesquisar',
                height: appState.selectedIndex == 0 ? 18 : 16,
                color: appState.selectedIndex == 0
                    ? Theme.of(context).accentColor
                    : Colors.grey[400],
              ),
              label: 'Pesquisar',
            ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset(
            //     'assets/icons/Heart Icon.svg',
            //     semanticsLabel: 'Favoritos',
            //     height: appState.selectedIndex == 1 ? 22 : 18,
            //     color: appState.selectedIndex == 1
            //         ? Colors.black
            //         : Colors.grey[400],
            //   ),
            //   label: 'Favoritos',
            // ),

            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/Bell.svg',
                semanticsLabel: '...',
                height: appState.selectedIndex == 1 ? 24 : 20,
                color: appState.selectedIndex == 1
                    ? Theme.of(context).accentColor
                    : Colors.grey[400],
              ),
              label: 'Minhas Sacolas',
            ),
            BottomNavigationBarItem(
              // backgroundColor: Colors.black,
              icon: SvgPicture.asset(
                'assets/icons/Mail.svg',
                semanticsLabel: '...',
                height: appState.selectedIndex == 2 ? 22 : 18,
                color: appState.selectedIndex == 2
                    ? Theme.of(context).accentColor
                    : Colors.grey[400],
              ),
              label: 'Minhas Lojas',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/User.svg',
                semanticsLabel: 'Meu Perfil',
                height: appState.selectedIndex == 3 ? 22 : 18,
                color: appState.selectedIndex == 3
                    ? Theme.of(context).accentColor
                    : Colors.grey[400],
              ),
              label: 'Meu Perfil',
            ),
          ],
          currentIndex: appState.selectedIndex.toInt(),
          onTap: (newIndex) {
            appState.selectedIndex = newIndex.toDouble();
            // });
          },
        ),
      ),
    );
  }
}
