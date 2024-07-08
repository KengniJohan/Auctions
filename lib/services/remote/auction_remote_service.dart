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

  Stream<List<Auction>> getAllAsStream() => _db
      .collection(Utils.auctions)
      .withConverter(
        fromFirestore: Auction.fromFirestore,
        toFirestore: (Auction auction, _) => auction.toFirestore(),
      )
      .snapshots()
      .map((event) => event.docs.map((auctions) => auctions.data()).toList());
}
