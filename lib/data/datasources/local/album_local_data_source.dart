import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/errors/exceptions.dart';
import '../../models/album_model.dart';
import '../../models/photo_model.dart';

abstract class AlbumLocalDataSource {
  Future<List<AlbumModel>> getCachedAlbums();
  Future<void> cacheAlbums(List<AlbumModel> albums);
  Future<void> cacheAlbumDetails(AlbumModel album);
  Future<AlbumModel?> getCachedAlbumDetails(int id);
  Future<void> cachePhotos(List<PhotoModel> photos);
  Future<List<PhotoModel>> getCachedPhotos(int albumId);
}

class AlbumLocalDataSourceImpl implements AlbumLocalDataSource {
  final SharedPreferences sharedPreferences;

  AlbumLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheAlbums(List<AlbumModel> albums) async {
    for (final album in albums) {
      await cacheAlbumDetails(album);
    }
    final albumsJson = albums.map((album) => jsonEncode(album.toJson())).toList();
    await sharedPreferences.setStringList(AppConstants.cachedAlbumsKey, albumsJson);
  }

  @override
  Future<List<AlbumModel>> getCachedAlbums() async {
    final albumsJson = sharedPreferences.getStringList(AppConstants.cachedAlbumsKey);
    if (albumsJson == null) {
      throw CacheException('No cached data found');
    }
    return albumsJson.map((json) => AlbumModel.fromJson(jsonDecode(json))).toList();
  }

  @override
  Future<void> cacheAlbumDetails(AlbumModel album) async {
    final albumJson = jsonEncode(album.toJson());
    await sharedPreferences.setString('album_${album.id}', albumJson);
  }

  @override
  Future<AlbumModel?> getCachedAlbumDetails(int id) async {
    final albumJson = sharedPreferences.getString('album_$id');
    if (albumJson != null) {
      return AlbumModel.fromJson(jsonDecode(albumJson));
    }
    return null;
  }

  @override
  Future<void> cachePhotos(List<PhotoModel> photos) async {
    final photosJson = photos.map((photo) => jsonEncode(photo.toJson())).toList();
    await sharedPreferences.setStringList(
      'photos_${photos.first.albumId}',
      photosJson,
    );
  }

  @override
  Future<List<PhotoModel>> getCachedPhotos(int albumId) async {
    final photosJson = sharedPreferences.getStringList('photos_$albumId');
    if (photosJson == null) throw CacheException('No cached photos');
    return photosJson.map((json) => PhotoModel.fromJson(jsonDecode(json))).toList();
  }
}