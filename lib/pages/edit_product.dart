import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_online/pages/home_page.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatelessWidget {
  // hrs ada isinya sepeti detail
  final Map product;
  EditProduct({@required this.product});

  // untuk validator butuh form key
  final _formKey = GlobalKey<FormState>();

  // untuk mengambil data
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  Future saveProduct() async {
    final response = await http.put(
      Uri.parse(
          "http://10.0.2.2:8000/api/products/" + product['id'].toString()),
      body: {
        "name": _nameController.text,
        "description": _descriptionController.text,
        "price": _priceController.text,
        "image": _imageController.text,
      },
    );
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Form(
        // dari form ke untuk validator
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              // spade operator seperti value
              controller: _nameController..text = product['name'],
              decoration: InputDecoration(labelText: "Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter Product name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController..text = product['description'],
              decoration: InputDecoration(labelText: "Description"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter Product Description";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController..text = product['price'].toString(),
              decoration: InputDecoration(labelText: "Price"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter Product Price";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageController..text = product['image'],
              decoration: InputDecoration(labelText: "Image URL"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter Product Image URL";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // untuk debugging
                // print(_nameController.text);
                // cek form key
                if (_formKey.currentState.validate()) {
                  // harus pake then karena Future tidak langsung
                  saveProduct().then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                    // seperti snack bar
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text('Produk berhasil dirubah')));
                  });
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
