import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ustaxona/module/product_module.dart';
import 'package:ustaxona/screen/product_detail.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          color: Theme.of(context).colorScheme.primaryContainer),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) {
                return ProductDetailScreen(product: product);
              },
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Conditionally show image or placeholder
            Image.file(
              File(product.imagePath),
              fit: BoxFit.fill,
              width: 86,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                product.name,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            Text(
              "${product.dollor}\$",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(width: 8),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              width: 1,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "${product.sum}сум",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }
}
