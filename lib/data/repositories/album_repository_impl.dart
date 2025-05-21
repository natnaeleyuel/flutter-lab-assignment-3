import '../../domain/entities/album.dart';
import '../../domain/repositories/album_repository.dart';
import '../datasources/local/album_local_data_source.dart';
import '../datasources/remote/album_remote_data_source.dart';
import '../models/album_model.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumRemoteDataSource remoteDataSource;
  final AlbumLocalDataSource localDataSource;

  AlbumRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Album>> getAlbums() async {
    try {
      final remoteAlbums = await remoteDataSource.getAlbums();
      // Cache all albums when we fetch the list
      await Future.wait(
          remoteAlbums.map((album) => localDataSource.cacheAlbumDetails(album))
      );
      await localDataSource.cacheAlbums(remoteAlbums);
      return remoteAlbums.map((model) => model.toEntity()).toList();
    } catch (_) {
      final cachedAlbums = await localDataSource.getCachedAlbums();
      return cachedAlbums.map((model) => model.toEntity()).toList();
    }
  }

  @override
  Future<Album> getAlbumDetails(int id) async {
    try {
      final remoteAlbum = await remoteDataSource.getAlbumDetails(id);
      await localDataSource.cacheAlbumDetails(remoteAlbum);
      return remoteAlbum.toEntity();
    } catch (_) {
      final cachedAlbum = await localDataSource.getCachedAlbumDetails(id);
      if (cachedAlbum != null) {
        return cachedAlbum.toEntity();
      }
      rethrow;
    }
  }
}

extension on AlbumModel {
  Album toEntity() {
    return Album(
      id: id,
      userId: userId,
      title: title,
    );
  }
}