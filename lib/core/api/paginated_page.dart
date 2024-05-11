class PaginatedPage<T> {
  final List<T> items;
  final String? cursor;
  
  PaginatedPage({
    required this.items,
    required this.cursor,
  });
}
