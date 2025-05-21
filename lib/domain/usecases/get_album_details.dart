import '../entities/album.dart';
import '../repositories/album_repository.dart';

class GetAlbumDetails {
  final AlbumRepository repository;

  GetAlbumDetails(this.repository);

  Future<Album> call(int id) async {
    return await repository.getAlbumDetails(id);
  }
}