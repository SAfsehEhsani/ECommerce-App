import 'package:flutter/material.dart';
import '../models/product.dart';

/// Represents an item in the cart
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

/// Provider for cart state management
class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  /// Get all cart items
  List<CartItem> get items => _items;

  /// Add product to cart or increase quantity if already in cart
  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  /// Remove product from cart
  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  /// Increase quantity of a product in the cart
  void increaseQty(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  /// Decrease quantity (min 1) of a product in the cart
  void decreaseQty(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1 && _items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
    }
  }

  /// Get total price of all items
  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);
  }

  /// Get total quantity of items
  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  /// Clear the cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
