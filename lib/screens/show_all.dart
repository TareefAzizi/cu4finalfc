import 'package:flutter/material.dart';
import 'package:quiz_id_flutter/api/quotes_api.dart';
import 'package:quiz_id_flutter/model/quotes_model.dart';

class ShowAll extends StatefulWidget {
  const ShowAll({super.key});

  @override
  _ShowAllState createState() => _ShowAllState();
}

class _ShowAllState extends State<ShowAll> {
  late Future<List<Quotes>> futureQuotes;
  List<Quotes> allQuotes = [];

  @override
  void initState() {
    super.initState();
    futureQuotes = QuotesApi().getQuotes();
    futureQuotes.then((value) {
      setState(() {
        allQuotes = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("All of the Quotes", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        color: const Color(0xFF121212),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder<List<Quotes>>(
                future: futureQuotes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4A148C)),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Failed to load Quotes. Please try again.",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: allQuotes.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: const Color(0xFF1F1F1F),
                          child: QuotesModel(quote: allQuotes[index]),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 25),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A148C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 18,
                  ),
                  elevation: 5,
                  shadowColor: const Color(0xFF4A148C).withOpacity(0.3),
                ),
                child: const Text(
                  "Back",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
