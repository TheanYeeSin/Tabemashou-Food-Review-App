import "dart:typed_data";

/// Category: Restaurant category that user can create and manage. E.g. "Japanese", "Italian"
class Category {
  // ----- Fields -----
  final int? id;
  final String name;
  final String description;
  final Uint8List? image;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;

  // ----- Constructor -----
  Category({
    this.id,
    required this.name,
    required this.description,
    this.image,
    required this.order,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  // ----- Copy with -----
  Category copyWith({
    final int? id,
    final String? name,
    final String? description,
    final Uint8List? image,
    final int? order,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    image: image ?? this.image,
    order: order ?? this.order,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  // ----- Serialization -----
  factory Category.fromMap(final Map<String, dynamic> map) => Category(
    id: map["id"] as int,
    name: map["name"] as String,
    description: map["description"] as String,
    image: map["image"] as Uint8List?,
    order: map["orderIndex"] as int,
    createdAt: DateTime.parse(map["createdAt"] as String),
    updatedAt: DateTime.parse(map["updatedAt"] as String),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "orderIndex": order,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };

  // ----- Debug -----
  @override
  String toString() =>
      "Category(id: $id, name: $name, description: $description, image: $image, order: $order, createdAt: $createdAt, updatedAt: $updatedAt)";
}
