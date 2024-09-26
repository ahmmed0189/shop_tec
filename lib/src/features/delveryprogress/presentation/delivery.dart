class Delivery {
  String userId;
  String username;
  String address;
  String productId;
  double totalPrice;

  Delivery({
    required this.userId,
    required this.username,
    required this.address,
    required this.productId,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'address': address,
      'productId': productId,
      'totalPrice': totalPrice,
    };
  }

  factory Delivery.fromMap(Map<String, dynamic> map) {
    return Delivery(
      userId: map['userId'],
      username: map['username'],
      address: map['address'],
      productId: map['productId'],
      totalPrice: map['totalPrice'],
    );
  }
}
