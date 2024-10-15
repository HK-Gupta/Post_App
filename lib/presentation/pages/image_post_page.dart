import 'package:flutter/material.dart';

import '../widgets/post_widget.dart';

class ImagePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PostWidget(
        content: "https://via.placeholder.com/150", // Sample image URL
        postType: "image",
      ),
    );
  }
}

