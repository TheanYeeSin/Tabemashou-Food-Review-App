class ChecklistItem {
  // ----- Fields -----
  final int? id;
  final String name;
  final bool isChecked;
  final DateTime createdAt;
  final DateTime updatedAt;

  // ----- Constructor -----
  ChecklistItem({
    this.id,
    required this.name,
    this.isChecked = false,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  ChecklistItem copyWith({
    final int? id,
    final String? name,
    final bool? isChecked,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) => ChecklistItem(
    id: id ?? this.id,
    name: name ?? this.name,
    isChecked: isChecked ?? this.isChecked,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  // ----- Serialization -----
  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "isChecked": isChecked ? 1 : 0,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };

  factory ChecklistItem.fromMap(final Map<String, dynamic> map) =>
      ChecklistItem(
        id: map["id"] as int,
        name: map["name"] as String,
        isChecked: map["isChecked"] == 1,
        createdAt: DateTime.parse(map["createdAt"] as String),
        updatedAt: DateTime.parse(map["updatedAt"] as String),
      );

  // ---- Debug -----
  @override
  String toString() =>
      "ChecklistItem(id: $id, name: $name, isChecked: $isChecked, createdAt: $createdAt, updatedAt: $updatedAt)";
}
