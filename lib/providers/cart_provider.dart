import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/cart_item_model.dart';
import '../utils/constants.dart';

/// Cart Provider สำหรับจัดการตะกร้าสินค้า
class CartProvider with ChangeNotifier {
  List<CartItemModel> _items = [];
  
  List<CartItemModel> get items => _items;
  
  int get itemCount => _items.length;
  
  bool get isEmpty => _items.isEmpty;
  
  bool get isNotEmpty => _items.isNotEmpty;
  
  /// Calculate total quantity of all items
  int get totalQuantity {
    return _items.fold(0, (total, item) => total + item.quantity);
  }
  
  /// Calculate subtotal (before discount)
  double get subtotal {
    return _items.fold(0.0, (total, item) => total + (item.price * item.quantity));
  }
  
  /// Calculate total discount
  double get totalDiscount {
    return _items.fold(0.0, (total, item) => total + item.discount);
  }
  
  /// Calculate grand total (after discount)
  double get grandTotal {
    return subtotal - totalDiscount;
  }
  
  /// Load cart from SharedPreferences
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString(AppConstants.keyCartItems);
    
    if (cartData != null) {
      final List<dynamic> decoded = json.decode(cartData);
      _items = decoded.map((item) => CartItemModel.fromMap(item)).toList();
      notifyListeners();
    }
  }
  
  /// Save cart to SharedPreferences
  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(_items.map((item) => item.toMap()).toList());
    await prefs.setString(AppConstants.keyCartItems, encoded);
  }
  
  /// Add item to cart
  Future<void> addItem(CartItemModel item) async {
    // Check if item already exists
    final existingIndex = _items.indexWhere((i) => 
      i.itemId == item.itemId && 
      i.type == item.type &&
      i.selectedDate == item.selectedDate
    );
    
    if (existingIndex >= 0) {
      // Update quantity if item exists
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + item.quantity,
      );
    } else {
      // Add new item
      _items.add(item);
    }
    
    await _saveCart();
    notifyListeners();
  }
  
  /// Remove item from cart
  Future<void> removeItem(String itemId) async {
    _items.removeWhere((item) => item.id == itemId);
    await _saveCart();
    notifyListeners();
  }
  
  /// Update item quantity
  Future<void> updateQuantity(String itemId, int newQuantity) async {
    if (newQuantity <= 0) {
      await removeItem(itemId);
      return;
    }
    
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(quantity: newQuantity);
      await _saveCart();
      notifyListeners();
    }
  }
  
  /// Clear all items from cart
  Future<void> clearCart() async {
    _items.clear();
    await _saveCart();
    notifyListeners();
  }
  
  /// Get items by type
  List<CartItemModel> getItemsByType(String type) {
    return _items.where((item) => item.type == type).toList();
  }
  
  /// Check if cart has items of specific type
  bool hasItemsOfType(String type) {
    return _items.any((item) => item.type == type);
  }
}
