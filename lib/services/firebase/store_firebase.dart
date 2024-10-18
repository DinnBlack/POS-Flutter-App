import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pos_flutter_app/models/store_model.dart';

class StoreFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<void> createStore(StoreModel store) async {
    final User? user = _firebaseAuth.currentUser;

    if (user != null) {
      DatabaseReference userStoresRef = _database.ref('users/${user.uid}/stores');

      StoreModel newStore = store.copyWith(createdAt: DateTime.now());

      await userStoresRef.push().set(newStore.toMap());
    } else {
      throw Exception('No user is signed in.');
    }
  }


  Future<List<StoreModel>> fetchUserStores() async {
    final User? user = _firebaseAuth.currentUser;

    if (user != null) {
      DatabaseReference userStoresRef = _database.ref('users/${user.uid}/stores');

      final snapshot = await userStoresRef.once();
      final storesData = snapshot.snapshot.value as Map<dynamic, dynamic>?;

      if (storesData != null) {
        List<StoreModel> stores = storesData.entries.map((entry) {
          final storeMap = entry.value as Map<dynamic, dynamic>;
          return StoreModel.fromMap(Map<String, dynamic>.from(storeMap));
        }).toList();

        stores.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        return stores;
      }
    } else {
      throw Exception('No user is signed in.');
    }
    return [];
  }


}
