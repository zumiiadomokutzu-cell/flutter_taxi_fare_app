import 'package:material_ui/material_ui.dart';
import 'package:flutter_taxi_fare_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';

//------------------------------------------

void main() {
  runApp(
    const FlutterTaxiFareApp(),
  );
}

//------------------------------------------
class FlutterTaxiFareApp extends StatefulWidget {
  const FlutterTaxiFareApp({super.key});

  @override
  State<FlutterTaxiFareApp> createState() => _FlutterTaxiFareAppState();
}

class _FlutterTaxiFareAppState extends State<FlutterTaxiFareApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxi Fare',
      home: const SplashScreenUi(),
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: GoogleFonts.kanit().fontFamily,
              fontFamilyFallback: GoogleFonts.kanit().fontFamilyFallback,
            ),
      ),
    );
  }
}
