import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ustaxona/module/product_module.dart';

class UpdateProduct extends ConsumerStatefulWidget {
  const UpdateProduct({Key? key, required this.product, required this.onUpdate})
      : super(key: key);
  final Product product;
  final void Function(Product updateProduct) onUpdate;

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends ConsumerState<UpdateProduct> {
  String? name;
  double? dollar;
  double? sum;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    name = widget.product.name;
    dollar = widget.product.dollor;
    sum = widget.product.sum;
  }

  void updateProduct() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // Update the product and invoke the callback function
      widget.onUpdate(Product(
          name: name!,
          dollor: dollar!,
          sum: sum!,
          imagePath: widget.product.imagePath));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 42),
          child: Column(
            children: [
              Text(
                "Maxsulotni O'zgartirish",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return "Iltimos, maxsulot nomini to'g'ri kiriting";
                  }
                  return null;
                },
                onSaved: (newValue) => name = newValue,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: dollar.toString(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return "Iltimos, summani to'g'ri kiriting";
                  }
                  return null;
                },
                onSaved: (newValue) => dollar = double.tryParse(newValue!) ?? 0,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: sum.toString(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return "Iltimos, summani to'g'ri kiriting";
                  }
                  return null;
                },
                onSaved: (newValue) => sum = double.tryParse(newValue!) ?? 0,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Bekor qilish'),
                  ),
                  ElevatedButton(
                    onPressed: updateProduct,
                    child: const Text("O'zgartirish"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
