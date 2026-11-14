import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Product {
  final String name;
  final double price;
  final IconData image;
  final int quantity;

  const Product({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  Product copyWith(int? quantity) {
    return Product(
      name: name,
      price: price,
      image: image,
      quantity: quantity ?? this.quantity,
    );
  }
}

class MyCart {
  final int totalQuantity;
  final double totalPrice;

  const MyCart({required this.totalQuantity, required this.totalPrice});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Problem Solving',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [
    Product(
      name: 'Wireless Mouse',
      price: 500,
      image: Icons.mouse,
      quantity: 0,
    ),
    Product(
      name: 'Mechanical Keyboard',
      price: 899,
      image: Icons.keyboard,
      quantity: 0,
    ),
    Product(name: 'USB-C Hub', price: 300, image: Icons.usb, quantity: 0),
    Product(
      name: 'HD Monitor',
      price: 59000,
      image: Icons.monitor,
      quantity: 0,
    ),
    Product(
      name: 'Gaming Headset',
      price: 3999,
      image: Icons.headset,
      quantity: 0,
    ),
  ];

  MyCart makeCart() {
    int totalQuantity = 0;
    double totalPrice = 0;

    for (final e in products) {
      totalQuantity += e.quantity;
      totalPrice += e.price * e.quantity;
    }

    return MyCart(totalQuantity: totalQuantity, totalPrice: totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return ProductTile(
                    product: product,
                    tapToAdd: () {
                      setState(() {
                        products[index] = product.copyWith(
                          product.quantity + 1,
                        );
                      });
                    },
                    tapToRemove: () {
                      setState(() {
                        if (product.quantity != 0) {
                          products[index] = product.copyWith(
                            product.quantity - 1,
                          );
                        }
                      });
                    },
                  );
                },
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Quantity'),
                    Text('${makeCart().totalQuantity}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Total'), Text('${makeCart().totalPrice}')],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback tapToAdd;
  final VoidCallback tapToRemove;
  const ProductTile({
    super.key,
    required this.product,
    required this.tapToAdd,
    required this.tapToRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        tileColor: Colors.black12,
        leading: Icon(product.image),
        title: Text(product.name),
        subtitle: SizedBox(
          child: Row(
            children: [
              IconButton(onPressed: tapToRemove, icon: Icon(Icons.remove)),
              Text(product.quantity.toString()),
              IconButton(onPressed: tapToAdd, icon: Icon(Icons.add)),
            ],
          ),
        ),
        trailing: Text(
          '₹${product.quantity == 0 ? product.price : product.price * product.quantity}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
