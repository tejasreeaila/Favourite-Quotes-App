import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Quote {
  final String text;
  final String author;
  bool isFavorite;

  Quote(this.text, this.author, {this.isFavorite = false});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Favourite Quotes',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const QuotesPage(),
    );
  }
}

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  int selectedIndex = 0;

  final List<Quote> quotes = [
    Quote('Believe in yourself.', 'Unknown'),
    Quote('Never give up on your dreams.', 'Nelson Mandela'),
    Quote('Every day is a new beginning.', 'Unknown'),
    Quote('Stay positive and work hard.', 'Unknown'),
    Quote('Dream big and dare to fail.', 'Norman Vaughan'),
    Quote('Small steps lead to big changes.', 'Unknown'),
    Quote('Be the reason someone smiles today.', 'Unknown'),
    Quote('Success comes from hard work.', 'Unknown'),
    Quote('Learn from yesterday, live for today.', 'Albert Einstein'),
    Quote('Make every moment count.', 'Unknown'),
  ];

  @override
  Widget build(BuildContext context) {
    final displayedQuotes = selectedIndex == 0
        ? quotes
        : quotes.where((quote) => quote.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favourite Quotes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF3E5F5),
              Color(0xFFEDE7F6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Words that inspire you ✨',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Expanded(
              child: displayedQuotes.isEmpty
                  ? const Center(
                      child: Text(
                        'No favourite quotes yet!',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      itemCount: displayedQuotes.length,
                      itemBuilder: (context, index) {
                        final quote = displayedQuotes[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 14),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.format_quote,
                                  color: Colors.deepPurple,
                                  size: 32,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  quote.text,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '- ${quote.author}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          quote.isFavorite =
                                              !quote.isFavorite;
                                        });
                                      },
                                      icon: Icon(
                                        quote.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: quote.isFavorite
                                            ? Colors.red
                                            : Colors.deepPurple,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
