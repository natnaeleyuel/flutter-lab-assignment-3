import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/album_repository_impl.dart';
import '../../domain/entities/album.dart';
import '../../domain/usecases/get_album_details.dart';
import '../bloc/album_bloc.dart';
import '../bloc/album_event.dart';

class AlbumDetailPage extends StatelessWidget {
  final int albumId;

  const AlbumDetailPage({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Album Details')),
      body: FutureBuilder<Album>(

        future: _getAlbumDetails(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 50, color: Colors.red),
                  const SizedBox(height: 20),
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      context.read<AlbumBloc>().add(FetchAlbums());
                      Navigator.pop(context);
                    },
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final album = snapshot.data!;
            return Padding(

              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Icon(Icons.album, size: 100)),
                  const SizedBox(height: 20),

                  Divider(color: Colors.grey[300], thickness: 2),

                  Text('Album Information'
                      , style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 20),

                  Text('Album ID: ${album.id}',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 10),
                  Text('User ID: ${album.userId}',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 10),

                  Text('Title: ${album.title}',
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            );
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
  Future<Album> _getAlbumDetails(BuildContext context) async {
    try {
      final freshAlbum = await RepositoryProvider.of<GetAlbumDetails>(context).call(albumId);
      return freshAlbum;
    } catch (e) {
      final cachedAlbum = await RepositoryProvider.of<AlbumRepositoryImpl>(context)
          .getAlbumDetails(albumId);
      return cachedAlbum;
    }
  }
}