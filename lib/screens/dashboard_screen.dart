import 'package:ecommerceapp/providers/cart_provider.dart';
import 'package:ecommerceapp/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/api_services.dart';
import '../widgets/category_card.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<String> categories = [];
  List<Product> trendingProducts = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCategoriesAndTrending();
  }

  Future<void> loadCategoriesAndTrending() async {
    try {
      final fetchedCategories = await ApiService.fetchCategories();
      final allProducts = await ApiService.fetchProductsByCategory('electronics');
      setState(() {
        categories = fetchedCategories;
        trendingProducts = allProducts.take(5).toList(); // Show top 5
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load data")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final wishlist = Provider.of<WishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("ShopECommerce"),
        backgroundColor: Colors.orange,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  // You can implement wishlist screen here
                },
              ),
              if (wishlist.wishlist.isNotEmpty)
                Positioned(
                  right: 4,
                  top: 4,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      wishlist.wishlist.length.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
              if (cart.items.isNotEmpty)
                Positioned(
                  right: 4,
                  top: 4,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.green,
                    child: Text(
                      cart.items.length.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadCategoriesAndTrending,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  Search bar
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Trending Section
                      Text("Trending Electronics", style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: trendingProducts.length,
                          itemBuilder: (context, index) {
                            final product = trendingProducts[index];
                            return Container(
                              width: 160,
                              margin: EdgeInsets.only(right: 10),
                              child: ProductCard(
                                product: product,
                                onTap: () {
                                  Navigator.pushNamed(context, '/details', arguments: product);
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 20),

                      //  Categories
                      Text("Categories", style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: 10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return CategoryCard(
                            category: category,
                            onTap: () {
                              Navigator.pushNamed(context, '/products', arguments: category);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
