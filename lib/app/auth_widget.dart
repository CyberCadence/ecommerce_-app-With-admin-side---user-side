import 'package:ecomm/models/UserdataModel.dart';

import 'providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//This Widget is responsible for building the correct UIs depending on the auth state. It is a key widget when building authentication systems.//
const adminEmail = "admin@admin.com";

class AuthWidget extends ConsumerWidget {
  final WidgetBuilder signinBuilder;
  final WidgetBuilder noSigninBuilder;
  final WidgetBuilder adminSignedInBuider;
  final adminEmail = "admin@admin.com";
  AuthWidget(
      {required this.noSigninBuilder,
      required this.signinBuilder,
      required this.adminSignedInBuider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authstateChanges = ref.watch(authStateChangesProvider);

    return authstateChanges.when(
        data: (user) => user != null
            ? signedinHandler(context, ref, user)
            : noSigninBuilder(context),
        error: (_, __) => const Scaffold(
              body: Center(
                child: Text('Something went wrong ,try again'),
              ),
            ),
        loading: () {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }

  FutureBuilder<UserDataModel?> signedinHandler(
      BuildContext context, WidgetRef ref, User user) {
    final database = ref.read(databaseProvider)!;
    final potentialUSerFuture = database.getUser(user.uid);
    return FutureBuilder<UserDataModel?>(
        future: potentialUSerFuture,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final potentialuser = snapshot.data;
            if (potentialuser == null) {
              database.addUSer(UserDataModel(
                  useremail: user.email != null ? user.email! : "",
                  useruid: user.uid));
            }
            if (user.email == adminEmail) {
              return adminSignedInBuider(context);
            }
            return signinBuilder(context);
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }));
  }
}
