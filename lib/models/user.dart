import 'package:auctions/models/enums/label_role.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String? name;
  String? surname;
  String? email;
  String? password;
  LabelRole role;
  bool isLocked;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  User({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.password,
    this.role = LabelRole.member,
    this.isLocked = false,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  User.fromPrefs(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          surname: json['surname'],
          email: json['email'],
          password: json['password'],
          role: json['role'] == null
              ? LabelRole.member
              : LabelRole.fromName(json['role']),
          isLocked: json['isLocked'],
          createdAt: json['createdAt'] == null
              ? null
              : DateTime.parse(json['updatedAt']),
          updatedAt: json['updatedAt'] == null
              ? null
              : DateTime.parse(json['createdAt']),
          deletedAt: json['deletedAt'] == null
              ? null
              : DateTime.parse(json['deletedAt']),
        );

  Map<String, dynamic> toPrefs() => {
        'id': id,
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
        'role': role.toName(),
        'isLocked': isLocked,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String()
      };

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return User(
      id: snapshot.id,
      name: data?['name'],
      surname: data?['surname'],
      email: data?['email'],
      password: data?['password'],
      role: data?['role'] == null
          ? LabelRole.member
          : LabelRole.fromName(data?['role']),
      isLocked: data?['isLocked'],
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
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
        'role': role.toName(),
        'isLocked': isLocked,
        'createdAt':
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        'updatedAt':
            updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String()
      };
}
