import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providerConfigs: const [EmailProviderConfiguration()],
      footerBuilder: (context, _) {
        return const Padding(padding: EdgeInsets.all(16),child: Text('By signing in, you agree to our terms and conditions.'),);
      },
    );
  }
}
