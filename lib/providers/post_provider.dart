import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../services/post_service.dart';
import '../services/like_service.dart';

class PostProvider extends ChangeNotifier {
  final PostService _postService = PostService();
  final LikeService _likeService = LikeService();

  List<PostModel> posts = [];

  bool loading = false;

  Future<void> loadFeed() async {
    loading = true;
    notifyListeners();

    posts = await _postService.getFeed();

    loading = false;
    notifyListeners();
  }

  Future<void> toggleLike(PostModel post) async {
    if (post.liked) {
      final success = await _likeService.unlikePost(post.id);

      if (success) {
        post.liked = false;
        post.likes--;
        notifyListeners();
      }
    } else {
      final success = await _likeService.likePost(post.id);

      if (success) {
        post.liked = true;
        post.likes++;
        notifyListeners();
      }
    }
  }
}