import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(BanglaQuotesApp());
}

class BanglaQuotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "বাংলা Quotes App",
      debugShowCheckedModeBanner: false,
      home: QuoteScreen(),
    );
  }
}

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgController;
  late Animation<Color?> _bgAnimation;

  List<String> quotes = [
    "স্বাগতম! 🌸 Flutter দিয়ে বাংলা শিখো।",
    "প্রোগ্রামিং হলো সৃজনশীলতার খেলা।",
    "ছোট ছোট ধাপেই বড় লক্ষ্য পৌঁছানো যায়।",
    "প্রতিদিন ৫ মিনিট Flutter অনুশীলন করো।",
    "সফলতা অপেক্ষা করে না, কাজ করো! 🚀"
  ];

  int _currentQuote = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Background gradient animation
    _bgController = AnimationController(
        vsync: this, duration: Duration(seconds: 5))..repeat(reverse: true);
    _bgAnimation = ColorTween(
      begin: Colors.deepPurple.shade200,
      end: Colors.pink.shade200,
    ).animate(_bgController);

    // Change quotes every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentQuote = (_currentQuote + 1) % quotes.length;
      });
    });
  }

  @override
  void dispose() {
    _bgController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bgAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, _bgAnimation.value ?? Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: Text(
                quotes[_currentQuote],
                key: ValueKey<int>(_currentQuote),
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSansBengali(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
