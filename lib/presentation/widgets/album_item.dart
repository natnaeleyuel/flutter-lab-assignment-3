import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/album.dart';
import '../../core/utils/color_utils.dart';

class AlbumItem extends StatelessWidget {
  final Album album;
  final int index; // Add index parameter

  const AlbumItem({
    super.key,
    required this.album,
    required this.index, // Require index
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric( // External margin
            vertical: 4,
            horizontal: 8,
          ),
          child: Padding( // Internal padding
            padding: const EdgeInsets.all(12),
            child: ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.getPhotoColor(index),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.photo, color: Colors.blue),
              ),
              title: Text(
                album.title,
                style: const TextStyle(color: Colors.black),
              ),
              tileColor: Colors.transparent,
              onTap: () => context.go('/detail/${album.id}'),
            ),
          ),
      )
    );
  }
}