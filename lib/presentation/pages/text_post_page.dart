import 'package:flutter/material.dart';

import '../widgets/post_widget.dart';

class TextPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PostWidget(
        content: "This is a sample text post.",
        postType: "text",
      ),
    );
  }
}