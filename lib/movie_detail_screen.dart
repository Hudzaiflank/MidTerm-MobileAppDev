import 'package:flutter/material.dart';
import 'api_service.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;
  final ApiService apiService = ApiService();

  MovieDetailScreen({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: FutureBuilder<Map<String, dynamic>>(
          future: apiService.fetchMovieDetails(movieId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('');
            } else if (snapshot.hasError) {
              return Text('Movie Details');
            } else {
              final movie = snapshot.data!;
              return Text(
                movie['title'],
                style: TextStyle(fontWeight: FontWeight.bold),
              );
            }
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: apiService.fetchMovieDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load details'));
          } else {
            final movie = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (movie['poster_path'] != null)
                    Center(
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                        height: 300,
                      ),
                    ),
                  SizedBox(height: 10),
                  Text(
                    movie['title'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Release Date: ${movie['release_date']}'),
                  SizedBox(height: 10),
                  Text('Rating: ${movie['vote_average']}'),
                  SizedBox(height: 20),
                  Text(
                    'Overview',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(movie['overview'] ?? 'No overview available'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
