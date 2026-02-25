import "dart:typed_data";

class Review {
  final int? id;
  final String restaurantName;
  final String restaurantLocation;
  final String restaurantDescription;
  final List<String>? categories;
  final List<String>? foodAvailable;
  final double rating;
  final String? additionalReview;
  final bool isFavourite;
  final bool isBlacklisted;
  final Uint8List? image;
  final String? openingHours;

  final List<Visit>? visitHistory;

  const Review({
    this.id,
    required this.restaurantName,
    required this.restaurantLocation,
    required this.restaurantDescription,
    this.categories,
    this.foodAvailable,
    required this.rating,
    this.additionalReview,
    required this.isFavourite,
    required this.isBlacklisted,
    this.image,
    this.visitHistory,
    this.openingHours,
  });
}

class Visit {
  final DateTime date;
  final List<String>? foodOrdered;
  final String? notes;

  Visit({required this.date, this.foodOrdered, this.notes});
}

final List<Review> sampleReviews = [
  Review(
    id: 1,
    restaurantName: "KFC",
    restaurantLocation: "Mid Valley, Kuala Lumpur",
    restaurantDescription: "Popular fried chicken fast food chain.",
    categories: ["Fast Food", "Chicken"],
    foodAvailable: ["Zinger Burger", "Cheesy Wedges", "Pepsi"],
    rating: 4.2,
    additionalReview: "Always crispy and delicious. Try the spicy Zinger!",
    isFavourite: true,
    isBlacklisted: true,
    openingHours: "10:00 AM - 10:00 PM",
    visitHistory: [
      Visit(
        date: DateTime(2025, 7, 31),
        foodOrdered: ["Zinger Burger", "Fries"],
        notes: "Quick lunch before meeting. Service was fast.",
      ),
      Visit(
        date: DateTime(2025, 7, 29),
        foodOrdered: ["Cheesy Wedges", "Pepsi"],
        notes: "Evening snack. Wedges were a bit cold.",
      ),
    ],
  ),
  Review(
    id: 2,
    restaurantName: "Ramen Ichiraku",
    restaurantLocation: "Subang Jaya",
    restaurantDescription: "Authentic Japanese ramen with homemade noodles.",
    categories: ["Japanese", "Noodles"],
    foodAvailable: ["Shoyu Ramen", "Tonkotsu Ramen", "Green Tea"],
    rating: 4.8,
    additionalReview: "Feels like Tokyo in every bite. Amazing broth!",
    isFavourite: true,
    isBlacklisted: false,
    openingHours: "11:30 AM - 9:30 PM",
    visitHistory: [
      Visit(
        date: DateTime(2025, 7, 30),
        foodOrdered: ["Tonkotsu Ramen"],
        notes: "Rich broth, soft egg, very satisfying.",
      ),
    ],
  ),
  Review(
    id: 3,
    restaurantName: "Nasi Kandar Ali",
    restaurantLocation: "George Town, Penang",
    restaurantDescription: "Local favorite for spicy Nasi Kandar.",
    categories: ["Malaysian", "Rice"],
    foodAvailable: ["Fried Chicken", "Curry Fish", "Sambal Sotong"],
    rating: 4,
    additionalReview: "Great variety. Can get crowded at lunch.",
    isFavourite: false,
    isBlacklisted: false,
    openingHours: "7:00 AM - 11:00 PM",
    visitHistory: [
      Visit(
        date: DateTime(2025, 7, 28),
        foodOrdered: ["Fried Chicken", "Sambal Sotong"],
        notes: "Spicy and flavorful. Long queue but worth it.",
      ),
      Visit(
        date: DateTime(2025, 7, 26),
        foodOrdered: ["Curry Fish", "Fried Egg"],
        notes: "Fish was slightly overcooked, but curry was good.",
      ),
    ],
  ),
];
