class Product {
  String id;
  String name;
  String description;
  double price;
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
  // Convert a Product object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  // Create a Product object from a Map
  factory Product.fromMap(Map<String, dynamic> map) {
    try {
      return Product(
        id: map['id'],
        name: map['name'],
        price: map['price'].toDouble(),
        description: map['description'],
        imageUrl: map['imageUrl'],
      );
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception(e);
    }
  }
}
