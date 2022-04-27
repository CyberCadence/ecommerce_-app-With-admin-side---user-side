import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/models/ProductModel.dart';

class FireStoreServiceS {
  final String uid;
  FireStoreServiceS({required this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

 
Future<void> addProduct(
    Product product,
  ) async {
    final docId = firestore.collection("products").doc().id;
    await firestore.collection("products").doc(docId)
    .set(product.toMap(docId));
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

  Future<void> deleteItem(String id) async {
    await firestore.collection('products').doc(id).delete();
  }
}
