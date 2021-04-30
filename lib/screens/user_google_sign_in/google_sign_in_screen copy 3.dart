import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

// class GoogleSignInScreen extends StatelessWidget {
class GoogleSignInScreen extends StatefulWidget {
  @override
  _GoogleSignInScreenState createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  // var page;
  Widget google = Image.asset(
    "assets/gifs/google/google.gif",
    height: 200,
    width: 200,
  );

  @override
  void initState() {
    // Future.delayed(Duration(milliseconds: 1000)).then((value) {
    //   google = Image.asset(
    //     "assets/gifs/google/google_sea.gif",
    //     height: 200,
    //     width: 200,
    //   );
    // });
    super.initState();
  }

  // start() async {
  //   await Future.delayed(Duration(milliseconds: 1000))
  //       .then((value) => FirebaseAuth.instance.authStateChanges());
  // }

  @override
  Widget build(BuildContext context) {
    final userManager = Provider.of<UserManager>(context, listen: false);

    return Stack(
      fit: StackFit.expand,
      children: [
        InkWell(
          // style: ButtonStyle(
          //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
          //     (Set<MaterialState> states) {
          //       if (states.contains(MaterialState.pressed))
          //         return Colors.blue;
          //       return Colors
          //           .white; //Color(0xffDDDDDD); // Use the component's default.
          //     },
          //   ),
          // ),
          onTap: () async {
            await userManager.signIn(context);
          },
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          // overlayColor: Colors.transparent,
          highlightColor: Colors.transparent,
          // color
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 64),
              Text(
                'M E W N U',
                style: TextStyle(
                  // depth: 1,
                  color: Colors.black,
                  fontSize: 14,
                  // fontFamily: 'anurati',
                ),
              ),
              Spacer(flex: 2),
              google,
              const Text(
                "Entrar com o google", //'Signin with google',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
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
