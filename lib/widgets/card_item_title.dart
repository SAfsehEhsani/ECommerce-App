import 'package:ecommerceapp/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';


class CartItemTile extends StatelessWidget {
  final Product product;

  CartItemTile({required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final item = cart.items.firstWhere((item) => item.product.id == product.id);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: Image.network(product.image, width: 50),
        title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text("\$${product.price.toStringAsFixed(2)} x ${item.quantity}"),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => cart.decreaseQty(product),
              ),
              Text("${item.quantity}"),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => cart.increaseQty(product),
              ),
            ],
          ),
        ),
        onLongPress: () => cart.removeFromCart(product),
      ),
    );
  }
}
