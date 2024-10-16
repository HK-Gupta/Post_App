import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_sharing/business/cubit/post_cubit.dart';
import 'package:post_sharing/business/cubit/post_state.dart';
import 'package:share_plus/share_plus.dart'; // For sharing functionality
import '../widgets/post_widget.dart';

class ImagePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Trigger fetchPosts method when the widget is built
    context.read<PostCubit>().fetchPosts();

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PostLoaded) {
          // Filter posts of type 'image'
          final imagePosts = state.posts.where((post) => post.type == 'image').toList();

          // Check if there are any image posts
          if (imagePosts.isEmpty) {
            return Center(child: Text("No image posts available"));
          }

          // Use ListView to display all image posts
          return ListView.builder(
            itemCount: imagePosts.length,
            itemBuilder: (context, index) {
              final post = imagePosts[index];

              return PostWidget(
                content: post.content,
                url: post.url,  // Pass the image URL to the widget
                postType: post.type,
                postId: post.id,
                onShare: () {
                  // Use the share_plus plugin to share the link
                  Share.share('Check out this image post: ${post.url}');
                },
              );
            },
          );
        } else if (state is PostError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text("Unknown state"));
        }
      },
    );
  }
}
