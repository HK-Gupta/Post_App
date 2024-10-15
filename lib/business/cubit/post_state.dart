import '../../data/models/post_model.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostModel> posts;
  PostLoaded({required this.posts});
}

class PostError extends PostState {
  final String message;
  PostError({required this.message});
}
