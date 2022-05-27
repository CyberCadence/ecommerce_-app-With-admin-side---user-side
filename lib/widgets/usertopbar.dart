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
        IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
        IconButton(onPressed: () {}, icon: Icon(Icons.card_travel))
      ],
    );
  }
}
