import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../services/cart_service.dart';

class CartPage extends StatelessWidget {
  final String username;
  const CartPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Belanja')),
      // Rebuild otomatis tiap isi box Hive berubah (tambah/hapus).
      body: ValueListenableBuilder(
        valueListenable: CartService.listenable(),
        builder: (context, box, _) {
          final List<CartItem> items = CartService.getItems(username);

          if (items.isEmpty) {
            return const Center(child: Text('Keranjang masih kosong'));
          }

          final total = items.fold<double>(0, (sum, i) => sum + i.subtotal);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final item = items[i];
                    return Card(
                      child: ListTile(
                        leading: SizedBox(
                          width: 48,
                          height: 48,
                          child: Image.network(
                            item.thumbnail,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.image_not_supported),
                          ),
                        ),
                        title: Text(item.title,
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        subtitle: Text(
                            'Qty: ${item.qty} | Harga: \$${item.price.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              CartService.remove(username, item.productId),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('\$${total.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
