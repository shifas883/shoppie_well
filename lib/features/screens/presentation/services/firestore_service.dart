import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference productCollection = FirebaseFirestore.instance.collection('products');

  Stream<List<Map<String, dynamic>>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> addProduct(String name,String description, double price, String imageUrl) async {
    await productCollection.add({
      'name': name,
      'description': description,
      'price': price,
      'image': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}

