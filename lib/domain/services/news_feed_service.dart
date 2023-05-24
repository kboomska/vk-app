import 'package:vk_app/domain/entity/news_feed/posts/news_feed_response.dart';
import 'package:vk_app/domain/data_provider/access_data_provider.dart';
import 'package:vk_app/domain/api_client/news_feed_api_client.dart';
import 'package:vk_app/configuration/configuration.dart';

class NewsFeedService {
  final _newsFeedApiClient = NewsFeedApiClient();
  final _accessDataProvider = AccessDataProvider();

  Future<NewsFeedResponse> getNewsFeed(
    String? startFrom,
  ) async {
    final accessToken = await _accessDataProvider.getAccessToken();
    return _newsFeedApiClient.getNewsFeed(
      accessToken,
      startFrom,
      Configuration.versionApi,
    );
  }
}
