// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/person_model.dart';

import 'package:http/http.dart' as http;

const baseUrl = 'https://api.themoviedb.org/3/';
const key = '?api_key=$apiKey';

class ApiServices {
  Future<Result> getTopRatedMovies() async {
    var endPoint = 'movie/top_rated';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<Result> getNowPlayingMovies() async {
    var endPoint = 'movie/now_playing';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<Result> getUpcomingMovies() async {
    var endPoint = 'movie/upcoming';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load upcoming movies');
  }

  Future<Result> getRecommendedMovies(int movieId) async {
    var endPoint = 'movie/$movieId';
    final url = '$baseUrl/$endPoint/recommendations?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load recommended movies');
    }
  }

  Future<ResultActor> getPopularActors() async {
    final response =
        await http.get(Uri.parse('${baseUrl}person/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      return ResultActor.fromRawJson(response.body);
    } else {
      throw Exception('Failed to load popular actors');
    }
  }

  Future<Actor> getActorDetails(int personId) async {
    var endPoint = 'person/$personId';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      return Actor.fromJson(
        jsonDecode(response.body),
      );
    }
    throw Exception('Failed to load actor details');
  }
}
