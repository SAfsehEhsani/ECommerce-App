import 'package:ecommerceapp/services/api_services.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String category = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(category.toUpperCase()),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          )
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: ApiService.fetchProductsByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (snapshot.hasError)
            return Center(child: Text("Error loading products"));

          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text("No products found"));

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.network(product.image, width: 50),
                  title: Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                  subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: product,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
