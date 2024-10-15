import 'package:flutter/material.dart';

import '../widgets/post_widget.dart';

class VideoPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PostWidget(
        content: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4", // Sample video URL
        postType: "video",
      ),
    );
  }
}