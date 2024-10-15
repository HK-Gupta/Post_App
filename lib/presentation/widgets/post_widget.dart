import 'package:flutter/material.dart';
import 'package:post_sharing/presentation/widgets/video_player_widget.dart';
import 'package:share_plus/share_plus.dart';

class PostWidget extends StatelessWidget {
  final String content;
  final String postType;

  PostWidget({required this.content, required this.postType});

  // Function to share the post
  void _sharePost(BuildContext context) {
    final String postUrl = "https://myapp.com/posts/$postType"; // Replace with actual dynamic link logic

    Share.share(
      'Check out this $postType post: $postUrl',
      subject: 'Post from My App',
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget displayContent;

    // Determine what to display based on the post type
    if (postType == "text") {
      displayContent = Text(content);
    } else if (postType == "video") {
      displayContent = AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayerWidget(videoUrl: content),
      );
    } else if (postType == "image") {
      displayContent = Image.network(content);
    } else {
      displayContent = Text("Invalid Post Type");
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        displayContent,
        SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () => _sharePost(context),
          icon: Icon(Icons.share),
          label: Text('Share Post'),
        ),
      ],
    );
  }
}