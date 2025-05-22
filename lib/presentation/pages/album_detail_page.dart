import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/color_utils.dart';
import '../../data/repositories/album_repository_impl.dart';
import '../../domain/entities/album.dart';
import '../../domain/entities/photo.dart';

class AlbumDetailPage extends StatefulWidget {
  final int albumId;

  const AlbumDetailPage({super.key, required this.albumId});

  @override
  State<AlbumDetailPage> createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  late Future<Album> _albumFuture;
  late Future<List<Photo>> _photosFuture;

  @override
  void initState() {
    super.initState();
    final repository = RepositoryProvider.of<AlbumRepositoryImpl>(context);
    _albumFuture = repository.getAlbumDetails(widget.albumId);
    _photosFuture = repository.getPhotos(widget.albumId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Album Details')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Album Information Section
            FutureBuilder<Album>(
              future: _albumFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final album = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Icon(Icons.photo, size: 100),
                        const SizedBox(height: 20),
                        Text('Album ID: ${album.id}',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 10),
                        Text('User ID: ${album.userId}',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 10),
                        Text('Title: ${album.title}',
                            style: Theme.of(context).textTheme.titleMedium),
                        const Divider(height: 40),
                        Text('Photos in this Album',
                            style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  );
                }
                return const Text('No album data');
              },
            ),

            FutureBuilder<List<Photo>>(
              future: _photosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Error loading photos: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final photo = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Card(
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.getPhotoColor(index),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.photo, color: Colors.blue),
                            ),
                            title: Text(
                              photo.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            subtitle: Text('ID: ${photo.id}'),
                            tileColor: Colors.transparent,
                          )
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}