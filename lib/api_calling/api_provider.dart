import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_in_flutter_with_api/model_classes/post_model_class.dart';

abstract class ApiProvider {
  String baseUrl = 'https://jsonplaceholder.typicode.com/';
  String get endPoint;
  String get url => baseUrl + endPoint;
  dynamic fetch({String endpoint = ''}) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return;
    }
  }
}

class PostApi extends ApiProvider {
  static PostApi? postApi;
  PostApi._internal();
  factory PostApi() {
    return postApi ??= PostApi._internal();
  }

  Future<List<PostModelClass>> fetchPosts() async {
    var posts = await fetch() as List;
    var data = posts.map((e) => PostModelClass.fromMap(e)).toList();
    return data;
  }

  @override
  String get endPoint => 'posts';
}
