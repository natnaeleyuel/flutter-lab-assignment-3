import 'package:flutter/material.dart';
import '../../presentation/pages/album_list_page.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;

  const CustomErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(message),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const AlbumListPage()),
            ), child: const Text('Retry'),
          )],
          ),
    );
  }
}