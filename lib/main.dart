import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
  Map<String, bool> fruits = {
    'Apple': false,
    'Orange': false,
    'Gripe': false,
    'Pineapple': false,
    'Mango': false,
  };

  List<String> selectedFruits() {
    return fruits.entries
        .where((e) {
          return e.value;
        })
        .map((e) {
          return e.key;
        })
        .toList();
  }

  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Multiple Items')),

      body: Column(
        children: [
          Column(
            children: List.generate(5, (n) {
              final name = fruits.keys.elementAt(n);
              final value = fruits[name]!;

              return DisplayName(
                name: name,
                onChanged: (e) {
                  setState(() {
                    fruits[name] = e ?? false;
                  });
                },
                isChecked: value,
              );
            }),
          ),
          Expanded(
            child: ShowSelectedNames(
              fruits: selectedFruits(),
              isShow: isShow,
              onPressed: () {
                setState(() {
                  isShow = !isShow;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ShowSelectedNames extends StatelessWidget {
  final List<String> fruits;
  final bool isShow;
  final VoidCallback onPressed;
  const ShowSelectedNames({
    super.key,
    required this.fruits,
    required this.isShow,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Column(
        children: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.black),
            onPressed: onPressed,
            child: Text(
              !isShow ? 'Show Selected' : 'Hide Selected',
              style: TextStyle(color: Colors.white),
            ),
          ),
          isShow && fruits.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: fruits.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Checkbox(value: true, onChanged: null),
                        title: Text(fruits[index]),
                      );
                    },
                  ),
                )
              : isShow
              ? Text('No selected fruits')
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class DisplayName extends StatelessWidget {
  final String name;
  final Function(bool?) onChanged;
  final bool isChecked;
  const DisplayName({
    super.key,
    required this.name,
    required this.onChanged,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(value: isChecked, onChanged: onChanged),
      title: Text(name),
    );
  }
}
