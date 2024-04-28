import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ustaxona/screen/main_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color.fromARGB(255, 28, 215, 125)),
  textTheme: GoogleFonts.newsreaderTextTheme(),
);
void main() {
  runApp(
    const ProviderScope(child: BoboApp()),
  );
}

class BoboApp extends StatelessWidget {
  const BoboApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: MainScreen(),
    );
  }
}
