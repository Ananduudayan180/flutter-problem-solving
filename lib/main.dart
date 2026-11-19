import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Product {
  final String name;
  final double price;
  final IconData image;
  final bool isFav;

  const Product({
    required this.name,
    required this.price,
    required this.image,
    required this.isFav,
  });

  Product copyWith(bool? isFav) {
    return Product(
      name: name,
      price: price,
      image: image,
      isFav: isFav ?? this.isFav,
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
  static final List<Product> _products = [
    Product(
      name: 'Wireless Mouse',
      price: 500,
      image: Icons.mouse,
      isFav: false,
    ),
    Product(
      name: 'Mechanical Keyboard',
      price: 899,
      image: Icons.keyboard,
      isFav: false,
    ),
    Product(name: 'USB-C Hub', price: 300, image: Icons.usb, isFav: false),
    Product(
      name: 'HD Monitor',
      price: 59000,
      image: Icons.monitor,
      isFav: false,
    ),
    Product(
      name: 'Gaming Headset',
      price: 3999,
      image: Icons.headset,
      isFav: false,
    ),
  ];

  int checkFavCount() {
    return _productsListNotifier.value.where((e) {
      return e.isFav;
    }).length;
  }

  final ValueNotifier<List<Product>> _productsListNotifier = ValueNotifier(
    _products,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Wishlist')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ValueListenableBuilder(
          valueListenable: _productsListNotifier,
          builder: (context, products, child) {
            return Column(
              children: [
                Text('Favourite products: ${checkFavCount()}'),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return ProductTile(
                        product: product,

                        onPressed: () {
                          products[index] = product.copyWith(!product.isFav);

                          _productsListNotifier.value = List.from(products);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onPressed;

  const ProductTile({
    super.key,
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        tileColor: Colors.black12,
        leading: Icon(product.image),
        title: Text(product.name),
        subtitle: Text('${product.price}'),
        trailing: IconButton(
          onPressed: onPressed,
          icon: Icon(
            product.isFav ? Icons.favorite : Icons.favorite_border,
            color: product.isFav ? Colors.red : Colors.black,
          ),
        ),
      ),
    );
  }
}
