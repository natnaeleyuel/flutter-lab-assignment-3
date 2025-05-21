import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/widgets/error_widget.dart';
import '../bloc/album_bloc.dart';
import '../bloc/album_state.dart';
import '../widgets/album_item.dart';
import '../widgets/loading_indicator.dart';

class AlbumListPage extends StatelessWidget {
  const AlbumListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumBloc, AlbumState>(

        builder: (context, state) {
          if (state is AlbumInitial || state is AlbumLoading) {
            return const LoadingIndicator();
          } else if (state is AlbumError) {
            return CustomErrorWidget(message: state.message);
          } else if (state is AlbumLoaded) {

            return ListView.builder(
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                final album = state.albums[index];
                return AlbumItem(album: album);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}