import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TabType { about, skillset }

class NavigationState {
  final TabType selectedTab;
  final bool isMenuOpen;
  final bool isPreloaderVisible;

  NavigationState({
    this.selectedTab = TabType.about,
    this.isMenuOpen = false,
    this.isPreloaderVisible = true,
  });

  NavigationState copyWith({
    TabType? selectedTab,
    bool? isMenuOpen,
    bool? isPreloaderVisible,
  }) {
    return NavigationState(
      selectedTab: selectedTab ?? this.selectedTab,
      isMenuOpen: isMenuOpen ?? this.isMenuOpen,
      isPreloaderVisible: isPreloaderVisible ?? this.isPreloaderVisible,
    );
  }
}

class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier() : super(NavigationState());

  void selectTab(TabType tab) {
    state = state.copyWith(selectedTab: tab);
  }

  void toggleMenu() {
    state = state.copyWith(isMenuOpen: !state.isMenuOpen);
  }

  void closeMenu() {
    state = state.copyWith(isMenuOpen: false);
  }

  void hidePreloader() {
    state = state.copyWith(isPreloaderVisible: false);
  }
}

final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});

