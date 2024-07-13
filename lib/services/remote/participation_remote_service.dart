import 'package:auctions/models/participation.dart';
import 'package:auctions/services/remote/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ParticipationRemoteService {
  final _db = FirebaseFirestore.instance;

  Future<Participation?> insert(Participation participation) async {
    try {
      final snapshot = await _db
          .collection(Utils.participations)
          .withConverter(
            fromFirestore: Participation.fromFirestore,
            toFirestore: (Participation participation, _) =>
                participation.toFirestore(),
          )
          .add(participation);

      final val = await snapshot.get();
      return val.data();
    } catch (e) {
      debugPrint('Error occured while inserting participation:\n$e');
      return null;
    }
  }

  Stream<List<Participation>> getAllAsStream() => _db
      .collection(Utils.participations)
      .withConverter(
        fromFirestore: Participation.fromFirestore,
        toFirestore: (Participation participation, _) =>
            participation.toFirestore(),
      )
      .snapshots()
      .map((event) =>
          event.docs.map((participation) => participation.data()).toList());

  Future<List<Participation>> getAll() async {
    try {
      final snapshot = await _db
          .collection(Utils.participations)
          .withConverter(
            fromFirestore: Participation.fromFirestore,
            toFirestore: (Participation participation, _) =>
                participation.toFirestore(),
          )
          .get();

      return snapshot.docs
          .map((participation) => participation.data())
          .toList();
    } catch (e) {
      debugPrint('Error occured while getting participation:\n$e');
      return [];
    }
  }
}
