import 'package:ecomm/ViewModels/view_model.dart';
import 'package:ecomm/services/PaymentServices.dart';
import 'package:ecomm/services/StorageServices.dart';
import 'package:ecomm/services/firestorreServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageProvider = Provider<StorageService?>((ref) {
  final auth = ref.watch(authStateChangesProvider);
  String? uid = auth.asData?.value?.uid;
  if (uid != null) {
    return StorageService(uid: uid);
  }
  return null;
});

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final authStateChangesProvider =
    StreamProvider((ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final databaseProvider = Provider<FireStoreServiceS?>((ref) {
  final auth = ref.watch(authStateChangesProvider);

  String? uid = auth.asData?.value?.uid;
  if (uid != null) {
    return FireStoreServiceS(uid: uid);
  }
  return null;
});
final bagProvider = ChangeNotifierProvider<BagViewModel>((ref) {
  return BagViewModel();
});
final paymentProvider = Provider<PaymentService>((ref) {
  return PaymentService();
});
