import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ustaxona/provider/new_product_list.dart';
import 'package:ustaxona/widget/image_upload.dart';

class NewProduct extends ConsumerStatefulWidget {
  const NewProduct({super.key});
  @override
  ConsumerState<NewProduct> createState() {
    return _NewProductScreen();
  }
}

class _NewProductScreen extends ConsumerState<NewProduct> {
  String? name = "";
  double? dollor = 0;
  double? sum = 0;
  File? _image;
  GlobalKey<FormState> formKey = GlobalKey();

  void _submitProduct() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (name!.isEmpty || dollor == null || sum == 0) {
        return;
      }

      ref
          .read(newProductsProvider.notifier)
          .addNewProduct(name!, dollor!, sum!, _image);

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
              Text("Maxsulotni qo'shish",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              ImageInput(onPickImage: (image) {
                _image = image;
              }),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nomi',
                ),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
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
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Dollor',
                ),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return "Iltimos, maxsulot nomini to'g'ri kiriting";
                  }
                  return null;
                },
                onSaved: (newValue) => dollor = double.tryParse(newValue!),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "So'm",
                ),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null) {
                    return "Iltimos, maxsulot nomini to'g'ri kiriting";
                  }
                  return null;
                },
                onSaved: (newValue) => sum = double.tryParse(newValue!),
              ),
              const SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Bekor qilish'),
              ),
              ElevatedButton(
                onPressed: _submitProduct,
                child: const Text('Saqlash'),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
