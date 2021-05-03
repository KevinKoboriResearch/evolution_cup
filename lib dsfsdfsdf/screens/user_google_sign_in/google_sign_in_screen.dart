import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

// class GoogleSignInScreen extends StatelessWidget {
class GoogleSignInScreen extends StatefulWidget {
  @override
  _GoogleSignInScreenState createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen>
    with TickerProviderStateMixin {
  GifController controller;
  @override
  void initState() {
    super.initState();
    google();
    controller = GifController(vsync: this);
    controller.repeat(min: 0, max: 200, period: const Duration(seconds: 6));
    Future.delayed(const Duration(seconds: 5)).then((value) => controller.repeat(
        min: 130,
        max: 160,
        period: const Duration(seconds: 1)));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  ImageProvider<Object> google() {
    return const AssetImage(
      "assets/gifs/google/google.gif",
    );
  }

  @override
  Widget build(BuildContext context) {
    final userManager = Provider.of<UserManager>(context, listen: false);

    return Stack(
      fit: StackFit.expand,
      children: [
        InkWell(
          onTap: () async {
            await userManager.signIn(context);
          },
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
          color:Colors.white30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 64),
                Text(
                  'M E W N U',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'anurati',
                  ),
                ),
                const Spacer(flex: 2),
                SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                  child: GifImage(
                    controller: controller,
                    image: google(),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        // Center(
        //     child: Padding(
        //   padding: const EdgeInsets.only(top: 64.0),
        //   child: Text(
        //     'Clique na tela',
        //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        //   ),
        // )),
      ],
    );
  }
}
