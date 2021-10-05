class PriceRange {
  final double minPrice;
  final double maxPrice;

  const PriceRange({
    required this.minPrice,
    required this.maxPrice,
  });

  @override
  String toString() => 'PriceRange(minPrice: $minPrice, maxPrice: $maxPrice)';
}
