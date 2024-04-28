import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ustaxona/provider/new_product_list.dart';
import 'package:ustaxona/screen/new_product.dart';
import 'package:ustaxona/widget/product_list.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late Future<void> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = ref.read(newProductsProvider.notifier).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(newProductsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bobo Service",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondaryContainer),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: TextFormField(
                    onChanged: (value) {
                      ref.read(newProductsProvider.notifier).updateList(value);
                    },
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.8),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onInverseSurface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Maxsulot nomi...",
                      prefixIcon: const Icon(Icons.search_rounded),
                      prefixIconColor: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.6),
                    ),
                  ),
                ),
                // ignore: unnecessary_null_comparison, prefer_is_empty
                products != null || products.length < 0
                    ? Expanded(child: ProductList(products: products))
                    : Center(
                        child: Text(
                          'Error: Products data is null',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error),
                        ),
                      )
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (ctx) {
              return NewProduct();
            },
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add_rounded,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
      ),
    );
  }
}
