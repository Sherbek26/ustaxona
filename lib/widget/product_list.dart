import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ustaxona/module/product_module.dart';
import 'package:ustaxona/provider/new_product_list.dart';
import 'package:ustaxona/widget/product_item.dart';
import 'package:ustaxona/widget/update_product.dart';

class ProductList extends ConsumerWidget {
  const ProductList({Key? key, required this.products}) : super(key: key);
  final List<Product> products;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx, index) {
        final product = products[index];
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (ctx) {
                    return UpdateProduct(
                      product: product,
                      onUpdate: (updatedProduct) {
                        // Update the product in the list
                        ref
                            .read(newProductsProvider.notifier)
                            .updateProduct(updatedProduct);
                      },
                    );
                  });
            } else {
              _confirmDelete(context, ref, product);
            }
          },
          background: Container(
            color: Theme.of(context).colorScheme.error,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(right: 20.0),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          secondaryBackground: Container(
            color: Theme.of(context).colorScheme.tertiary,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20.0),
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          child: ProductItem(
            product: product,
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, Product product) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      content: Text('Item deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          ref.read(newProductsProvider.notifier).addNewProduct(product.name,
              product.dollor, product.sum, File(product.imagePath));
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    ref.read(newProductsProvider.notifier).deleteProduct(product.name);
  }
}
