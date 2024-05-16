class ReviewRaw {
  final double rating;
  final String text;

  ReviewRaw({required this.rating, required this.text});

  @override
  String toString() => 'ReviewRaw(rating: $rating, text: $text)';
}
