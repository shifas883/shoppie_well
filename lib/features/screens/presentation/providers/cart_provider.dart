import 'package:flutter/material.dart';
import '../../../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;
  final List<CartItem> _cartItems = [];

  double get totalAmount {
    return _items.values.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void addToCart(CartItem item) {
    if (_items.containsKey(item.id)) {
      _items[item.id]!.quantity += 1;
    } else {
      _items[item.id] = item;
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _items.remove(id);
    notifyListeners();
  }
  bool isInCart(String productId) {
    return _cartItems.any((item) => item.id == productId);
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
