// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_in_flutter_with_api/model_classes/post_model_class.dart';
import 'package:riverpod_in_flutter_with_api/api_calling/api_provider.dart';

@immutable
abstract class PostState {}

@immutable
class PostInitialState extends PostState {}

@immutable
class PostLoadingState extends PostState {}

@immutable
class PostLoadedState extends PostState {
  final List<PostModelClass> list;
  PostLoadedState({
    required this.list,
  });
}

class PostErrorState extends PostState {
  final String message;
  PostErrorState({
    required this.message,
  });
}

class PostStateNotifier extends StateNotifier<PostState> {
  PostStateNotifier() : super(PostInitialState());
  PostApi postApi = PostApi();
  fetchDataS() async {
    try {
      state = PostLoadingState();
      var listData = await postApi.fetchPosts();
      state = PostLoadedState(list: listData);
    } catch (e) {
      state = PostErrorState(message: e.toString());
    }
  }
}
