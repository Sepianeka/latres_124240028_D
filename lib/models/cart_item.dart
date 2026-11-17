class CartItem {
  final String username;
  final int productId;
  final String title;
  final double price;
  final String thumbnail;
  final int stock;
  final int qty;

  CartItem({
    required this.username,
    required this.productId,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.stock,
    required this.qty,
  });

  double get subtotal => price * qty;

  Map<String, dynamic> toMap() => {
        'username': username,
        'productId': productId,
        'title': title,
        'price': price,
        'thumbnail': thumbnail,
        'stock': stock,
        'qty': qty,
      };

  factory CartItem.fromMap(Map<String, dynamic> map) => CartItem(
        username: map['username'] as String,
        productId: map['productId'] as int,
        title: map['title'] as String,
        price: (map['price'] as num).toDouble(),
        thumbnail: map['thumbnail'] as String? ?? '',
        stock: map['stock'] as int,
        qty: map['qty'] as int,
      );
}
