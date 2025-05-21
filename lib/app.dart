import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutteralbumapp/presentation/bloc/album_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'core/utils/router_utils.dart';
import 'data/datasources/local/album_local_data_source.dart';
import 'data/datasources/remote/album_remote_data_source.dart';
import 'data/repositories/album_repository_impl.dart';
import 'domain/usecases/get_album_details.dart';
import 'domain/usecases/get_albums.dart';
import 'presentation/bloc/album_bloc.dart';

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AlbumRemoteDataSourceImpl(client: http.Client()),
        ),
        RepositoryProvider(
          create: (context) => AlbumLocalDataSourceImpl(sharedPreferences: sharedPreferences),
        ),
        RepositoryProvider(
          create: (context) => AlbumRepositoryImpl(
            remoteDataSource: RepositoryProvider.of<AlbumRemoteDataSourceImpl>(context),
            localDataSource: RepositoryProvider.of<AlbumLocalDataSourceImpl>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => GetAlbums(
            RepositoryProvider.of<AlbumRepositoryImpl>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => GetAlbumDetails(
            RepositoryProvider.of<AlbumRepositoryImpl>(context),
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => AlbumBloc(
          getAlbums: RepositoryProvider.of<GetAlbums>(context),
        )..add(FetchAlbums()),
        child: MaterialApp.router(
          title: 'Album List',
          theme: ThemeData(primarySwatch: Colors.blue),
          routerConfig: router,
        ),
      ),
    );
  }
}