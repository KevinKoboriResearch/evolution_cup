//
// Generated file. Do not edit.
//

// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:cloud_functions_web/cloud_functions_web.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:vibration_web/vibration_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  FirestoreWeb.registerWith(registrar);
  CloudFunctionsWeb.registerWith(registrar);
  FirebaseAuthWeb.registerWith(registrar);
  FirebaseCoreWeb.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
  VibrationWebPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
