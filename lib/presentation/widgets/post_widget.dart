import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String content;
  final String postType;
  final String postId;
  final VoidCallback onShare;
  final String? url;

  const PostWidget({
    required this.content,
    required this.postType,
    required this.postId,
    required this.onShare,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: postType == 'text'
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Post Type: $postType'),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: onShare, // Call the onShare function
                ),
              ],
            ),
          ],
        )
            : postType == 'image'
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (url != null) Image.network(url!),
            SizedBox(height: 10),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: onShare, // Call the onShare function
            ),
          ],
        )
            : Text("Error"),
      ),
    );
  }
}
