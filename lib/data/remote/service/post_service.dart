import 'package:dio/dio.dart';

import '../dto/post_dto.dart';

sealed class AppError {
  const AppError();
}

class NetworkError extends AppError {
  const NetworkError();
}

class UnauthorizedError extends AppError {
  const UnauthorizedError();
}

class NotFoundError extends AppError {
  final String resource;

  const NotFoundError(this.resource);
}

class ServerError extends AppError {
  final int code;

  const ServerError(this.code);
}

class UnknownError extends AppError {
  final String message;

  const UnknownError(this.message);
}

AppError mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
      return const NetworkError();

    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode ?? 0;

      if (statusCode == 401 || statusCode == 403) {
        return const UnauthorizedError();
      }

      if (statusCode == 404) {
        return const NotFoundError('Post');
      }

      if (statusCode >= 500) {
        return ServerError(statusCode);
      }

      return UnknownError(e.message ?? 'Error desconocido');

    default:
      return UnknownError(e.message ?? 'Error desconocido');
  }
}

class PostService {
  final Dio _dio;

  PostService(this._dio);

  Future<List<PostDto>> fetchPosts({
    int page = 1,
    int limit = 15,
  }) async {
    final response = await _dio.get(
      '/posts',
      queryParameters: {
        '_page': page,
        '_limit': limit,
      },
    );

    final List data = response.data as List;

    return data
        .map((e) => PostDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
