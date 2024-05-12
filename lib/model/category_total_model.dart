class CategoryTotalModel {
  final String category;
  final double totalPrice;

  CategoryTotalModel({
    required this.category,
    required this.totalPrice,
  });

  factory CategoryTotalModel.fromJson(Map<String, dynamic> json) {
    return CategoryTotalModel(
      category: json['category'],
      totalPrice: json['totalPrice'].toDouble(),
    );
  }

  @override
  String toString() => 'CategoryTotalModel(category: $category, totalPrice: $totalPrice)';
}
