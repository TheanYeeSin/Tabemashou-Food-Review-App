import "dart:convert";
import "dart:typed_data";

class Review {
  final int? id;
  final String restaurantName;
  final String restaurantLocation;
  final String restaurantDescription;
  final List<String>? foodAvailable;
  final double rating;
  final String? additionalReview;
  final bool isFavourite;
  final bool isBlacklisted;
  final Uint8List? image;
  final String? openingHours;
  final List<int>? categoryIds;
  final List<Visit>? visitHistory;
  final DateTime createdAt;
  final DateTime updatedAt;

  Review({
    this.id,
    required this.restaurantName,
    required this.restaurantLocation,
    required this.restaurantDescription,
    this.foodAvailable,
    required this.rating,
    this.additionalReview,
    required this.isFavourite,
    required this.isBlacklisted,
    this.image,
    this.openingHours,
    this.categoryIds,
    this.visitHistory,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  Review copyWith({
    final int? id,
    final String? restaurantName,
    final String? restaurantLocation,
    final String? restaurantDescription,
    final List<String>? foodAvailable,
    final double? rating,
    final String? additionalReview,
    final bool? isFavourite,
    final bool? isBlacklisted,
    final Uint8List? image,
    final String? openingHours,
    final List<int>? categoryIds,
    final List<Visit>? visitHistory,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) => Review(
    id: id ?? this.id,
    restaurantName: restaurantName ?? this.restaurantName,
    restaurantLocation: restaurantLocation ?? this.restaurantLocation,
    restaurantDescription: restaurantDescription ?? this.restaurantDescription,
    foodAvailable: foodAvailable ?? this.foodAvailable,
    rating: rating ?? this.rating,
    additionalReview: additionalReview ?? this.additionalReview,
    isFavourite: isFavourite ?? this.isFavourite,
    isBlacklisted: isBlacklisted ?? this.isBlacklisted,
    image: image ?? this.image,
    openingHours: openingHours ?? this.openingHours,
    categoryIds: categoryIds ?? this.categoryIds,
    visitHistory: visitHistory ?? this.visitHistory,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "restaurantName": restaurantName,
    "restaurantLocation": restaurantLocation,
    "restaurantDescription": restaurantDescription,
    "foodAvailable": foodAvailable != null ? jsonEncode(foodAvailable) : null,
    "rating": rating,
    "additionalReview": additionalReview,
    "isFavourite": isFavourite ? 1 : 0,
    "isBlacklisted": isBlacklisted ? 1 : 0,
    "image": image,
    "openingHours": openingHours,
    "createdAt": DateTime.now().toIso8601String(),
    "updatedAt": DateTime.now().toIso8601String(),
  };

  factory Review.fromMap(final Map<String, dynamic> map) => Review(
    id: map["id"] as int?,
    restaurantName: map["restaurantName"],
    restaurantLocation: map["restaurantLocation"],
    restaurantDescription: map["restaurantDescription"],
    foodAvailable: map["foodAvailable"] != null
        ? List<String>.from(jsonDecode(map["foodAvailable"]))
        : null,
    rating: map["rating"],
    additionalReview: map["additionalReview"],
    isFavourite: (map["isFavourite"] ?? 0) == 1,
    isBlacklisted: (map["isBlacklisted"] ?? 0) == 1,
    image: map["image"],
    openingHours: map["openingHours"],
  );
}

class Visit {
  final int? id;
  final int? reviewId;
  final DateTime date;
  final List<String>? foodOrdered;
  final String? notes;

  const Visit({
    this.id,
    this.reviewId,
    required this.date,
    this.foodOrdered,
    this.notes,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "reviewId": reviewId,
    "date": date.toIso8601String(),
    "foodOrdered": foodOrdered != null ? jsonEncode(foodOrdered) : null,
    "notes": notes,
  };

  factory Visit.fromMap(final Map<String, dynamic> map) => Visit(
    id: map["id"],
    reviewId: map["reviewId"],
    date: DateTime.parse(map["date"]),
    foodOrdered: map["foodOrdered"] != null
        ? List<String>.from(jsonDecode(map["foodOrdered"]))
        : null,
    notes: map["notes"],
  );
}

Uint8List _dummyImage(String label) {
  // Just a fake byte array for testing purposes
  return Uint8List.fromList(List<int>.generate(20, (i) => i + label.length));
}

final List<Review> sampleReviews = [
  Review(
    id: 1,
    restaurantName: "Sakura Japanese Diner",
    restaurantLocation: "Tokyo Street, Kuala Lumpur",
    restaurantDescription: "Authentic Japanese cuisine with cozy ambiance.",
    foodAvailable: ["Ramen", "Sushi", "Tempura", "Miso Soup"],
    rating: 4.7,
    additionalReview: "Highly recommended for sushi lovers!",
    isFavourite: true,
    isBlacklisted: false,
    image: _dummyImage("Sakura"),
    openingHours: "Mon–Sun: 11:00 AM – 10:00 PM",
    categoryIds: [1, 4],
    visitHistory: [
      Visit(
        id: 1,
        reviewId: 1,
        date: DateTime(2025, 6, 2),
        foodOrdered: ["Salmon Sushi", "Ramen"],
        notes: "Fresh fish and quick service.",
      ),
      Visit(
        id: 2,
        reviewId: 1,
        date: DateTime(2025, 9, 14),
        foodOrdered: ["Tempura", "Green Tea Ice Cream"],
        notes: "Tempura was crispy, dessert was refreshing.",
      ),
    ],
  ),
  Review(
    id: 2,
    restaurantName: "Mamak Delight",
    restaurantLocation: "Jalan Ampang, Kuala Lumpur",
    restaurantDescription:
        "24-hour Indian-Muslim restaurant with wide selection.",
    foodAvailable: ["Roti Canai", "Teh Tarik", "Nasi Goreng Kampung"],
    rating: 4.3,
    additionalReview: "Good place for late-night meals.",
    isFavourite: false,
    isBlacklisted: false,
    image: _dummyImage("Mamak"),
    openingHours: "Open 24 hours",
    categoryIds: [2, 3],
    visitHistory: [
      Visit(
        id: 3,
        reviewId: 2,
        date: DateTime(2025, 5, 10),
        foodOrdered: ["Roti Canai", "Milo Ais"],
        notes: "Always crowded at night but worth the wait.",
      ),
    ],
  ),
  Review(
    id: 3,
    restaurantName: "Burger Empire",
    restaurantLocation: "Mid Valley Megamall, Kuala Lumpur",
    restaurantDescription: "Gourmet burgers made with premium beef and cheese.",
    foodAvailable: ["Cheese Burger", "Chicken Burger", "Fries", "Milkshake"],
    rating: 3.9,
    additionalReview: "Average service, but great taste.",
    isFavourite: false,
    isBlacklisted: false,
    image: _dummyImage("Burger"),
    openingHours: "Daily: 10:00 AM – 11:00 PM",
    categoryIds: [5],
    visitHistory: [
      Visit(
        id: 4,
        reviewId: 3,
        date: DateTime(2025, 3, 8),
        foodOrdered: ["Cheese Burger", "Fries"],
        notes: "Burger was juicy but took 20 minutes to serve.",
      ),
    ],
  ),
  Review(
    id: 4,
    restaurantName: "Old Town Café",
    restaurantLocation: "Ipoh, Perak",
    restaurantDescription: "Classic Malaysian kopitiam with nostalgic vibe.",
    foodAvailable: ["Kaya Toast", "White Coffee", "Mee Goreng"],
    rating: 4.8,
    additionalReview: "Brings back childhood memories.",
    isFavourite: true,
    isBlacklisted: false,
    image: _dummyImage("OldTown"),
    openingHours: "Mon–Sat: 7:00 AM – 6:00 PM",
    categoryIds: [6, 7],
    visitHistory: [
      Visit(
        id: 5,
        reviewId: 4,
        date: DateTime(2025, 2, 21),
        foodOrdered: ["Kaya Toast", "White Coffee"],
        notes: "Perfect breakfast combo.",
      ),
      Visit(
        id: 6,
        reviewId: 4,
        date: DateTime(2025, 7, 1),
        foodOrdered: ["Mee Goreng"],
        notes: "Spicy and flavorful.",
      ),
    ],
  ),
];
