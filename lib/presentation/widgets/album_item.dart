import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/album.dart';

class AlbumItem extends StatelessWidget {
  final Album album;

  const AlbumItem({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.album),
      title: Text(album.title),
      onTap: () => context.go('/detail/${album.id}'),
    );
  }
}