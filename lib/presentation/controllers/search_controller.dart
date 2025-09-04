import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/search_movies_usecase.dart';

class SearchController extends GetxController {
  final SearchMoviesUseCase _searchMoviesUseCase;

  SearchController({required SearchMoviesUseCase searchMoviesUseCase})
    : _searchMoviesUseCase = searchMoviesUseCase;

  // Text controller for preserving search text
  late final TextEditingController textController;

  // Observable data
  final RxList<Movie> _searchResults = <Movie>[].obs;
  final RxList<String> _suggestions = <String>[].obs;
  final RxList<String> _searchHistory = <String>[].obs;
  final RxString _searchQuery = ''.obs;
  final RxBool _isSearching = false.obs;
  final RxBool _isLoadingSuggestions = false.obs;
  final RxString _error = ''.obs;

  // Debouncer for search
  Timer? _debounce;
  Timer? _finalSearchTimer;

  static const String _searchHistoryKey = 'search_history';

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    _loadSearchHistory();
    // Always start with empty search bar
    _searchQuery.value = '';
    textController.clear();

    // Clear any existing corrupted history on first launch
    _cleanupHistory();
  }

  // Load search history from storage
  Future<void> _loadSearchHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getStringList(_searchHistoryKey) ?? [];
      _searchHistory.assignAll(historyJson);
    } catch (e) {
      // Error loading search history, continue with empty history
    }
  }

  // Save search history to storage
  Future<void> _saveSearchHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_searchHistoryKey, _searchHistory);
    } catch (e) {
      // Error saving search history
    }
  }

  // Clean up corrupted/partial search history
  Future<void> _cleanupHistory() async {
    // Remove short searches (less than 3 characters) as they're likely partial
    _searchHistory.removeWhere((item) => item.trim().length < 3);

    // Remove duplicates and keep only unique searches
    final uniqueHistory = <String>[];
    for (final item in _searchHistory) {
      if (!uniqueHistory.contains(item.toLowerCase())) {
        uniqueHistory.add(item);
      }
    }

    _searchHistory.assignAll(uniqueHistory);
    await _saveSearchHistory();
  }

  // Add search term to history (public method)
  void addToHistory(String query) {
    _addToHistory(query);
  }

  // Add search term to history (private implementation)
  void _addToHistory(String query) {
    final trimmedQuery = query.trim();

    // Only add if query is meaningful (3+ characters)
    if (trimmedQuery.length < 3) return;

    // Remove if already exists to avoid duplicates
    _searchHistory.remove(trimmedQuery);

    // Add to beginning of list
    _searchHistory.insert(0, trimmedQuery);

    // Keep only latest 10 searches
    if (_searchHistory.length > 10) {
      _searchHistory.removeRange(10, _searchHistory.length);
    }

    _saveSearchHistory();
  }

  // Getters
  List<Movie> get searchResults => _searchResults;
  List<String> get suggestions => _suggestions;
  List<String> get searchHistory => _searchHistory;
  String get searchQuery => _searchQuery.value;
  bool get isSearching => _isSearching.value;
  bool get isLoadingSuggestions => _isLoadingSuggestions.value;
  String get error => _error.value;

  bool get hasQuery => searchQuery.trim().isNotEmpty;
  bool get hasResults => searchResults.isNotEmpty;
  bool get hasSuggestions => suggestions.isNotEmpty;
  bool get hasSearchHistory => searchHistory.isNotEmpty;
  bool get showEmptyState => !isSearching && hasQuery && !hasResults;

  void onSearchChanged(String query) {
    _searchQuery.value = query;
    textController.text = query; // Keep text controller in sync

    // Cancel previous debounce timers
    _debounce?.cancel();
    _finalSearchTimer?.cancel();

    if (query.trim().isEmpty) {
      _searchResults.clear();
      _suggestions.clear();
      _error.value = '';
      return;
    }

    // Start debounce for live search (no history)
    _debounce = Timer(
      const Duration(milliseconds: 300),
      () => _performLiveSearch(query),
    );

    // Start longer timer for final search (with history)
    _finalSearchTimer = Timer(
      const Duration(milliseconds: 2000), // 2 seconds of no typing
      () {
        if (_searchResults.isNotEmpty) {
          _addToHistory(query.trim());
        }
      },
    );
  }

  Future<void> _performLiveSearch(String query) async {
    if (query.trim().isEmpty) return;

    try {
      _isSearching.value = true;
      _error.value = '';

      final results = await _searchMoviesUseCase.call(query.trim());
      _searchResults.assignAll(results);

      // Don't add to history automatically - only when user explicitly searches

      // Generate suggestions from search results
      _generateSuggestions(results, query);

      if (results.isEmpty) {
        _error.value = 'No movies found for "$query"';
      }
    } catch (e) {
      _error.value = 'Search failed: ${e.toString()}';
      _searchResults.clear();
      _suggestions.clear();
    } finally {
      _isSearching.value = false;
    }
  }

  void _generateSuggestions(List<Movie> results, String query) {
    final suggestionSet = <String>{};

    // Add similar movie titles as suggestions
    for (final movie in results.take(5)) {
      // Add movie title
      suggestionSet.add(movie.title);

      // Add words from title
      final words = movie.title.split(' ');
      for (final word in words) {
        if (word.length > 3) {
          suggestionSet.add(word);
        }
      }
    }

    // Add popular search terms
    final popularTerms = [
      'Action',
      'Adventure',
      'Comedy',
      'Drama',
      'Horror',
      'Thriller',
      'Sci-Fi',
      'Romance',
      'Animation',
      'Fantasy',
    ];

    suggestionSet.addAll(
      popularTerms.where(
        (term) => term.toLowerCase().contains(query.toLowerCase()),
      ),
    );

    _suggestions.assignAll(suggestionSet.take(8).toList());
  }

  // Perform final search and add to history
  Future<void> performFinalSearch(String query) async {
    if (query.trim().isEmpty) return;

    await _performLiveSearch(query);

    // Add to history only after successful search with results
    if (_searchResults.isNotEmpty) {
      _addToHistory(query.trim());
    }
  }

  void selectSuggestion(String suggestion) {
    _searchQuery.value = suggestion;
    textController.text = suggestion;

    // Perform final search and add to history
    _debounce?.cancel();
    performFinalSearch(suggestion);
  }

  // Select from search history
  void selectFromHistory(String historyItem) {
    _searchQuery.value = historyItem;
    textController.text = historyItem;

    // Perform search immediately (no need to add to history again)
    _debounce?.cancel();
    _performLiveSearch(historyItem);
  }

  // Remove item from search history
  void removeFromHistory(String historyItem) {
    _searchHistory.remove(historyItem);
    _saveSearchHistory();
  }

  // Clear all search history
  void clearSearchHistory() {
    _searchHistory.clear();
    _saveSearchHistory();
  }

  // Reset search state when leaving the screen
  void resetSearchState() {
    _searchQuery.value = '';
    _searchResults.clear();
    _suggestions.clear();
    _error.value = '';
    textController.clear();
    _debounce?.cancel();
    _finalSearchTimer?.cancel();
  }

  void clearSearch() {
    _searchQuery.value = '';
    _searchResults.clear();
    _suggestions.clear();
    _error.value = '';
    textController.clear();
    _debounce?.cancel();
    _finalSearchTimer?.cancel();
    // Don't clear history, just the current search
  }

  void clearError() {
    _error.value = '';
  }

  @override
  void onClose() {
    _debounce?.cancel();
    _finalSearchTimer?.cancel();
    textController.dispose();
    super.onClose();
  }
}
