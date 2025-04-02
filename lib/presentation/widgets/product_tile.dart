import 'package:clean_arch_ecommerce_app/domain/entities/product.dart';
import 'package:flutter/material.dart';
import '../pages/product_detail_page.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product)),
        );
      },
    );
  }
}
