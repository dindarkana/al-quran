import 'package:flutter/material.dart';
import 'qode.dart';
import 'quranpage.dart';
import 'myfavoritepage.dart';
import 'dailypage.dart'; // Tambahkan impor ke file qode.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const BookmarkPage(), // Panggil class BookmarkPage
      initialRoute: '/bookmark', // Halaman awal
      routes: {
        '/quran': (context) => QuranPage(), // Rute ke QuranPage
        '/bookmark': (context) => BookmarkPage(), // Rute ke BookmarkPage
        '/myfavorite': (context) => FavoritePage(), 
        '/daily': (context) => DailyPage(),
        // Tambahkan halaman lain jika ada, misalnya /lamp atau /pray
      },

    );
  }
}
