import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/domain/entities/announcement.dart';
import 'package:bcsv_flutter_project/domain/repositories/announcement_repository.dart';
import 'package:bcsv_flutter_project/data/repositories/announcement_repository_impl.dart';
import 'dart:developer';

/// State for announcement list
enum AnnouncementStatus { initial, loading, loaded, error }

class AnnouncementState {
  final List<AnnouncementEntity> announcements;
  final AnnouncementStatus status;
  final String? errorMessage;
  final DateTime? lastUpdated;
  final bool isOfflineData;

  const AnnouncementState({
    this.announcements = const [],
    this.status = AnnouncementStatus.initial,
    this.errorMessage,
    this.lastUpdated,
    this.isOfflineData = false,
  });

  AnnouncementState copyWith({
    List<AnnouncementEntity>? announcements,
    AnnouncementStatus? status,
    String? errorMessage,
    DateTime? lastUpdated,
    bool? isOfflineData,
  }) {
    return AnnouncementState(
      announcements: announcements ?? this.announcements,
      status: status ?? this.status,
      errorMessage: errorMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isOfflineData: isOfflineData ?? this.isOfflineData,
    );
  }

  bool get isLoading => status == AnnouncementStatus.loading;
  bool get hasError => status == AnnouncementStatus.error;
  bool get hasData => announcements.isNotEmpty;
  bool get isEmpty => announcements.isEmpty && status == AnnouncementStatus.loaded;
}

/// Notifier for announcement state
class AnnouncementNotifier extends StateNotifier<AnnouncementState> {
  final AnnouncementRepository _repository;

  AnnouncementNotifier(this._repository) : super(const AnnouncementState());

  /// Load announcements (with caching).
  /// Shows a loading spinner only when no data is already displayed,
  /// so background refreshes don't flash the UI.
  Future<void> loadAnnouncements({bool forceRefresh = false}) async {
    log('🎯 [Announcement] loadAnnouncements called (forceRefresh: $forceRefresh, currentState: ${state.status})');

    if (state.isLoading) {
      log('⚠️ [Announcement] Already loading, skipping request');
      return;
    }

    // Only show loading spinner when the user has nothing to look at yet
    if (!state.hasData) {
      state = state.copyWith(status: AnnouncementStatus.loading);
    }

    try {
      final announcements = await _repository.getAnnouncements(
        forceRefresh: forceRefresh,
      );

      final lastUpdated = _repository.getLastUpdated();
      final wasFromCache = _repository.wasLastFetchFromCache();

      log('📊 [Announcement] Received ${announcements.length} items (${wasFromCache ? "CACHE" : "NETWORK"})');

      state = state.copyWith(
        announcements: announcements.reversed.toList(),
        status: AnnouncementStatus.loaded,
        lastUpdated: lastUpdated,
        isOfflineData: wasFromCache,
        errorMessage: null,
      );
    } catch (e) {
      log('❌ [Announcement] Error loading: $e');
      // Only show error state if there's no existing data to fall back on
      if (!state.hasData) {
        state = state.copyWith(
          status: AnnouncementStatus.error,
          errorMessage: e.toString(),
        );
      }
    }
  }

  /// Refresh announcements from network
  Future<void> refresh() async {
    await loadAnnouncements(forceRefresh: true);
  }

  /// Clear cache and reload
  Future<void> clearCacheAndReload() async {
    await _repository.clearCache();
    await loadAnnouncements(forceRefresh: true);
  }
}

/// Provider for announcement repository
final announcementRepositoryProvider = Provider<AnnouncementRepository>((ref) {
  return AnnouncementRepositoryImpl();
});

/// Provider for announcement state
final announcementNotifierProvider =
    StateNotifierProvider<AnnouncementNotifier, AnnouncementState>((ref) {
  final repository = ref.watch(announcementRepositoryProvider);
  return AnnouncementNotifier(repository);
});

/// Convenience provider for just the announcements list
final announcementsProvider = Provider<List<AnnouncementEntity>>((ref) {
  return ref.watch(announcementNotifierProvider).announcements;
});

/// Provider for loading state
final announcementsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(announcementNotifierProvider).isLoading;
});

/// Provider for checking if using offline data
final announcementsOfflineProvider = Provider<bool>((ref) {
  return ref.watch(announcementNotifierProvider).isOfflineData;
});
