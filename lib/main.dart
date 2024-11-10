import 'package:flutter/material.dart';
import 'api_service.dart';
import 'movie_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieScreen(),
    );
  }
}

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> movies = [];
  Set<int> movieIds = Set(); // ini biar movie nya kaga duplikat
  int page = 1;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  void fetchMovies() async {
    final result = await apiService.fetchMovies(page);
    setState(() {
      result.forEach((movie) {
        if (!movieIds.contains(movie['id'])) {
          // Mencegah duplikasi
          movies.add(movie);
          movieIds.add(movie['id']);
        }
      });
      page++;
    });
  }

  void searchMovies(String query) async {
    final result = await apiService.searchMovies(query);
    setState(() {
      movies = result;
      movieIds = result.map<int>((movie) => movie['id']).toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Center(
          child: Text(
            'Movie App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search movies...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (query) {
                setState(() {
                  searchQuery = query;
                  page = 1;
                  movies.clear();
                  movieIds.clear();
                });
                if (query.isEmpty) {
                  fetchMovies();
                } else {
                  searchMovies(query);
                }
              },
            ),
          ),
          Expanded(
            child: movies.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return ListTile(
                        leading: movie['poster_path'] != null
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
                                width: 50,
                                fit: BoxFit.cover,
                              )
                            : SizedBox(width: 50),
                        title: Text(
                          movie['title'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Rating: ${movie['vote_average']}"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailScreen(movieId: movie['id']),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
