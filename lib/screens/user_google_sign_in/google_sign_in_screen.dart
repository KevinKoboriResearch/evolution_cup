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
    Future.delayed(const Duration(seconds: 5)).then((value) => controller
        .repeat(min: 130, max: 160, period: const Duration(seconds: 1)));
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 64),
              Text(
                'E V O L U T I O N',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'astronaut',
                ),
              ),
              Text(
                'C U P',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'astronaut',
                ),
              ),
              Spacer(flex: 2),
              const Text(
                "Entrar com o google", //'Signin with google',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const Spacer(),
            ],
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
