import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/app_constants.dart';
import '../../../core/errors/exceptions.dart';
import '../../models/album_model.dart';

abstract class AlbumRemoteDataSource {
  Future<List<AlbumModel>> getAlbums();
  Future<AlbumModel> getAlbumDetails(int id);
}

class AlbumRemoteDataSourceImpl implements AlbumRemoteDataSource {
  final http.Client client;

  AlbumRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AlbumModel>> getAlbums() async {
    final response = await client.get(Uri.parse(AppConstants.albumsEndpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => AlbumModel.fromJson(item)).toList();
    } else {
      throw ServerException('Failed to load albums');
    }
  }

  @override
  Future<AlbumModel> getAlbumDetails(int id) async {
    final response = await client.get(Uri.parse('${AppConstants.baseUrl}/albums/$id'));
    if (response.statusCode == 200) {
      return AlbumModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException('Failed to load album details');
    }
  }
}