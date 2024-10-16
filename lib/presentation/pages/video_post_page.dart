import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_sharing/business/cubit/post_cubit.dart';
import 'package:post_sharing/business/cubit/post_state.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/post_widget.dart';

class VideoPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<PostCubit>().fetchPosts();

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PostLoaded) {
          final videoPosts = state.posts.where((post) => post.type == 'video').toList();

          if (videoPosts.isEmpty) {
            return Center(child: Text("No video posts available"));
          }

          return ListView.builder(
            itemCount: videoPosts.length,
            itemBuilder: (context, index) {
              final post = videoPosts[index];

              return PostWidget(
                content: post.content,
                url: post.url,  // Pass the video URL to the widget
                postType: post.type,
                postId: post.id,
                onShare: () {
                  Share.share('Check out this video post: ${post.url}');
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
