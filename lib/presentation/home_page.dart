import 'package:flutter/material.dart';
import 'package:post_sharing/presentation/pages/image_post_page.dart';
import 'package:post_sharing/presentation/pages/text_post_page.dart';
import 'package:post_sharing/presentation/pages/video_post_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // List of pages for each tab
  final List<Widget> _pages = [
    TextPostPage(),
    VideoPostPage(),
    ImagePostPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts App'),
      ),
      body: _pages[_currentIndex], // Show content based on selected tab
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Switch tabs
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: 'Text',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Image',
          ),
        ],
      ),
    );
  }
}