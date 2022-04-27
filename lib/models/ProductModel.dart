class Product {
  final String name;
  final String? id;
  final String description;
  final String imageUrl;
  final double price;
  Product(
      {required this.description,
      this.id,
      required this.imageUrl,
      required this.name,
      required this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price
    };
  }

  Product.fromMap(Map<String, dynamic> map)
      : name = map['name'] ?? "",
        id = map['id'] ?? "",
        description = map['description'] ?? "",
        price = map['price'] ?? "",
        imageUrl = map['imageUrl'] ?? "";
}
