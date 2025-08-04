/// TextValidators: Utility class for validating text fields
class TextValidators {
  /// combine: Combine multiple validators
  static String? Function(String?) combine(
    final List<String? Function(String?)> validators,
  ) => (final value) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) return result;
    }
    return null;
  };

  /// required: Validator for required fields
  static String? required(
    final String? value, {
    final String fieldName = "Field",
  }) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }
}
