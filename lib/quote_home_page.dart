import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:math';

class QuoteHomePage extends StatefulWidget {
  @override
  _QuoteHomePageState createState() => _QuoteHomePageState();
}

class _QuoteHomePageState extends State<QuoteHomePage> {
  List<String> quotes = [
    "The best way to get started is to quit talking and begin doing.",
    "The pessimist sees difficulty in every opportunity. The optimist sees opportunity in every difficulty.",
    "It’s not whether you get knocked down, it’s whether you get up.",
    "It takes courage to grow up and become who you really are.",
    "You have brains in your head. You have feet in your shoes. You can steer yourself any direction you choose.You're on your own. And you know what you know. And you are the guy who'll decide where to go.",
    "I am lucky that whatever fear I have inside me, my desire to win is always stronger."

  ];

  String currentQuote = "";
  List<String> favoriteQuotes = [];

  @override
  void initState() {
    super.initState();
    _loadQuote();
    _loadFavorites();
  }

  _loadQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentQuote = prefs.getString('quote') ?? _getRandomQuote();
    });
  }

  _saveQuote(String quote) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('quote', quote);
  }

  _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteQuotes = prefs.getStringList('favorites') ?? [];
    });
  }

  _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', favoriteQuotes);
  }

  String _getRandomQuote() {
    return quotes[Random().nextInt(quotes.length)];
  }

  void _refreshQuote() {
    setState(() {
      currentQuote = _getRandomQuote();
      _saveQuote(currentQuote);
    });
  }

  void _shareQuote() {
    Share.share(currentQuote);
  }

  void _toggleFavorite() {
    setState(() {
      if (favoriteQuotes.contains(currentQuote)) {
        favoriteQuotes.remove(currentQuote);
      } else {
        favoriteQuotes.add(currentQuote);
      }
      _saveFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quote of the Day'),
        actions: [
          IconButton(
            icon: Icon(favoriteQuotes.contains(currentQuote) ? Icons.favorite : Icons.favorite_border),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareQuote,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                currentQuote,
                style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _refreshQuote,
                child: Text('New Day & New Quote'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
