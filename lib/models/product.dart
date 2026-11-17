class Review {
  final int rating;
  final String comment;
  final String reviewerName;

  Review({
    required this.rating,
    required this.comment,
    required this.reviewerName,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: (json['rating'] as num?)?.toInt() ?? 0,
        comment: json['comment'] as String? ?? '',
        reviewerName: json['reviewerName'] as String? ?? 'Anonim',
      );
}

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String? brand; // nullable: produk groceries tidak punya brand
  final String sku;
  final double weight;
  final String availabilityStatus;
  final String warrantyInformation;
  final String shippingInformation;
  final String returnPolicy;
  final String thumbnail;
  final List<String> images;
  final List<String> tags;
  final List<Review> reviews;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.availabilityStatus,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.returnPolicy,
    required this.thumbnail,
    required this.images,
    required this.tags,
    required this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        title: json['title'] as String? ?? '-',
        description: json['description'] as String? ?? '-',
        category: json['category'] as String? ?? '-',
        price: (json['price'] as num?)?.toDouble() ?? 0,
        discountPercentage:
            (json['discountPercentage'] as num?)?.toDouble() ?? 0,
        rating: (json['rating'] as num?)?.toDouble() ?? 0,
        stock: (json['stock'] as num?)?.toInt() ?? 0,
        brand: json['brand'] as String?,
        sku: json['sku'] as String? ?? '-',
        weight: (json['weight'] as num?)?.toDouble() ?? 0,
        availabilityStatus: json['availabilityStatus'] as String? ?? '-',
        warrantyInformation: json['warrantyInformation'] as String? ?? '-',
        shippingInformation: json['shippingInformation'] as String? ?? '-',
        returnPolicy: json['returnPolicy'] as String? ?? '-',
        thumbnail: json['thumbnail'] as String? ?? '',
        images: (json['images'] as List? ?? []).map((e) => e.toString()).toList(),
        tags: (json['tags'] as List? ?? []).map((e) => e.toString()).toList(),
        reviews: (json['reviews'] as List? ?? [])
            .map((e) => Review.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList(),
      );
}
