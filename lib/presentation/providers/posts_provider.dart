import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/remote/dto/post_dto.dart';
import '../../data/remote/network/dio_client.dart';
import '../../data/remote/service/post_service.dart';
import '../../domain/model/post.dart';

final dioProvider = Provider<Dio>((ref) {
  return buildDioClient();
});

final postServiceProvider = Provider<PostService>((ref) {
  return PostService(ref.watch(dioProvider));
});

class PostsNotifier extends AsyncNotifier<List<Post>> {
  int _page = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  @override
  Future<List<Post>> build() async {
    _page = 1;
    _hasMore = true;
    return _fetchPage(_page);
  }

  Future<List<Post>> _fetchPage(int page) async {
    final service = ref.read(postServiceProvider);

    try {
      final dtos = await service.fetchPosts(
        page: page,
        limit: 15,
      );

      _hasMore = dtos.length == 15;

      return dtos.map((dto) => dto.toDomain()).toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<void> fetchNextPage() async {
    if (!_hasMore || _isLoadingMore) return;

    final currentPosts = state.valueOrNull ?? [];
    final nextPage = _page + 1;

    _isLoadingMore = true;

    try {
      final newPosts = await _fetchPage(nextPage);
      _page = nextPage;
      state = AsyncValue.data([...currentPosts, ...newPosts]);
    } on AppError catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> refresh() async {
    _page = 1;
    _hasMore = true;

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return _fetchPage(1);
    });
  }
}

final postsProvider = AsyncNotifierProvider<PostsNotifier, List<Post>>(
  PostsNotifier.new,
);