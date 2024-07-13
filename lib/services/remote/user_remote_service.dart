import 'package:auctions/models/user.dart';
import 'package:auctions/services/remote/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserRemoteService {
  final _db = FirebaseFirestore.instance;

  Future<User?> insert(User user) async {
    try {
      final snapshot = await _db
          .collection(Utils.users)
          .withConverter(
            fromFirestore: User.fromFirestore,
            toFirestore: (User user, _) => user.toFirestore(),
          )
          .add(user);

      final val = await snapshot.get();
      return val.data();
    } catch (e) {
      debugPrint('Error occured while inserting user:\n$e');

      return null;
    }
  }

  Future<List<User>> findByEmail(String email) async {
    try {
      final snapshot = await _db
          .collection(Utils.users)
          .where('email', isEqualTo: email)
          .withConverter(
            fromFirestore: User.fromFirestore,
            toFirestore: (User user, _) => user.toFirestore(),
          )
          .get();

      return snapshot.docs.map((userData) => userData.data()).toList();
    } catch (e) {
      debugPrint('Error occured while getting user by email:\n$e');

      return [];
    }
  }

  Future<User?> getById(String id) async {
    try {
      final snapshot = await _db
          .collection(Utils.users)
          .doc(id)
          .withConverter(
            fromFirestore: User.fromFirestore,
            toFirestore: (User user, _) => user.toFirestore(),
          )
          .get();

      return snapshot.data();
    } catch (e) {
      debugPrint('Error occured while getting user by id:\n$e');

      return null;
    }
  }
}
