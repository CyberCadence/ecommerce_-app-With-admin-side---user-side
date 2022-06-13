import 'package:ecomm/app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserBagPage extends ConsumerWidget {
  const UserBagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payment = ref.read(paymentProvider);
    final user = ref.read(authStateChangesProvider);
    final userBag = ref.read(bagProvider);
    final bagviewModel = ref.watch(bagProvider);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              const Flexible(
                  child: Text(
                'My Bag',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ))
            ],
          ),
          Flexible(
              child: ListView.builder(
                  itemCount: bagviewModel.totalProducts,
                  itemBuilder: ((context, index) {
                    final products = bagviewModel.productsBag[index];
                    return ListTile(
                      title: Text(products.price.toString()),
                      trailing: IconButton(
                          onPressed: () {
                            bagviewModel.removeProduct(products);
                          },
                          icon: const Icon(Icons.delete)),
                    );
                  }))),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Total : \$ ' + bagviewModel.gettotalprice.toStringAsFixed(2),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                final result = await payment.initPaymentSheet(
                    user.value!, userBag.gettotalprice);

                if (!result.isError) {
                  ref
                      .read(databaseProvider)!
                      .saveOrder(result.payIntentId!, userBag.productsBag);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment completed ')));
                  userBag.removeallProducts();
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(result.message)));
                }
              },
              child: const Text('Checkout'))
        ]),
      )),
    );
  }
}
