import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'favorites_remote_data_source.dart';

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  FavoritesRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });

  // گرفتن آیدی کاربر فعلی
  String get _userId => firebaseAuth.currentUser!.uid;

  // مسیر دیتابیس: users -> [userId] -> favorites
  CollectionReference get _favoritesRef =>
      firestore.collection('users').doc(_userId).collection('favorites');

  @override
  Future<void> toggleFavorite(String agentId, bool isFavorite) async {
    if (isFavorite) {
      // اگه کاربر روی ستاره زد، به دیتابیس اضافه کن
      await _favoritesRef.doc(agentId).set({
        'addedAt': FieldValue.serverTimestamp(),
      });
    } else {
      // اگه ستاره رو برداشت، از دیتابیس پاک کن
      await _favoritesRef.doc(agentId).delete();
    }
  }

  @override
  Future<List<String>> getFavoriteIds() async {
    // همه ایجنت‌های موردعلاقه این کاربر رو بگیر
    final snapshot = await _favoritesRef.get();
    return snapshot.docs.map((doc) => doc.id).toList();
  }
}
