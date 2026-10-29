import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_block/features/weapons/data/datasources/weapon_favorites_remote_data_source.dart';

class WeaponFavoritesRemoteDataSourceImpl
    implements WeaponFavoritesRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  WeaponFavoritesRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });

  String get _userId => firebaseAuth.currentUser?.uid ?? '';

  // ✅ استفاده از کلکسیون جدا برای سلاح‌ها
  CollectionReference get _favoritesRef =>
      firestore.collection('users').doc(_userId).collection('weapon_favorites');

  @override
  Future<void> toggleFavorite(String weaponId, bool isFavorite) async {
    if (isFavorite) {
      await _favoritesRef.doc(weaponId).set({
        'addedAt': FieldValue.serverTimestamp(),
      });
    } else {
      await _favoritesRef.doc(weaponId).delete();
    }
  }

  @override
  Future<List<String>> getFavoriteIds() async {
    final snapshot = await _favoritesRef.get();
    return snapshot.docs.map((doc) => doc.id).toList();
  }
}
