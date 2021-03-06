import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/models/ProductModel.dart';
import 'package:ecomm/models/UserdataModel.dart';
import 'package:ecomm/models/order.dart';

class FireStoreServiceS {
  final String uid;
  FireStoreServiceS({required this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct(
    Product product,
  ) async {
    final docId = firestore.collection("products").doc().id;
    await firestore.collection("products").doc(docId).set(product.toMap(docId));
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
 
  Future<void> addUSer(UserDataModel userDataModel) async {
    await firestore
        .collection('users')
        .doc(userDataModel.useruid)
        .set(userDataModel.toMap());
  }

  Future<UserDataModel?> getUser(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    return doc.exists ? UserDataModel.fromMap(doc.data()!) : null;
  }

Stream<List<Order>> getOrders() {
    return firestore
        .collection("users")
        .doc(uid)
        .collection("orders")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Order.fromMap(d);
            }).toList());
  }

Future<void> saveOrder(String confirmationId, List<Product> products) async {
   
    // Save the order in the orders collection of the user
    await firestore.collection("users").doc(uid).collection("orders").add({
      'confirmationId': confirmationId,
      'products': products.map((product) => products).toList(),
      'timestamp': FieldValue.serverTimestamp(),
    });
    // Save the order on an outer collection for the admin / user depending on your design decision.
    // await firestore.collection("orders").doc(confirmationId).set({
    //   'confirmationId': confirmationId,
    //   'products': products.map((product) => product.toMap()).toList(),
    //   'timestamp': FieldValue.serverTimestamp(),
   
    // });

  }


}
