import 'dart:developer';

import 'package:ecomm/app/auth_widget.dart';
import 'package:ecomm/app/pages/admin/AdminHomepage.dart';
import 'package:ecomm/app/pages/authentications/signInPage.dart';
import 'package:ecomm/app/pages/user/user_home.dart';
import 'package:ecomm/app/providers.dart';
import 'package:ecomm/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = 'pk_test_51L83VXSCFOe57vGMDOEMyVlq7WXcOjozYZu3o2xh2zc0XNvkqBTFXFxetDGChOCT66LZsi1oTnNIkiRlvqVks44S00zBnzrwHK';
  runApp(const ProviderScope(child: DevicePreview(enabled:true,builder:(context)=>MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.orange, primary: Colors.orange)),
      home: AuthWidget(
        adminSignedInBuider: (context) => AdminHome(),
        signinBuilder: (context) => const UserHomePage(),
        noSigninBuilder: (context) {
          return const Scaffold(body: SignInPage());
        },
      ),
    );
  }
}
