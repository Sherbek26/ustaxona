import 'dart:io';

import 'package:riverpod/riverpod.dart';
import 'package:ustaxona/database/app_db.dart';
import 'package:ustaxona/module/product_module.dart';

class NewProductsNotifier extends StateNotifier<List<Product>> {
  NewProductsNotifier() : super(const []);

  Future<void> loadProducts() async {
    final db = await SqliteService().initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query("Product");
    final products = queryResult.map((item) {
      return Product(
        name: item['name'],
        dollor: item['dollor'],
        sum: item['sum'],
        imagePath: item['imagePath'],
      );
    }).toList();

    state = products;
  }

  Future<void> updateProduct(Product updatedProduct) async {
    final db = await SqliteService().initializeDB();
    // Update the product in the database based on its unique identifier
    await db.update(
      'Product',
      updatedProduct.toMap(), // Convert the updated product to a map
      where:
          'name = ?', // Assuming 'name' is the unique identifier of the product
      whereArgs: [
        updatedProduct.name
      ], // Provide the product's name as the argument
    );

    // Update the state with the updated product
    state = state.map((product) {
      // Replace the existing product with the updated one
      return product.name == updatedProduct.name ? updatedProduct : product;
    }).toList();
  }

  Future<void> deleteProduct(String name) async {
    final db = await SqliteService().initializeDB();
    await db.delete(
      'Product',
      where: 'name = ?',
      whereArgs: [name],
    );

    state = state.where((product) => product.name != name).toList();
  }

  void addNewProduct(
      String name, double dollor, double sum, File? image) async {
    final newProduct =
        Product(name: name, dollor: dollor, sum: sum, imagePath: image!.path);

    int result = await SqliteService().createProduct(newProduct);
    print("Added status: $result");
    state = [newProduct, ...state];
  }

  void updateList(String value) async {
    if (value.isEmpty) {
      // If the search value is empty, reload the original list of products
      await loadProducts();
    } else {
      // Otherwise, filter the list based on the search value
      final filteredList = state
          .where(
            (element) => element.name.toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
      state = filteredList;
    }
  }
}

final newProductsProvider =
    StateNotifierProvider<NewProductsNotifier, List<Product>>(
        (ref) => NewProductsNotifier());
