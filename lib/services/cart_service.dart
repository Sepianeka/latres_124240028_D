import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

/// Cart disimpan di Hive. Key = "username:productId" sehingga
/// cart tiap user terpisah.
class CartService {
  static const boxName = 'cart_box';

  static Box get _box => Hive.box(boxName);

  static ValueListenable<Box> listenable() => _box.listenable();

  static String _key(String username, int productId) => '$username:$productId';

  static Future<void> addToCart({
    required String username,
    required Product product,
    required int qty,
  }) async {
    final key = _key(username, product.id);
    final existing = _box.get(key);

    var total = qty;
    if (existing != null) {
      total += Map<String, dynamic>.from(existing as Map)['qty'] as int;
    }
    if (total > product.stock) total = product.stock; // batas stok

    final item = CartItem(
      username: username,
      productId: product.id,
      title: product.title,
      price: product.price,
      thumbnail: product.thumbnail,
      stock: product.stock,
      qty: total,
    );
    await _box.put(key, item.toMap());
  }

  /// Hanya item milik [username].
  static List<CartItem> getItems(String username) {
    return _box.values
        .map((e) => CartItem.fromMap(Map<String, dynamic>.from(e as Map)))
        .where((item) => item.username == username)
        .toList();
  }

  static Future<void> remove(String username, int productId) {
    return _box.delete(_key(username, productId));
  }
}
