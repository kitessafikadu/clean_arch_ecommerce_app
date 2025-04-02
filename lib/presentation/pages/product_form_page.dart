import 'package:flutter/material.dart';

class ProductFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Product Name')),
            TextField(decoration: InputDecoration(labelText: 'Description')),
            TextField(decoration: InputDecoration(labelText: 'Price')),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
