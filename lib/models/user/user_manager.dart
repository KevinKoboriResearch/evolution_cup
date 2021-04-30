import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:mewnu/helpers/firebase_errors.dart';
import 'user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
// import 'package:remottely/utils/constants.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:remottely/functions/get_initials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:remottely/providers/google_sign_in.dart';
import 'package:provider/provider.dart';

// import 'package:remottely/widgets/dialog.dart';
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
class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  UserModel user;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _loadingFace = false;
  bool get loadingFace => _loadingFace;
  set loadingFace(bool value) {
    _loadingFace = value;
    notifyListeners();
  }

  bool get isLoggedIn => user != null;

  // Future<void> signIn(
  //     {UserModel user, Function onFail, Function onSuccess}) async {
  //   loading = true;
  //   try {
  //     final UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: user.email, password: user.password);

  //     await _loadCurrentUser(firebaseUser: result.user);

  //     onSuccess();
  //   } on PlatformException catch (e) {
  //     onFail(getErrorString(e.code));
  //   }
  //   loading = false;
  // }
  Future<void> signIn(BuildContext context) async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return;
    } else {
      _loading = true;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (result.additionalUserInfo.isNewUser) {
        // Future<ui.Image> _getImage(String urlImage) async {
        //   Completer<ui.Image> completer = Completer<ui.Image>();
        //   NetworkImage(urlImage)
        //       .resolve(ImageConfiguration())
        //       .addListener(ImageStreamListener((ImageInfo info, bool _) {
        //     completer.complete(info.image);
        //   }));
        //   return completer.future;
        // }

        // var userImage = await _getImage(result.user.photoURL);

        UserModel userModel = new UserModel();
        userModel.id = result.user.uid;
        this.user = userModel;

        userModel.name = result.user.displayName;
        userModel.email = result.user.email;
        userModel.password = '';
        userModel.companiesAdmin = [];
        userModel.cpf = '';
        userModel.imageProfile = result.user.photoURL;

        await userModel.saveData();

        userModel.saveToken();
      } else {
        await _loadCurrentUser();
      }

      _loading = false;
    }
  }

  Future<void> signOut() async {
    await googleSignIn.disconnect();
    // FirebaseAuth.instance.signOut();

    user.removeToken();
    user = null;
    notifyListeners();
  }

  // Future<void> facebookLogin({Function onFail, Function onSuccess}) async {
  //   loadingFace = true;

  //   final result = await FacebookLogin().logIn(['email', 'public_profile']);

  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final credential = FacebookAuthProvider.getCredential(
  //           accessToken: result.accessToken.token);

  //       final authResult = await FirebaseAuth.instance.signInWithCredential(credential);

  //       if (authResult.user != null) {
  //         final firebaseUser = authResult.user;

  //         user = UserModel(
  //             id: firebaseUser.uid,
  //             name: firebaseUser.displayName,
  //             email: firebaseUser.email);

  //         await user.saveData();

  //         user.saveToken();

  //         onSuccess();
  //       }
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       break;
  //     case FacebookLoginStatus.error:
  //       onFail(result.errorMessage);
  //       break;
  //   }

  //   loadingFace = false;
  // }

  Future<void> signUp(
      {UserModel userModel, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email, password: user.password);

      userModel.id = result.user.uid;
      this.user = userModel;

      await userModel.saveData();

      userModel.saveToken();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  // void signOut() {
  //   FirebaseAuth.instance.signOut();
  //   user = null;
  //   notifyListeners();
  // }

  Future<void> _loadCurrentUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final DocumentSnapshot docUser = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get();
      user = UserModel.fromDocument(docUser);

      user.saveToken();

      notifyListeners();
    }
  }

  bool adminEnabled(BuildContext context) {//String companyTitle
      final Company companyProvider = Provider.of(context, listen: false);
    if (user != null && user.companiesAdmin != null)
      return user.companiesAdmin.contains(companyProvider.id) == true;
    else
      return false;
  }
}
