import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class SearchMoviesUseCase {
  final MovieRepository repository;

  SearchMoviesUseCase(this.repository);

  Future<List<Movie>> call(String query) async {
    if (query.trim().isEmpty) return [];
    return await repository.searchMovies(query);
  }
}
