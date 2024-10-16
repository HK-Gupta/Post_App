import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart'; // Import the video player package

class PostWidget extends StatefulWidget {
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
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  VideoPlayerController? _videoController;
  bool _isPlaying = false; // Track if the video is playing
  bool liked = false;
  @override
  void initState() {
    super.initState();
    if (widget.postType == 'video' && widget.url != null) {
      // Initialize the video player if it's a video post
      _videoController = VideoPlayerController.network(widget.url!)
        ..initialize().then((_) {
          _videoController!.play();
          setState(() {}); // Update the state once the video is loaded
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose(); // Dispose the video controller
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause(); // Pause if playing
        _isPlaying = false;
      } else {
        _videoController!.play(); // Play if paused
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color(0xFF03DAC5),
              width: 1.5
          ),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.postType == 'text'
              ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.content,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () { setState(() {
                        liked = !liked;
                      }); },
                      child: liked? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ):
                      const Icon(
                        Icons.favorite,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: widget.onShare, // Call the onShare function
                    ),
                  ],
                ),
              ],
          )
              : widget.postType == 'image'
              ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.url != null && widget.url!.isNotEmpty)
                  Text(widget.content, style: TextStyle(fontSize: 21)),
                if (widget.url != null && widget.url!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.url!,
                      errorBuilder: (context, error, stackTrace) {
                        return Text("Failed to load image"); // Error handling for invalid URLs
                      },
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () { setState(() {
                        liked = !liked;
                      }); },
                      child: liked? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ):
                      const Icon(
                        Icons.favorite,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: widget.onShare,
                    ),
                  ],
                ),
              ],
          )
              : widget.postType == 'video'
              ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_videoController != null &&
                        _videoController!.value.isInitialized)
                      InkWell(
                        onTap: _togglePlayPause,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.9, // Adjust the height based on your design
                          child: AspectRatio(
                            aspectRatio: _videoController!.value.aspectRatio,
                            child: VideoPlayer(_videoController!),
                          ),
                        ),
                      )
                    else
                      CircularProgressIndicator(), // Show loading spinner until video is ready
                    SizedBox(height: 10),
                    Text(widget.content),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () { setState(() {
                            liked = !liked;
                          }); },
                          child: liked? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ):
                          const Icon(
                            Icons.favorite,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: widget.onShare,
                        ),
                      ],
                    ),
                  ],
                ),
              )
              : Text("Unknown post type"),
        ),
      ),
    );
  }
}
