import 'package:auctions/models/enums/auction_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auction {
  String? id;
  String? title;
  DateTime? startDate;
  DateTime? endDate;
  AuctionStatus status;
  String? admin;
  int? minPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? canceledAt;
  DateTime? deletedAt;

  Auction({
    this.id,
    this.title,
    this.startDate,
    this.endDate,
    this.status = AuctionStatus.newed,
    this.admin,
    this.minPrice,
    this.createdAt,
    this.updatedAt,
    this.canceledAt,
    this.deletedAt,
  });

  factory Auction.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Auction(
      id: snapshot.id,
      title: data?['title'],
      startDate: data?['startDate'] == null
          ? null
          : DateTime.parse(data?['startDate']),
      endDate:
          data?['endDate'] == null ? null : DateTime.parse(data?['endDate']),
      status: data?['status'] == null
          ? AuctionStatus.newed
          : AuctionStatus.fromName(data?['status']),
      admin: data?['admin'],
      minPrice: data?['minPrice'],
      createdAt: data?['createdAt'] == null
          ? null
          : DateTime.parse(data?['createdAt']),
      updatedAt: data?['updatedAt'] == null
          ? null
          : DateTime.parse(data?['updatedAt']),
      canceledAt: data?['canceledAt'] == null
          ? null
          : DateTime.parse(data?['canceledAt']),
      deletedAt: data?['deletedAt'] == null
          ? null
          : DateTime.parse(data?['deletedAt']),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'title': title,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'status': status.toName(),
        'admin': admin,
        'minPrice': minPrice,
        'createdAt':
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        'updatedAt':
            updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        'canceledAt': canceledAt?.toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String(),
      };
}
