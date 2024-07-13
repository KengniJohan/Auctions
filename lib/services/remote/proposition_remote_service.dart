import 'package:auctions/models/proposition.dart';
import 'package:auctions/services/remote/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PropositionRemoteService {
  final _db = FirebaseFirestore.instance;

  Future<Proposition?> insert(Proposition proposition) async {
    try {
      final snapshot = await _db
          .collection(Utils.proposals)
          .withConverter(
            fromFirestore: Proposition.fromFirestore,
            toFirestore: (Proposition proposition, _) =>
                proposition.toFirestore(),
          )
          .add(proposition);

      final val = await snapshot.get();
      return val.data();
    } catch (e) {
      debugPrint("Error while inserting proposition:\n$e");
      return null;
    }
  }

  Future<void> update(String id, Proposition proposition) async {
    try {
      await _db
          .collection(Utils.proposals)
          .doc(id)
          .withConverter(
            fromFirestore: Proposition.fromFirestore,
            toFirestore: (Proposition proposition, _) =>
                proposition.toFirestore(),
          )
          .set(proposition);
    } catch (e) {
      debugPrint("Error while updating proposition:\n$e");
    }
  }

  Stream<List<Proposition>> getAllAsStream() => _db
      .collection(Utils.proposals)
      .withConverter(
        fromFirestore: Proposition.fromFirestore,
        toFirestore: (Proposition proposition, _) => proposition.toFirestore(),
      )
      .snapshots()
      .map((event) =>
          event.docs.map((proposition) => proposition.data()).toList());

  Future<List<Proposition>> getAll() async {
    try {
      final snapshot = await _db
          .collection(Utils.proposals)
          .withConverter(
            fromFirestore: Proposition.fromFirestore,
            toFirestore: (Proposition proposition, _) =>
                proposition.toFirestore(),
          )
          .get();

      return snapshot.docs.map((proposition) => proposition.data()).toList();
    } catch (e) {
      debugPrint("Error while getting proposition:\n$e");
      return [];
    }
  }
}
