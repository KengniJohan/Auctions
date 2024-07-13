import 'package:auctions/models/phone.dart';
import 'package:auctions/services/remote/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PhoneRemoteService {
  final _db = FirebaseFirestore.instance;

  Future<Phone?> insert(Phone phone) async {
    try {
      final snapshot = await _db
          .collection(Utils.phones)
          .withConverter(
            fromFirestore: Phone.fromFirestore,
            toFirestore: (Phone phone, _) => phone.toFirestore(),
          )
          .add(phone);
      final val = await snapshot.get();
      return val.data();
    } catch (e) {
      debugPrint('Error occured while inserting account:\n$e');
      return null;
    }
  }

  Future<void> update(String id, Phone phone) async {
    try {
      await _db
          .collection(Utils.phones)
          .doc(id)
          .withConverter(
            fromFirestore: Phone.fromFirestore,
            toFirestore: (Phone phone, _) => phone.toFirestore(),
          )
          .set(phone);
    } catch (e) {
      debugPrint('Error occured while updating account:\n$e');
    }
  }

  Stream<List<Phone>> getAllAsStream() => _db
      .collection(Utils.phones)
      .withConverter(
        fromFirestore: Phone.fromFirestore,
        toFirestore: (Phone phone, _) => phone.toFirestore(),
      )
      .snapshots()
      .map((event) => event.docs.map((phone) => phone.data()).toList());

  Future<List<Phone>> getAll() async {
    try {
      final snapshot = await _db
          .collection(Utils.phones)
          .withConverter(
            fromFirestore: Phone.fromFirestore,
            toFirestore: (Phone phone, _) => phone.toFirestore(),
          )
          .get();
          
      return snapshot.docs.map((phone) => phone.data()).toList();
    } catch (e) {
      debugPrint('Error occured while getting accounts :\n$e');
      return [];
    }
  }

  Future<Phone?> getById(String id) async {
    try {
      final snapshot = await _db
          .collection(Utils.phones)
          .doc(id)
          .withConverter(
            fromFirestore: Phone.fromFirestore,
            toFirestore: (Phone phone, _) => phone.toFirestore(),
          )
          .get();

      return snapshot.data();
    } catch (e) {
      debugPrint('Error occured while getting account by id:\n$e');
      return null;
    }
  }
}
