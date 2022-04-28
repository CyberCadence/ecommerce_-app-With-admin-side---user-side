import 'dart:io';

import 'package:ecomm/app/providers.dart';
import 'package:ecomm/models/ProductModel.dart';
import 'package:ecomm/utilities/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AdminAddProductPage extends ConsumerStatefulWidget {
  AdminAddProductPage();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminAddProductPageState();
}

class _AdminAddProductPageState extends ConsumerState<AdminAddProductPage> {
  @override
  final titleTextEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomInputFieldFb1(
                  inputController: titleTextEditingController,
                  hintText: 'Product Name',
                  labelText: "ProductName"),
              const SizedBox(
                height: 20,
              ),
              CustomInputFieldFb1(
                  inputController: priceEditingController,
                  hintText: 'Price',
                  labelText: 'Price'),
              const SizedBox(
                height: 20,
              ),
              Consumer(
                builder: (context, watch, child) {
                  final image = ref.watch(addImageProvider);
                  return image == null
                      ? const Text('No image selected')
                      : Image.file(
                          File(image.path),
                          height: 200,
                        );
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      ref.watch(addImageProvider.state).state = image;
                    }
                  },
                  child: const Icon(Icons.image)),
              const SizedBox(
                height: 10,
              ),
              CustomInputFieldFb1(
                  inputController: descriptionEditingController,
                  hintText: ' description',
                  labelText: 'Product descrription'),
              ElevatedButton(
                  onPressed: () => _addProduct(),
                  child: (const Icon(Icons.add)))
            ],
          ),
        ),
      ),
    );
  }

  _addProduct() async {
    final storage = ref.read(databaseProvider);
    final filestorage = ref.read(storageProvider);
    final imageFile = ref.read(addImageProvider.state).state;

    if (storage == null || imageFile == null || filestorage == null) {
      print("Error :Storage,filestoreage or imagefile is null");
      return;
    }

    final imageurl = await filestorage.uploadFile(imageFile.path);

    await storage.addProduct(Product(
        description: descriptionEditingController.text,
        imageUrl: imageurl,
        name: titleTextEditingController.text,
        price: double.parse(priceEditingController.text)));

    openIconSnackBar(context, 'Product added Sucessfully', Icon(Icons.check));
    Navigator.pop(context);
  }
}

// Create an image provider with riverpod
final addImageProvider = StateProvider<XFile?>((_) => null);

class CustomInputFieldFb1 extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final Color primaryColor;
  final String labelText;

  const CustomInputFieldFb1(
      {Key? key,
      required this.inputController,
      required this.hintText,
      required this.labelText,
      this.primaryColor = Colors.indigo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        controller: inputController,
        onChanged: (value) {
          //Do something wi
        },
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          fillColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          border: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
        ),
      ),
    );
  }
}
