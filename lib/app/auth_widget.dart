import 'providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//This Widget is responsible for building the correct UIs depending on the auth state. It is a key widget when building authentication systems.//

class AuthWidget extends ConsumerWidget {
  final WidgetBuilder signinBuilder;
  final WidgetBuilder noSigninBuilder;

  AuthWidget({required this.noSigninBuilder, required this.signinBuilder});

@override

Widget build (BuildContext context,WidgetRef ref){
final authstateChanges=ref.watch(authStateChangesProvider);

return  authstateChanges.when(data: (user)=>user!=null?signinBuilder(context):noSigninBuilder(context),
 error: (_,__)=>const Scaffold(body: Center(child: Text('Something went wrong ,try again'),
),
),
 loading: () {
return  const Scaffold(body: Center(child: CircularProgressIndicator()),);
});



}
}
