/// SortUtils: Generic sort utilities
class SortUtils {
  /// sortByField: Sort a list of objects by a field
  static void sortByField<T, K extends Comparable>(
    final List<T> list,
    final K Function(T item) selector, {
    final bool ascending = true,
  }) {
    list.sort(
      (final a, final b) => ascending
          ? selector(a).compareTo(selector(b))
          : selector(b).compareTo(selector(a)),
    );
  }

  /// sortByComparator: Sort a list of objects using a custom comparator
  static void sortByComparator<T>(
    final List<T> list,
    final int Function(T a, T b) comparator,
  ) {
    list.sort(comparator);
  }
}
