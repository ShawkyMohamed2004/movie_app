import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/api_constants.dart';
import '../controllers/search_controller.dart' as movie_search;
import '../../domain/entities/movie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final movie_search.SearchController searchController = Get.put(
    movie_search.SearchController(searchMoviesUseCase: Get.find()),
  );
  final TextEditingController textController = TextEditingController();

  // Popular search options that rotate
  final List<List<String>> _popularSearchSets = [
    ['Avengers', 'Spider-Man', 'Batman', 'Iron Man', 'Thor', 'Captain America'],
    [
      'Joker',
      'Wonder Woman',
      'Deadpool',
      'Fast & Furious',
      'John Wick',
      'Matrix',
    ],
    [
      'Transformers',
      'Star Wars',
      'Harry Potter',
      'Lord of the Rings',
      'Pirates',
      'Mission Impossible',
    ],
    [
      'Inception',
      'Interstellar',
      'The Dark Knight',
      'Titanic',
      'Avatar',
      'Frozen',
    ],
  ];

  int _currentSetIndex = 0;

  @override
  void initState() {
    super.initState();
    // Clear everything when entering
    searchController.clearSearch();
    textController.clear();

    // Rotate popular searches every 10 seconds
    _startPopularSearchRotation();
  }

  void _startPopularSearchRotation() {
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _currentSetIndex = (_currentSetIndex + 1) % _popularSearchSets.length;
        });
        _startPopularSearchRotation();
      }
    });
  }

  List<String> get _currentPopularSearches {
    return _popularSearchSets[_currentSetIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Search Movies',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2D3E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF6C5CE7), width: 1.5),
            ),
            child: TextField(
              controller: textController,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: const InputDecoration(
                hintText: 'Search for movies...',
                hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 16),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFF9CA3AF),
                  size: 24,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  searchController.onSearchChanged(value);
                } else {
                  searchController.clearSearch();
                }
                setState(() {});
              },
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  searchController.addToHistory(value.trim());
                }
              },
            ),
          ),

          // Content
          Expanded(
            child: Obx(() {
              // Loading
              if (searchController.isSearching) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF6C5CE7)),
                );
              }

              // Search Results
              if (textController.text.isNotEmpty &&
                  searchController.searchResults.isNotEmpty) {
                return _buildSearchResults();
              }

              // Suggestions while typing
              if (textController.text.isNotEmpty &&
                  searchController.suggestions.isNotEmpty &&
                  searchController.searchResults.isEmpty) {
                return _buildSuggestions();
              }

              // No results
              if (textController.text.isNotEmpty &&
                  searchController.searchResults.isEmpty &&
                  !searchController.isSearching) {
                return const Center(
                  child: Text(
                    'No movies found',
                    style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 16),
                  ),
                );
              }

              // Empty state (default)
              return _buildEmptyState();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),

          // Popular Searches
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: const Text(
              'Popular Searches',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),

          const SizedBox(height: 16),

          // Horizontal scrollable popular searches with animation
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: SizedBox(
              key: ValueKey(_currentSetIndex),
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _currentPopularSearches.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < _currentPopularSearches.length - 1
                          ? 12
                          : 0,
                    ),
                    child: _buildPopularChipSmall(
                      _currentPopularSearches[index],
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Search History Section
          Obx(() {
            if (searchController.searchHistory.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Searches',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            searchController.clearSearchHistory();
                          },
                          child: const Text(
                            'Clear All',
                            style: TextStyle(
                              color: Color(0xFF6C5CE7),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  ...searchController.searchHistory
                      .take(8)
                      .map((query) => _buildHistoryItem(query)),

                  const SizedBox(height: 24),
                ],
              );
            }
            return const SizedBox.shrink();
          }),

          // Empty illustration and text
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF6B7280),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.movie_outlined,
              size: 40,
              color: Colors.white54,
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Search for your favorite movies',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          const Text(
            'Discover amazing movies and TV shows',
            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildPopularChipSmall(String text) {
    return GestureDetector(
      onTap: () {
        textController.text = text;
        searchController.onSearchChanged(text);
        searchController.addToHistory(text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2D3E),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF6C5CE7).withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String query) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () {
          textController.text = query;
          searchController.onSearchChanged(query);
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2D3E).withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.history, color: Color(0xFF9CA3AF), size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  query,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: () {
                  searchController.removeFromHistory(query);
                },
                child: const Icon(
                  Icons.close,
                  color: Color(0xFF9CA3AF),
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Suggestions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: searchController.suggestions
                  .map((suggestion) => _buildSuggestionChip(suggestion))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String suggestion) {
    return GestureDetector(
      onTap: () {
        textController.text = suggestion;
        searchController.onSearchChanged(suggestion);
        searchController.addToHistory(suggestion);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2D3E),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF6C5CE7).withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Text(
          suggestion,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.65,
        ),
        itemCount: searchController.searchResults.length,
        itemBuilder: (context, index) {
          final movie = searchController.searchResults[index];
          return _buildMovieCard(movie);
        },
      ),
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return GestureDetector(
      onTap: () => Get.toNamed('/movie-details', arguments: movie.id),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2D3E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: movie.posterPath != null && movie.posterPath!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: ApiConstants.getFullImageUrl(
                          movie.posterPath!,
                        ),
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: const Color(0xFF1F2937),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF6C5CE7),
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: const Color(0xFF1F2937),
                          child: const Icon(
                            Icons.movie_outlined,
                            color: Color(0xFF9CA3AF),
                            size: 40,
                          ),
                        ),
                      )
                    : Container(
                        color: const Color(0xFF1F2937),
                        child: const Center(
                          child: Icon(
                            Icons.movie_outlined,
                            color: Color(0xFF9CA3AF),
                            size: 40,
                          ),
                        ),
                      ),
              ),
            ),

            // Movie Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        movie.releaseDate.isNotEmpty
                            ? movie.releaseDate.split('-')[0]
                            : 'N/A',
                        style: const TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
