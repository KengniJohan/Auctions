import 'package:cloud_firestore/cloud_firestore.dart';

class Proposition {
  String? id;
  String? participation;
  int? amount;
  bool isLast;
  DateTime? createdAt;

  Proposition({
    this.id,
    this.participation,
    this.amount,
    this.isLast = false,
    this.createdAt,
  });

  Map<String, dynamic> toFirestore() => {
        'participation': participation,
        'amount': amount,
        'isLast': isLast,
        'createdAt': createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      };

  factory Proposition.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Proposition(
      id: snapshot.id,
      participation: data?['participation'],
      amount: data?['amount'],
      isLast: data?['isLast'],
      createdAt: data?['createdAt'] == null
          ? null
          : DateTime.parse(data?['createdAt']),
    );
  }
}
