import 'package:auctions/models/account.dart';
import 'package:auctions/services/remote/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AccountService {
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
}
