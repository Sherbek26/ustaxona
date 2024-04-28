class Product {
  final String name;
  final double dollor;
  final double sum;
  final String imagePath;
  final DateTime createdAt;

  Product(
      {required this.name,
      required this.dollor,
      required this.sum,
      required this.imagePath})
      : createdAt = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dollor': dollor,
      'sum': sum,
      'imagePath': imagePath,
    };
  }
}
