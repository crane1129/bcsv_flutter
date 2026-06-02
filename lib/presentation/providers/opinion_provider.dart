import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:http/http.dart' as http;

class UnconfirmedOpinionNotifier extends StateNotifier<int> {
  UnconfirmedOpinionNotifier() : super(0);

  void setCount(int count) => state = count;
  void reset() => state = 0;

  Future<void> loadIfStaffEnabled() async {
    final isOpinion = await UserSharedPreferences.isStaffOpinionModeEnabled();
    if (!isOpinion) {
      state = 0;
      return;
    }
    try {
      final Uri uri = ApiEndpoint.apiMap['UNCONFIRMED_OPINIONS_COUNT'] ??
          Uri.https('www.bridgeway.online', '/_functions/unconfirmedOpinions');
      final response = await http.get(uri).timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        int count;
        if (body is Map && body.containsKey('count')) {
          count = (body['count'] as num).toInt();
        } else if (body is Map && body.containsKey('result')) {
          final list = body['result'];
          count = (list is List) ? list.length : 0;
        } else if (body is List) {
          count = body.length;
        } else {
          count = 0;
        }
        state = count;
      }
    } catch (e) {
      log('⚠️ [OpinionProvider] Failed to load unconfirmed count: $e');
    }
  }
}

final unconfirmedOpinionNotifierProvider =
    StateNotifierProvider<UnconfirmedOpinionNotifier, int>((ref) {
  return UnconfirmedOpinionNotifier();
});

final hasUnconfirmedOpinionsProvider = Provider<bool>((ref) {
  return ref.watch(unconfirmedOpinionNotifierProvider) > 0;
});
