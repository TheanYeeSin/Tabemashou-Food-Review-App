import "dart:typed_data";

/// Category: Restaurant category that user can create and manage. E.g. "Japanese", "Italian"
class Category {
  // ----- Fields -----
  final int? id;
  final String name;
  final String description;
  final Uint8List? image;
  final int order;

  // ----- Constructor -----
  Category({
    this.id,
    required this.name,
    required this.description,
    this.image,
    required this.order,
  });

  // ----- Copy with -----
  Category copyWith({
    final int? id,
    final String? name,
    final String? description,
    final Uint8List? image,
    final int? order,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    image: image ?? this.image,
    order: order ?? this.order,
  );

  // ----- Serialization -----
  factory Category.fromMap(final Map<String, dynamic> map) => Category(
    id: map["id"] as int,
    name: map["name"] as String,
    description: map["description"] as String,
    image: map["image"] as Uint8List?,
    order: map["order_index"] as int,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "order_index": order,
  };

  // ----- Debug -----
  @override
  String toString() =>
      "Category(id: $id, name: $name, description: $description, image: $image, order: $order)";
}
