import 'package:cloud_firestore/cloud_firestore.dart';

class Participation {
  String? id;
  String? participant;
  String? auction;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Participation({
    this.id,
    this.participant,
    this.auction,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Participation.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Participation(
      id: snapshot.id,
      participant: data?['participant'],
      auction: data?['auction'],
      createdAt: data?['createdAt'] == null
          ? null
          : DateTime.parse(data?['updatedAt']),
      updatedAt: data?['updatedAt'] == null
          ? null
          : DateTime.parse(data?['createdAt']),
      deletedAt: data?['deletedAt'] == null
          ? null
          : DateTime.parse(data?['deletedAt']),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'participant': participant,
        'auction': auction,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String()
      };
}
