import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? industry;
  final double size;

  const ProfilePicture({
    super.key,
    this.imageUrl,
    this.name,
    this.industry,
    this.size = 150.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          child: Center(
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      imageUrl!,
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildInitial(name ?? "Unknown Company");
                      },
                    ),
                  )
                : _buildInitial(name ?? "Unknown Company"),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name ?? "Unkown Company",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              industry ?? "Unknown Industry",
              style: TextStyle(fontSize: 16, color: Colors.blueAccent.shade700),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInitial(String name) {
    return Text(
      name.isNotEmpty ? name[0].toUpperCase() : '?',
      style: TextStyle(
        fontSize: size * 0.5,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
    );
  }
}
