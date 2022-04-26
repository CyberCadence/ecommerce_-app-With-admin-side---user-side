import 'providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//This Widget is responsible for building the correct UIs depending on the auth state. It is a key widget when building authentication systems.//

class AuthWidget extends ConsumerWidget {
  final WidgetBuilder signinBuilder;
  final WidgetBuilder noSigninBuilder;
  final WidgetBuilder adminSignedInBuider;
    final adminEmail = "admin@admin.com";
  AuthWidget({required this.noSigninBuilder, required this.signinBuilder,required this.adminSignedInBuider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authstateChanges = ref.watch(authStateChangesProvider);
    const adminEmail = "admin@admin.com";
    return authstateChanges.when(
        data: (user) =>
            user != null ? user.email== adminEmail?adminSignedInBuider(context):   signinBuilder(context) : noSigninBuilder(context),
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
}
