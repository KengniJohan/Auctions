import 'package:cloud_firestore/cloud_firestore.dart';

class Phone {
  String? id;
  String? brand;
  String? model;
  String? os;
  double? screen;
  int? autonomie;
  int? ram;
  int? rom;
  int? frontalCamera;
  int? backCamera;
  String? description;
  int? price;
  String? image;
  String? auction;
  String? owner;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Phone({
    this.id,
    this.brand,
    this.model,
    this.os,
    this.screen,
    this.autonomie,
    this.ram,
    this.rom,
    this.frontalCamera,
    this.backCamera,
    this.description,
    this.price,
    this.image,
    this.auction,
    this.owner,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Phone.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Phone(
      id: snapshot.id,
      brand: data?['brand'],
      model: data?['model'],
      os: data?['os'],
      screen: data?['screen'],
      autonomie: data?['autonomie'],
      ram: data?['ram'],
      rom: data?['rom'],
      frontalCamera: data?['frontalCamera'],
      backCamera: data?['backCamera'],
      description: data?['description'],
      image: data?['image'],
      auction: data?['auction'],
      owner: data?['owner'],
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
        'brand': brand,
        'model': model,
        'os': os,
        'screen': screen,
        'autonomie': autonomie,
        'ram': ram,
        'rom': rom,
        'frontalCamera': frontalCamera,
        'backCamera': backCamera,
        'description': description,
        'price': price,
        'image': image,
        'auction': auction,
        'owner': owner,
        'createdAt':
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        'updatedAt':
            updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String(),
      };
}
