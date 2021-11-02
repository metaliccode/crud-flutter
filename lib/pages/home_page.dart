import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toko_online/pages/add_product.dart';
import 'package:toko_online/pages/detail_page.dart';
import 'package:toko_online/pages/edit_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'http://10.0.2.2:8000/api/products';

  Future getProducts() async {
    // hrs di parsing dulu
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteProduct(String productId) async {
    // hrs di parsing dulu
    var response =
        await http.delete("http://10.0.2.2:8000/api/products/" + productId);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // untuk button tambah
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduct(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Data Products'),
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return Text('Data Oke'); // agar looping pake lsitview builder
            return ListView.builder(
              itemCount: snapshot.data['data'].length,
              itemBuilder: (context, index) {
                // return Text(snapshot.data['data'][index]['name']);
                return Container(
                  height: 180,
                  child: Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        // untuk link ke detail
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                  product: snapshot.data['data'][index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Image.network(
                              snapshot.data['data'][index]['image'],
                              width: 100,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    snapshot.data['data'][index]['name'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(snapshot.data['data'][index]
                                      ['description']),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // edit
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProduct(
                                                  product: snapshot.data['data']
                                                      [index],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.edit,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            deleteProduct(snapshot.data['data']
                                                        [index]['id']
                                                    .toString())
                                                .then((value) {
                                              setState(() {});
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(snapshot.data['data'][index]['price']
                                        .toString()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Text(snapshot.data['data'][index]['price']),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Text('Data Error');
          }
        },
      ),
    );
  }
}
