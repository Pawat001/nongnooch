/// Cart Item Model สำหรับสินค้าในตะกร้า
class CartItemModel {
  final String id;
  final String type; // 'ticket', 'room', 'food', 'package'
  final String itemId;
  final String title;
  final String? subtitle;
  final int quantity;
  final double price;
  final double discount;
  final String? imageUrl;
  final DateTime? selectedDate;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final Map<String, dynamic>? metadata;
  
  CartItemModel({
    required this.id,
    required this.type,
    required this.itemId,
    required this.title,
    this.subtitle,
    required this.quantity,
    required this.price,
    this.discount = 0.0,
    this.imageUrl,
    this.selectedDate,
    this.checkInDate,
    this.checkOutDate,
    this.metadata,
  });
  
  // Calculate total price after discount
  double get totalPrice {
    return (price * quantity) - discount;
  }
  
  // Calculate discount percentage
  double get discountPercent {
    if (price == 0) return 0;
    return (discount / (price * quantity)) * 100;
  }
  
  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'itemId': itemId,
      'title': title,
      'subtitle': subtitle,
      'quantity': quantity,
      'price': price,
      'discount': discount,
      'imageUrl': imageUrl,
      'selectedDate': selectedDate?.toIso8601String(),
      'checkInDate': checkInDate?.toIso8601String(),
      'checkOutDate': checkOutDate?.toIso8601String(),
      'metadata': metadata,
    };
  }
  
  // Create from Map
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] ?? '',
      type: map['type'] ?? 'ticket',
      itemId: map['itemId'] ?? '',
      title: map['title'] ?? '',
      subtitle: map['subtitle'],
      quantity: map['quantity'] ?? 1,
      price: (map['price'] ?? 0).toDouble(),
      discount: (map['discount'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'],
      selectedDate: map['selectedDate'] != null 
        ? DateTime.parse(map['selectedDate']) 
        : null,
      checkInDate: map['checkInDate'] != null 
        ? DateTime.parse(map['checkInDate']) 
        : null,
      checkOutDate: map['checkOutDate'] != null 
        ? DateTime.parse(map['checkOutDate']) 
        : null,
      metadata: map['metadata'],
    );
  }
  
  // Copy with method
  CartItemModel copyWith({
    String? id,
    String? type,
    String? itemId,
    String? title,
    String? subtitle,
    int? quantity,
    double? price,
    double? discount,
    String? imageUrl,
    DateTime? selectedDate,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    Map<String, dynamic>? metadata,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      type: type ?? this.type,
      itemId: itemId ?? this.itemId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      imageUrl: imageUrl ?? this.imageUrl,
      selectedDate: selectedDate ?? this.selectedDate,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      metadata: metadata ?? this.metadata,
    );
  }
}
