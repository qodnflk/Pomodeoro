import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sleep_and_i_go_travel/home_screen.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFE7626C),
        cardColor: const Color(0xFFF4EDDB),
        
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
