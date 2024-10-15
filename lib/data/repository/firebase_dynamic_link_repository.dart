import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class FirebaseDynamicLinksRepository {
  // Generate Firebase dynamic link for the post
  Future<String> createDynamicLink(String postId, String postType) async {
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: 'https://yourappname.page.link',  // Your Firebase dynamic link prefix
      link: Uri.parse('https://yourappname.com/post?postId=$postId&postType=$postType'),  // Web fallback URL
      androidParameters: AndroidParameters(
        packageName: 'com.example.yourappname',  // Replace with your app's package name
        minimumVersion: 1,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.example.yourappname',  // Replace with your app's bundle ID
        minimumVersion: '1.0.0',
      ),
    );

    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    return dynamicLink.shortUrl.toString();
  }
}
