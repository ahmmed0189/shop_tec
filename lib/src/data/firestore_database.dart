import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_tec/src/data/data_repository.dart';
import 'package:shop_tec/src/features/overview/domain/product.dart';
import 'package:shop_tec/src/features/profile/domain/user.dart';

class FirestoreDatabase implements DatabaseRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirestoreDatabase(this._firebaseFirestore);

  @override
  Future<List<Product>> getProducts() async {
    final snapshot = await _firebaseFirestore.collection('product').get();
    List<Product> products = [];

    if (snapshot.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        if (doc.exists && doc.data() != null) {
          products.add(Product.fromMap(doc.data()!));
        }
      }
    }

    return products;
  }

  @override
  Future<Product?> getProductById(int id) async {
    DocumentSnapshot doc =
        await _firebaseFirestore.collection('product').doc(id.toString()).get();
    if (doc.exists) {
      return Product.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<void> addProduct(Product product) async {
    await _firebaseFirestore
        .collection('product')
        .doc(product.id.toString())
        .set(product.toMap());
  }

  @override
  Future<User?> getUserById(int id) async {
    DocumentSnapshot doc =
        await _firebaseFirestore.collection('users').doc(id.toString()).get();
    if (doc.exists) {
      return User.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<void> addUser(User user) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.id.toString())
        .set(user.toMap());
  }

  @override
  List<Product> get cart => _cart;
  final List<Product> _cart = [];

  @override
  void addToCart(Product item) {
    _cart.add(item);
  }

  @override
  void removeFromCart(Product item) {
    _cart.remove(item);
  }
}
