import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coffee.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageCoffeeController = PageController(
    viewportFraction: 0.35,
  );

  double _currentPage = 0.0;

  void _coffeeScrollListener() {
    setState(() {
      _currentPage = _pageCoffeeController.page!;
    });
  }

  @override
  void initState() {
    _pageCoffeeController.addListener(_coffeeScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeeController.removeListener(_coffeeScrollListener);
    _pageCoffeeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: -size.height * 0.22,
            height: size.height * 0.3,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 90,
                    offset: Offset.zero,
                    spreadRadius: 45,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: 100,
            child: Container(
              color: Colors.red,
            ),
          ),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              controller: _pageCoffeeController,
              scrollDirection: Axis.vertical,
              scrollBehavior: CupertinoScrollBehavior(),
              itemCount: coffees.length,
              itemBuilder: (_, idx) {
                if (idx == 0) {
                  return const SizedBox.shrink();
                }

                final coffee = coffees[idx - 1];
                final result = _currentPage - idx + 1;
                final value = -0.4 * result + 1;
                final opacity = value.clamp(0.0, 1.0);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(0.0, size.height / 2.6 * (1 - value).abs())
                      ..scale(value),
                    child: Opacity(
                      opacity: opacity,
                      child: Image.asset(coffee.image),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
