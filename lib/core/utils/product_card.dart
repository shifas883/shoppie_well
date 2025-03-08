import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/models/cart_model.dart';
import '../../features/screens/presentation/providers/cart_provider.dart';

class ProductCard extends StatefulWidget {
  final DocumentSnapshot<Object?>? product;
  const ProductCard({super.key, this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isAddedToCart = false;

  void addToCart() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    if (!isAddedToCart) {
      cartProvider.addToCart(
        CartItem(
          id: widget.product?.id ?? "",
          name: widget.product?['name'] ?? "Unknown",
          price: double.tryParse(widget.product?['price']?.toString() ?? "0.0") ?? 0.0,
          image: widget.product?['image'] ?? "",
          quantity: 1,
        ),
      );

      setState(() {
        isAddedToCart = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${widget.product?['name']} added to cart!"),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 0.2, color: Colors.black),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.product?['image'] ?? ""),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "BEST SELLER",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                          fontSize: 10),
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        widget.product?['name'] ?? "No Name",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xff1A1D1E),
                        ),
                      ),
                    ),
                    Text(
                      "Price: \$${widget.product?['price'] ?? '0.0'}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: GestureDetector(
            onTap: addToCart,
            child: Container(
              decoration: BoxDecoration(
                color: isAddedToCart ? Colors.green : Colors.red.shade900,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              height: 50,
              width: 50,
              child: Icon(
                isAddedToCart ? Icons.check : Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
