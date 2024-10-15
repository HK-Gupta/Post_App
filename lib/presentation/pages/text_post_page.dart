import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_sharing/business/cubit/post_cubit.dart';
import 'package:post_sharing/business/cubit/post_state.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/post_widget.dart';

class TextPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(firebaseRepository: context.read())..fetchPosts(),
      child: Scaffold(
        body: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return Center(child: CircularProgressIndicator());
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
                      onShare: () async {
                        final shareLink = await _generateDynamicLink(post.id, post.type);
                        Share.share('Check out this post: $shareLink');
                      },
                    );
                  }
                  return Container(); // Skip non-text posts
                },
              );
            } else if (state is PostError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('No posts available.'));
            }
          },
        ),
      ),
    );
  }

  // Dynamic Link generator for sharing posts
  Future<String> _generateDynamicLink(String postId, String postType) async {
    // You can adjust this method to fit Firebase Dynamic Links or any deep link you want
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: 'https://yourapp.page.link',
      link: Uri.parse('https://yourapp.com/?postId=$postId&postType=$postType'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.post_sharing',
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.example.post_sharing',
        minimumVersion: '1.0.0',
      ),
    );

    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    return dynamicLink.shortUrl.toString();
  }
}
