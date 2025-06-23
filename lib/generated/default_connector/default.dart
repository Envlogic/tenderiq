library default_connector;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';

part 'log_manual_search.dart';

part 'log_ai_suggestion_click.dart';

part 'get_recommended_tenders.dart';

part 'get_watchlist_tenders.dart';

part 'get_followed_tender_count.dart';

part 'get_all_tenders.dart';

part 'get_user_profile.dart';

part 'get_notifications.dart';

part 'get_tender_details.dart';

part 'get_ai_search_context.dart';

part 'get_ai_suggestion_context.dart';







class DefaultConnector {
  
  
  LogManualSearchVariablesBuilder logManualSearch ({required String userId, required String queryText, required Timestamp timestamp, }) {
    return LogManualSearchVariablesBuilder(dataConnect, userId: userId,queryText: queryText,timestamp: timestamp,);
  }
  
  
  LogAiSuggestionClickVariablesBuilder logAiSuggestionClick ({required String userId, required String queryText, required Timestamp timestamp, }) {
    return LogAiSuggestionClickVariablesBuilder(dataConnect, userId: userId,queryText: queryText,timestamp: timestamp,);
  }
  
  
  GetRecommendedTendersVariablesBuilder getRecommendedTenders () {
    return GetRecommendedTendersVariablesBuilder(dataConnect, );
  }
  
  
  GetWatchlistTendersVariablesBuilder getWatchlistTenders () {
    return GetWatchlistTendersVariablesBuilder(dataConnect, );
  }
  
  
  GetFollowedTenderCountVariablesBuilder getFollowedTenderCount ({required String userId, }) {
    return GetFollowedTenderCountVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  GetAllTendersVariablesBuilder getAllTenders () {
    return GetAllTendersVariablesBuilder(dataConnect, );
  }
  
  
  GetUserProfileVariablesBuilder getUserProfile ({required String userId, }) {
    return GetUserProfileVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  GetNotificationsVariablesBuilder getNotifications ({required String userId, }) {
    return GetNotificationsVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  GetTenderDetailsVariablesBuilder getTenderDetails ({required String tenderId, }) {
    return GetTenderDetailsVariablesBuilder(dataConnect, tenderId: tenderId,);
  }
  
  
  GetAiSearchContextVariablesBuilder getAiSearchContext ({required String userId, }) {
    return GetAiSearchContextVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  GetAiSuggestionContextVariablesBuilder getAiSuggestionContext ({required String userId, }) {
    return GetAiSuggestionContextVariablesBuilder(dataConnect, userId: userId,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'asia-south1',
    'default',
    'tenderiq-f763c-service',
  );

  DefaultConnector({required this.dataConnect});
  static DefaultConnector get instance {
    return DefaultConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}

