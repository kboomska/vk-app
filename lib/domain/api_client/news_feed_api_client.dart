import 'package:vk_app/domain/entity/news_feed/posts/news_feed_response.dart';
import 'package:vk_app/domain/entity/news_feed/posts/json_response.dart';
import 'package:vk_app/domain/api_client/network_client.dart';

class NewsFeedApiClient {
  final _networkClient = NetworkClient();

  Future<NewsFeedResponse> getNewsFeed(
    String? accessToken,
    String? startFrom,
    String versionApi,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final jsonResponse = JsonResponse.fromJson(jsonMap);
      return jsonResponse.response;
    }

    final parameters = <String, dynamic>{
      'filters': 'post',
      'start_from': startFrom,
      'access_token': accessToken,
      'v': versionApi,
    };

    final result = _networkClient.post(
      '/newsfeed.get',
      parser,
      parameters,
    );

    return result;
  }
}
