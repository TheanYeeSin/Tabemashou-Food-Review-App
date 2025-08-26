class ChecklistItem {
  // ----- Fields -----
  final int? id;
  final String name;
  final bool isChecked;

  // ----- Constructor -----
  const ChecklistItem({this.id, required this.name, this.isChecked = false});

  // ----- Serialization -----
  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "isChecked": isChecked ? 1 : 0,
  };

  factory ChecklistItem.fromMap(final Map<String, dynamic> map) =>
      ChecklistItem(
        id: map["id"] as int,
        name: map["name"] as String,
        isChecked: map["isChecked"] == 1,
      );

  // ---- Debug -----
  @override
  String toString() =>
      "ChecklistItem(id: $id, name: $name, isChecked: $isChecked)";
}
