import "dart:typed_data";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:tabemashou/core/validators/text_validators.dart";
import "package:tabemashou/features/category/domain/category.dart";

/// CategoryDialog: Dialog for adding/editing a category
class CategoryDialog extends StatefulWidget {
  final Category? initialCategory;
  final bool? isEdit;
  const CategoryDialog({super.key, this.initialCategory, this.isEdit = false});

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  // ----- Properties -----
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  Uint8List? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  // ----- Lifecycle -----
  @override
  void initState() {
    super.initState();

    final category = widget.initialCategory;
    if (category != null) {
      _nameController.text = category.name;
      _descriptionController.text = category.description;
      _selectedImage = category.image;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // ----- Handle Image -----
  Future<void> _pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final bytes = await file.readAsBytes();
      setState(() => _selectedImage = bytes);
    }
  }

  // ----- Submit -----
  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context, {
        "name": _nameController.text,
        "description": _descriptionController.text,
        "image": _selectedImage,
      });
    }
  }

  // ----- Build -----
  @override
  Widget build(final BuildContext context) => AlertDialog(
    title: Text(
      widget.isEdit! ? "Edit Category" : "Add Category",
      textAlign: TextAlign.center,
    ),
    actions: [
      TextButton(
        child: const Text("Cancel"),
        onPressed: () => Navigator.pop(context),
      ),
      TextButton(onPressed: _submit, child: const Text("Submit")),
    ],
    content: SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: _formKey,
          child: Column(
            children: [
              if (_selectedImage != null && _selectedImage!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(_selectedImage!, height: 100),
                  ),
                ),
              ElevatedButton.icon(
                icon: const Icon(Icons.image),
                label: const Text("Upload Image"),
                onPressed: _pickImage,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                  hintText: "Enter category name",
                ),
                validator: (final value) =>
                    TextValidators.required(value, fieldName: "Name"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                  hintText: "Enter category description",
                ),
                validator: (final value) =>
                    TextValidators.required(value, fieldName: "Description"),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
