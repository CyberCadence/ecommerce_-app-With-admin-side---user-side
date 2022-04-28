import 'package:ecomm/app/pages/admin/adminAddProductPage.dart';
import 'package:ecomm/app/providers.dart';
import 'package:ecomm/models/ProductModel.dart';
import 'package:ecomm/widgets/projectListTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class AdminHome extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => ref.read(firebaseAuthProvider).signOut(),
              icon: const Icon(Icons.logout))
        ],
        title: const Text('Admin Page'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminAddProductPage()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: StreamBuilder<List<Product>>(

          stream: ref.read(databaseProvider)!.getallProducts(),
          builder: (context, snapshot) {
           
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.data != null) {


if (snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("No products yet..."),
                      Lottie.asset("assets/animations/empty.json", 
                          width: 200, repeat: false),
                    ],
                  ),
                );
              }


              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];

                    return ProductListTile(
                        product: product,
                        onDelete: () async {
                          await ref
                              .read(databaseProvider)!
                              .deleteItem(product.id!);
                        });
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
