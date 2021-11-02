import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final Map product;

  ProductDetail({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail Product'),
        ),
        body: Column(
          children: [
            Container(
              child: Image.network(product['image']),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product['price'].toString(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.edit),
                      Icon(Icons.delete),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              product['description'],
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ));
  }
}
