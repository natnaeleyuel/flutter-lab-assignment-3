import '../entities/album.dart';
import '../repositories/album_repository.dart';

class GetAlbums {
  final AlbumRepository repository;

  GetAlbums(this.repository);

  Future<List<Album>> call() async {
    return await repository.getAlbums();
  }
}