import 'package:auctions/models/account.dart';
import 'package:auctions/services/remote/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AccountRemoveService {
  final _db = FirebaseFirestore.instance;

  Future<Account?> insert(Account account) async {
    try {
      final snapshot = await _db
          .collection(Utils.accounts)
          .withConverter(
            fromFirestore: Account.fromFirestore,
            toFirestore: (Account account, _) => account.toFirestore(),
          )
          .add(account);

      final val = await snapshot.get();
      return val.data();
    } catch (e) {
      debugPrint('Error occured while inserting account:\n$e');
      return null;
    }
  }

  Future<Account?> getByOwner(String ownerId) async {
    try {
      final snapshot = await _db
          .collection(Utils.accounts)
          .where('ownerId', isEqualTo: ownerId)
          .withConverter(
            fromFirestore: Account.fromFirestore,
            toFirestore: (Account account, _) => account.toFirestore(),
          )
          .get();

      return snapshot.docs.map((account) => account.data()).firstOrNull;
    } catch (e) {
      debugPrint('Error occured while getting account:\n$e');
      return null;
    }
  }
}
