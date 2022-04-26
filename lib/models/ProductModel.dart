class Product {
  final String name;

  final String description;
  final String imageUrl;
  final double price;
  Product(
      {required this.description,
      required this.imageUrl,
      required this.name,
      required this.price});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price

    };

    
  }

  Product.fromMap(Map<String,dynamic>map)
  :name=map['name']??"",description=map['description']??""
  ,price=map['price']??"",imageUrl=map['imageUrl']??"";






}
