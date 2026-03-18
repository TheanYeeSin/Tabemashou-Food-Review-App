import "dart:typed_data";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:intl/intl.dart";
import "package:tabemashou/core/validators/text_validators.dart";
import "package:tabemashou/features/review/domain/review.dart";
import "package:tabemashou/features/review/presentation/widgets/review_form/review_form_chip_input.dart";
import "package:tabemashou/features/review/presentation/widgets/review_form/review_form_field.dart";
import "package:tabemashou/features/review/presentation/widgets/review_form/review_form_section.dart";
import "package:tabemashou/features/review/presentation/widgets/review_form/review_form_switch.dart";
import "package:tabemashou/features/review/presentation/widgets/review_form/review_form_visit_dialog.dart";

class ReviewForm extends StatefulWidget {
  final Review? initialReview;
  final void Function(Review review) onSubmit;
  const ReviewForm({super.key, this.initialReview, required this.onSubmit});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _additionalController = TextEditingController();
  final _openingHoursController = TextEditingController();

  late bool _isFavourite = false;
  late bool _isBlacklisted = false;
  late double _rating = 3.0;
  Uint8List? _imageBytes;

  late List<String> _categories = [];
  late List<String> _foodAvailable = [];
  late List<Visit> _visitHistory = [];

  // ----- Lifecycle -----
  @override
  void initState() {
    super.initState();
    final review = widget.initialReview;
    if (review != null) {
      _nameController.text = review.restaurantName;
      _locationController.text = review.restaurantLocation;
      _descriptionController.text = review.restaurantDescription;
      _additionalController.text = review.additionalReview ?? "";
      _openingHoursController.text = review.openingHours ?? "";
      _isFavourite = review.isFavourite;
      _isBlacklisted = review.isBlacklisted;
      _rating = review.rating;
      _imageBytes = review.image;
      _categories = review.categoryIds?.map((e) => e.toString()).toList() ?? [];
      _foodAvailable = review.foodAvailable ?? [];
      _visitHistory = review.visitHistory ?? [];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _additionalController.dispose();
    _openingHoursController.dispose();
    super.dispose();
  }

  Future<void> _addVisit() async {
    final newVisit = await showDialog<Visit>(
      context: context,
      builder: (_) => const ReviewFormVisitDialog(),
    );
    if (newVisit != null) {
      setState(() => _visitHistory.add(newVisit));
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final bytes = await file.readAsBytes();
      setState(() => _imageBytes = bytes);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return; // <-- stops submission
    }

    final newReview = Review(
      restaurantName: _nameController.text.trim(),
      restaurantLocation: _locationController.text.trim(),
      restaurantDescription: _descriptionController.text.trim(),
      foodAvailable: _foodAvailable,
      rating: _rating,
      additionalReview: _additionalController.text.trim().isEmpty
          ? null
          : _additionalController.text.trim(),
      isFavourite: _isFavourite,
      isBlacklisted: _isBlacklisted,
      image: _imageBytes,
      openingHours: _openingHoursController.text.trim().isEmpty
          ? null
          : _openingHoursController.text.trim(),
      categoryIds: null, // TODO: map to IDs if categories exist in DB
      visitHistory: _visitHistory,
    );

    widget.onSubmit(newReview);
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    body: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ReviewFormSection(
            title: "Restaurant Info",
            children: [
              ReviewFormField(
                controller: _nameController,
                prefixIcon: const Icon(Icons.restaurant_outlined),
                label: "Restaurant Name",
                required: true,
                validator: TextValidators.combine([
                  (v) =>
                      TextValidators.required(v, fieldName: "Restaurant Name"),
                ]),
              ),
              ReviewFormField(
                controller: _locationController,
                label: "Location",
                prefixIcon: const Icon(Icons.location_on_outlined),
                required: true,
                validator: TextValidators.combine([
                  (v) => TextValidators.required(v, fieldName: "Location"),
                ]),
              ),
              ReviewFormField(
                controller: _descriptionController,
                label: "Description",
                prefixIcon: const Icon(Icons.description_outlined),
                validator: TextValidators.required,
                maxLines: 2,
              ),
            ],
          ),
          // --- Rating + Image + Hours ---
          ReviewFormSection(
            title: "Details",
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  Expanded(
                    child: Slider(
                      value: _rating,
                      min: 0,
                      max: 5,
                      divisions: 10,
                      label: _rating.toString(),
                      onChanged: (v) => setState(() => _rating = v),
                    ),
                  ),
                  Text(_rating.toStringAsFixed(1)),
                ],
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _pickImage,
                child: _imageBytes == null
                    ? Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(child: Text("Tap to add photo")),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          _imageBytes!,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(height: 12),
              ReviewFormField(
                controller: _openingHoursController,
                label: "Opening Hours (e.g. 10:00 - 22:00)",
                prefixIcon: const Icon(Icons.access_time_outlined),
              ),
            ],
          ),
          ReviewFormSection(
            title: "Preferences",
            children: [
              ReviewFormSwitch(
                title: "Favourite",
                value: _isFavourite,
                onChanged: (final value) =>
                    setState(() => _isFavourite = value),
                secondary: const Icon(Icons.favorite_outlined),
              ),
              ReviewFormSwitch(
                title: "Blacklisted",
                value: _isBlacklisted,
                onChanged: (final value) =>
                    setState(() => _isBlacklisted = value),
                secondary: const Icon(Icons.block_outlined),
              ),
            ],
          ),
          ReviewFormSection(
            title: "Categories & Food",
            children: [
              ReviewFormChipInput(
                label: "Categories",
                values: _categories,
                onChanged: (final list) => setState(() => _categories = list),
              ),
              const SizedBox(height: 12),
              ReviewFormChipInput(
                label: "Food Available",
                values: _foodAvailable,
                onChanged: (final list) =>
                    setState(() => _foodAvailable = list),
              ),
            ],
          ),
          ReviewFormSection(
            title: "Additional Review",
            children: [
              ReviewFormField(
                controller: _additionalController,
                label: "Additional Review",
                prefixIcon: const Icon(Icons.rate_review_outlined),
                maxLines: 2,
              ),
            ],
          ),
          ReviewFormSection(
            title: "Visit History",
            action: IconButton(
              icon: const Icon(Icons.add),
              onPressed: _addVisit,
            ),
            children: _visitHistory
                .map(
                  (final v) => ListTile(
                    leading: const Icon(Icons.calendar_today_outlined),
                    title: Text(DateFormat.yMMMd().format(v.date)),
                    subtitle: Text(v.notes ?? ""),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => setState(() => _visitHistory.remove(v)),
                    ),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 80),
        ],
      ),
    ),
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: _submit,
          icon: const Icon(Icons.check),
          label: const Text("Save Review"),
        ),
      ),
    ),
  );
}
