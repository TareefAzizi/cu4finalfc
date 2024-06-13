import 'package:flutter/material.dart';
import 'package:quiz_id_flutter/api/quotes_api.dart';
import 'package:quiz_id_flutter/model/quotes_model.dart';
import 'package:quiz_id_flutter/screens/show_all.dart';
import 'package:quiz_id_flutter/screens/individual.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final QuotesApi quotesApi = QuotesApi();
  Quotes? currentQuote;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchInitialQuote();
  }

  Future<void> fetchInitialQuote() async {
    try {
      final quotes = await quotesApi.getQuotes();
      setState(() {
        currentQuote = quotes.first;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Failed to fetch quotes: $error');
    }
  }

  Future<void> fetchNewQuote() async {
    setState(() {
      isLoading = true;
    });
    try {
      final quotes = await quotesApi.getQuotes();
      setState(() {
        currentQuote = (quotes..shuffle()).first;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Failed to fetch quotes: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8), // Light background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 350,
              height: 350,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF), // White container color
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  if (!isLoading && currentQuote != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IndividualQuotePage(quote: currentQuote!), // Use the new widget
                      ),
                    );
                  }
                },
                child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Color(0xFF6B6B6B), // Dark gray color for loading indicator
                        )
                      : Text(
                          currentQuote!.quote,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6B6B6B), // Dark gray color for text
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: fetchNewQuote,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B6B6B), // Dark gray color for button
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 18,
                    ),
                    elevation: 5,
                    shadowColor: Colors.grey.withOpacity(0.3),
                  ),
                  child: const Text(
                    'Refresh',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShowAll()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2F2F2), // Light gray color for button
                    foregroundColor: const Color(0xFF6B6B6B), // Dark gray color for text
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: Color(0xFF6B6B6B), // Dark gray color for border
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 18,
                    ),
                    elevation: 5,
                    shadowColor: Colors.grey.withOpacity(0.3),
                  ),
                  child: const Text(
                    'Show All',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
