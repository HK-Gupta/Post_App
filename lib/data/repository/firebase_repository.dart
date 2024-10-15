import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';

class FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all posts from Firestore
  Future<List<PostModel>> fetchPosts() async {
    List<PostModel> posts = [];
    try {
      QuerySnapshot snapshot = await _firestore.collection('posts').get();
      posts = snapshot.docs.map((doc) => PostModel.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Error fetching posts');
    }
    return posts;
  }
}

