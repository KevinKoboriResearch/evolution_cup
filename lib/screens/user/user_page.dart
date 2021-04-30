import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/common/menu_tile.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/user/components/image_profile_field.dart';
// import 'package:mewnu/screens/user/sign_in/sign_in_screen.dart';
import 'package:mewnu/screens/user_google_sign_in/google_sign_in_screen.dart';
import 'package:mewnu/screens/user_orders/user_orders_screen.dart';

class UserPage extends StatefulWidget {

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
// var ipa = InstaPublicApi('kevinkobori');
// var info;
// var timelinePosts;
// var posts;
// getIstaStatus() async {
//   info = await ipa.getBasicInfo();
//   timelinePosts = await ipa.getTimelinePosts();
//   posts = await ipa.getAllPosts();
// }
  @override
  void initState() {
    super.initState();
    // getIstaStatus();
  }
  Widget build(BuildContext context) {
    return Consumer<UserManager>(
      builder: (_, userManager, __) {
        if (!userManager.isLoggedIn) {
          return GoogleSignInScreen();
        }
         if (userManager.loading) {
          return const CircularProgressIndicator();
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
              centerTitle: true,
              backgroundColor: Theme.of(context).canvasColor,
              title: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  'Perfil',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // Text('Posts: ${info.noOfPosts ?? null}'),
// Text('Followers: ${info.followers ?? null}'),
// Text('Following: ${info.following ?? null}'),
                  ImageProfileField(),
                  const SizedBox(height: 20),
                  Text(userManager.user.name),
                  const SizedBox(height: 8),
                  const Text(
                    'Lojas',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  userManager.user.companiesAdmin.isNotEmpty
                      ? Text(
                          userManager.user.companiesAdmin[0].toString(),
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        )
                      // userManager.user.companiesAdmin.map((e) {
                      //     return Text(e
                      //         .toString()); //Text(userManager.user.companiesAdmin.map((e) => null).toString())
                      //   }).toList() as List<Widget>
                      : const Text('...'),
                  // userManager.user.companiesAdmin != null
                  //     ? SizedBox(height: 20)
                  //     : SizedBox(height: 20),
                  SizedBox(height: 20),
                  // MenuTile(
                  //   text: "Conta",
                  //   icon: 'assets/ui_icons/svg/097-user.svg',
                  //   label: 'Perfil',
                  //   width: 15,
                  //   press: () => {},
                  // ),
                  // MenuTile(
                  //   text: "Notificações",
                  //   icon: "assets/icons/Bell.svg",
                  //   label: 'Perfil',
                  //   width: 15,
                  //   press: () {},
                  // ),
                  // MenuTile(
                  //   text: "Pedidos",
                  //   icon: "assets/icons/cart_icon.svg",
                  //   label: 'Perfil',
                  //   width: 20,
                  //   press: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (_) => UserOrdersScreen()),
                  //     );
                  //   },
                  // ),
                  // MenuTile(
                  //   text: "Configurações",
                  //   icon: "assets/icons/Settings.svg",
                  //   label: 'Perfil',
                  //   width: 20,
                  //   press: () {},
                  // ),
                  // MenuTile(
                  //   text: "Central de Atendimento",
                  //   icon: "assets/icons/Question mark.svg",
                  //   label: 'Perfil',
                  //   width: 20,
                  //   press: () {},
                  // ),
                  MenuTile(
                    text: "Sair",
                    icon: "assets/icons/Log out.svg",
                    label: 'Sair',
                    width: 18,
                    press: () {
                      if (userManager.isLoggedIn) {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (_) => CompanyCategoriesScreen()),
                        // );
                        userManager.signOut();
                      } else {
                        Navigator.of(context).pushNamed('/login');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
// return Text('oi');
  }
  // return Scaffold(
  //   appBar: AppBar(
  //     title: Text("Profile"),
  //   ),
  //   body: Body(),
  //   // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
  // );
}
