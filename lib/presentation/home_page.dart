import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
  void initState() {
    super.initState();
    _handleDynamicLinks();
  }

  // Handle Firebase Dynamic Links
  void _handleDynamicLinks() async {
    // Listen for dynamic links when app is opened via a dynamic link
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri deepLink = dynamicLinkData.link;

      // Check if the deep link contains post parameters
      if (deepLink.queryParameters.containsKey('postId')) {
        String postId = deepLink.queryParameters['postId']!;
        String postType = deepLink.queryParameters['postType']!;

        // Navigate to the appropriate tab based on postType
        if (postType == 'text') {
          setState(() {
            _currentIndex = 0;
          });
        } else if (postType == 'video') {
          setState(() {
            _currentIndex = 1;
          });
        } else if (postType == 'image') {
          setState(() {
            _currentIndex = 2;
          });
        }
      }
    }).onError((error) {
      print('Error processing dynamic link: $error');
    });

    // Handle the dynamic link when the app is launched via a dynamic link
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;

      if (deepLink.queryParameters.containsKey('postId')) {
        String postId = deepLink.queryParameters['postId']!;
        String postType = deepLink.queryParameters['postType']!;

        // Navigate to the appropriate tab based on postType
        if (postType == 'text') {
          setState(() {
            _currentIndex = 0;  // Set to Text tab
          });
        } else if (postType == 'video') {
          setState(() {
            _currentIndex = 1;  // Set to Video tab
          });
        } else if (postType == 'image') {
          setState(() {
            _currentIndex = 2;  // Set to Image tab
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text(
            'Posts App',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
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
