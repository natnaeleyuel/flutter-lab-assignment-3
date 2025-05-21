import '../entities/album.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAlbums();
  Future<Album> getAlbumDetails(int id);
}
