import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String? id;
  int? amount;
  String? ownerId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Account({
    this.id,
    this.amount,
    this.ownerId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Account.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Account(
      id: snapshot.id,
      amount: data?['amount'],
      ownerId: data?['ownerId'],
      createdAt: data?['createdAt'] == null
          ? null
          : DateTime.parse(data?['createdAt']),
      updatedAt: data?['updatedAt'] == null
          ? null
          : DateTime.parse(data?['updatedAt']),
      deletedAt: data?['deletedAt'] == null
          ? null
          : DateTime.parse(data?['deletedAt']),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'amount': amount,
        'ownerId': ownerId,
        'createdAt':
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        'updatedAt':
            updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String()
      };
}
