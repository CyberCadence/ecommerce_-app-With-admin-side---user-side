import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/models/ProductModel.dart';

class FireStoreServiceS {
  final String uid;
  FireStoreServiceS({required this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct(Product product) async {
    await firestore
        .collection('products')
        .add(product.toMap())
        .then((value) => print(value))
        .catchError((onError) => print('error'));
  }

  Stream<List<Product>> getallProducts() {
    return firestore
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              final output = e.data();
              return Product.fromMap(output);
            }).toList());
  }
}
