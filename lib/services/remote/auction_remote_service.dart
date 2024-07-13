import 'package:auctions/models/auction.dart';
import 'package:auctions/services/remote/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuctionRemoteService {
  final _db = FirebaseFirestore.instance;

  Future<Auction?> insert(Auction auction) async {
    try {
      final snapshot = await _db
          .collection(Utils.auctions)
          .withConverter(
              fromFirestore: Auction.fromFirestore,
              toFirestore: (Auction auction, _) => auction.toFirestore())
          .add(auction);
      final value = await snapshot.get();
      return value.data();
    } catch (e) {
      debugPrint('Error occured while inserting auction:\n$e');
      return null;
    }
  }

  Future<void> update(String id, Auction auction) async {
    try {
      await _db
          .collection(Utils.auctions)
          .doc(id)
          .withConverter(
              fromFirestore: Auction.fromFirestore,
              toFirestore: (Auction auction, _) => auction.toFirestore())
          .set(auction);
    } catch (e) {
      debugPrint('Error occured while updating auction:\n$e');
    }
  }

  Stream<List<Auction>> getAllAsStream() => _db
      .collection(Utils.auctions)
      .withConverter(
        fromFirestore: Auction.fromFirestore,
        toFirestore: (Auction auction, _) => auction.toFirestore(),
      )
      .snapshots()
      .map((event) => event.docs.map((auctions) => auctions.data()).toList());

  Future<List<Auction>> getAll() async {
    try {
      final snapshot = await _db
          .collection(Utils.auctions)
          .withConverter(
            fromFirestore: Auction.fromFirestore,
            toFirestore: (Auction auction, _) => auction.toFirestore(),
          )
          .get();

      return snapshot.docs.map((phone) => phone.data()).toList();
    } catch (e) {
      debugPrint('Error occured while getting auctions:\n$e');
      return [];
    }
  }
}
