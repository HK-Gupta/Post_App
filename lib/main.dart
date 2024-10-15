import 'package:flutter/material.dart';
import 'package:post_sharing/presentation/home_page.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post Sharing App',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


