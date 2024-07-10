import 'package:flutter/material.dart';
import 'package:quote_of_the_day/quote_home_page.dart';

void main() {
  runApp(QuoteApp());
}

class QuoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote of the Day',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuoteHomePage(),
    );
  }
}
