import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_sharing/business/cubit/post_cubit.dart';
import 'package:post_sharing/business/cubit/post_state.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/post_widget.dart';

class TextPostPage extends StatelessWidget {
  const TextPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(firebaseRepository: context.read())..fetchPosts(),
      child: Scaffold(
        body: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostLoaded) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  if (post.type == 'text') {
                    return PostWidget(
                      content: post.content,
                      postType: post.type,
                      postId: post.id,
                      onShare: () {
                        Share.share('Check out this image post: ${post.content}');
                      },
                    );
                  }
                  return Container(); // Skip non-text posts
                },
              );
            } else if (state is PostError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('No posts available.'));
            }
          },
        ),
      ),
    );
  }


}
