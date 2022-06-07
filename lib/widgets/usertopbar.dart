import 'package:ecomm/app/pages/user/user_bagpage.dart';
import 'package:flutter/material.dart';

class UserTopBar extends StatelessWidget {
  const UserTopBar({Key? key, required this.leadingIconButton})
      : super(key: key);
  final IconButton leadingIconButton;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leadingIconButton,
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const UserBagPage()));
            },
            icon: const Icon(Icons.shopping_bag_sharp))
      ],
    );
  }
}
