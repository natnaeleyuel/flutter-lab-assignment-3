import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_albums.dart';
import 'album_event.dart';
import 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final GetAlbums getAlbums;

  AlbumBloc({required this.getAlbums}) : super(AlbumInitial()) {
    on<FetchAlbums>(_onFetchAlbums);
  }

  FutureOr<void> _onFetchAlbums(FetchAlbums event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());

    try {
      final albums = await getAlbums();
      emit(AlbumLoaded(albums));
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }
}