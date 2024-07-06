import 'package:auctions/models/user.dart';
import 'package:auctions/services/remote/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserService {
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
}
