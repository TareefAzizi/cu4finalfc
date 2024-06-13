import 'package:flutter/material.dart';
import 'package:quiz_id_flutter/model/quotes_model.dart';

class IndividualQuotePage extends StatelessWidget {
  final Quotes quote;

  const IndividualQuotePage({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildQuoteContainer(),
              const SizedBox(height: 50),
              _buildBackButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuoteContainer() {
    return Container(
      width: 350,
      height: 350,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Quiz ID:  ${quote.id}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6A1B9A),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              quote.quote,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Color(0xFF4A148C),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            quote.author,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7B1FA2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6A1B9A),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 18,
        ),
        elevation: 5,
        shadowColor: const Color(0xFF6A1B9A).withOpacity(0.3),
      ),
      child: const Text(
        'Back to Home',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
