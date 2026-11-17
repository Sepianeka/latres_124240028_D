import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/cart_service.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  final String username;
  const DetailPage({super.key, required this.product, required this.username});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late int _qty;

  Product get p => widget.product;

  @override
  void initState() {
    super.initState();
    _qty = p.stock > 0 ? 1 : 0;
  }

  Future<void> _addToCart() async {
    await CartService.addToCart(
      username: widget.username,
      product: p,
      qty: _qty,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$_qty x ${p.title} ditambahkan ke keranjang')),
    );
  }

  Widget _info(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 110,
                child: Text(label,
                    style: const TextStyle(fontWeight: FontWeight.w600))),
            Expanded(child: Text(value)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final imageUrl = p.images.isNotEmpty ? p.images.first : p.thumbnail;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                imageUrl,
                height: 220,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image_not_supported, size: 80),
              ),
            ),
            const SizedBox(height: 16),
            Text(p.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
              '\$${p.price.toStringAsFixed(2)}  (diskon ${p.discountPercentage}%)',
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                Text(' ${p.rating}  |  Stok: ${p.stock}'),
              ],
            ),
            const Divider(height: 24),
            const Text('Deskripsi',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(p.description),
            const Divider(height: 24),
            _info('Brand', p.brand ?? '-'),
            _info('Kategori', p.category),
            _info('SKU', p.sku),
            _info('Berat', '${p.weight}'),
            _info('Tags', p.tags.join(', ')),
            _info('Status', p.availabilityStatus),
            _info('Garansi', p.warrantyInformation),
            _info('Pengiriman', p.shippingInformation),
            _info('Retur', p.returnPolicy),
            const Divider(height: 24),
            const Text('Ulasan',
                style: TextStyle(fontWeight: FontWeight.bold)),
            ...p.reviews.map(
              (r) => ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(r.reviewerName),
                subtitle: Text(r.comment),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text('${r.rating}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                // batas bawah: qty > 0 (minimal 1)
                onPressed: _qty > 1 ? () => setState(() => _qty--) : null,
              ),
              Text('$_qty', style: const TextStyle(fontSize: 18)),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                // batas atas: qty <= stok
                onPressed: _qty < p.stock ? () => setState(() => _qty++) : null,
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: p.stock > 0 ? _addToCart : null,
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
