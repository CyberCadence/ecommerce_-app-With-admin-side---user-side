import 'package:ecomm/app/providers.dart';
import 'package:ecomm/widgets/Product_bannerfile.dart';
import 'package:ecomm/widgets/productdisplay.dart';
import 'package:ecomm/widgets/usertopbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserHomePage extends ConsumerWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserTopBar(
                leadingIconButton: IconButton(
                    onPressed: () {
                      ref.read(firebaseAuthProvider).signOut();
                    },
                    icon: const Icon(Icons.logout_outlined))),
            const Productbanner(),
            const Text(
              "Products",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("View all of our products",
                style: TextStyle(fontSize: 12)),
     const Flexible(child: ProductsDisplay())     ],
        ),
      )),
    );
  }
}
