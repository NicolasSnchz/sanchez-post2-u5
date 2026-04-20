import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/remote/service/post_service.dart';
import '../providers/posts_provider.dart';

class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({super.key});

  @override
  ConsumerState<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        ref.read(postsProvider.notifier).fetchNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postsAsync = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts - Unidad 5'),
      ),
      body: postsAsync.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (err, _) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _errorMessage(err),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(postsProvider.notifier).refresh();
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          );
        },
        data: (posts) {
          if (posts.isEmpty) {
            return const Center(
              child: Text('No hay posts disponibles.'),
            );
          }

          return RefreshIndicator(
            onRefresh: () {
              return ref.read(postsProvider.notifier).refresh();
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${post.userId}'),
                  ),
                  title: Text(
                    post.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    post.excerpt,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  String _errorMessage(Object err) {
    return switch (err) {
      NetworkError() => 'Sin conexión a internet.',
      UnauthorizedError() => 'No autorizado.',
      NotFoundError(resource: final resource) => 'No se encontró: $resource.',
      ServerError(code: final code) => 'Error del servidor ($code).',
      UnknownError(message: final message) => 'Error inesperado: $message',
      _ => 'Error inesperado.',
    };
  }
}
