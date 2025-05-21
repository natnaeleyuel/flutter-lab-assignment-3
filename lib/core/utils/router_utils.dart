import 'package:go_router/go_router.dart';
import '../../presentation/pages/album_detail_page.dart';
import '../../presentation/pages/album_list_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AlbumListPage(),
      routes: [
        GoRoute(
          path: 'detail/:id',
          builder: (context, state) {
            final albumId = int.parse(state.pathParameters['id']!);
            return AlbumDetailPage(albumId: albumId);
          },
        ),
      ],
    ),
  ],
);