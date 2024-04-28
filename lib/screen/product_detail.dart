import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ustaxona/module/product_module.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Махсулот",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Image.file(
            File(product.imagePath),
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 28,
          ),
          Text(
            product.name,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Доллор:",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      Text(
                        "${product.dollor}\$",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Сум:",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      Text(
                        "${product.sum}сум",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
