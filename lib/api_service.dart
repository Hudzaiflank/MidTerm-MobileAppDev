import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey =
      "a5b867fb8b9a7cbf7b34d7543e7d82a1"; //ganti api ini, karena api ini menggunakan api key ane wkwk
  final String baseUrl = "https://api.themoviedb.org/3";

  Future<List<dynamic>> fetchMovies(int page) async {
    final response = await http
        .get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<dynamic>> searchMovies(String query) async {
    final response = await http
        .get(Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to search movies');
    }
  }
}
