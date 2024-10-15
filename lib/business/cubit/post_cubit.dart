import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_sharing/business/cubit/post_state.dart';

import '../../data/models/post_model.dart';
import '../../data/repository/firebase_repository.dart';

class PostCubit extends Cubit<PostState> {
  final FirebaseRepository firebaseRepository;

  PostCubit({required this.firebaseRepository}) : super(PostInitial());

  // Method to fetch posts from Firebase
  Future<void> fetchPosts() async {
    try {
      emit(PostLoading());
      List<PostModel> posts = await firebaseRepository.fetchPosts();
      emit(PostLoaded(posts: posts));
    } catch (e) {
      emit(PostError(message: 'Failed to load posts'));
    }
  }
}

