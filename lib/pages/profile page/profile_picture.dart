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
    // Use a more responsive size calculation
    final avatarSize = size > 100 ? 100.0 : size;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if we need to use a vertical layout for very narrow screens
        final useVerticalLayout = constraints.maxWidth < 250;
        
        return useVerticalLayout
            ? _buildVerticalLayout(context, avatarSize)
            : _buildHorizontalLayout(context, avatarSize);
      },
    );
  }

  Widget _buildHorizontalLayout(BuildContext context, double avatarSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProfileImage(avatarSize),
        const SizedBox(width: 16),
        Expanded(
          child: _buildProfileInfo(),
        ),
      ],
    );
  }

  Widget _buildVerticalLayout(BuildContext context, double avatarSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProfileImage(avatarSize),
        const SizedBox(height: 16),
        _buildProfileInfo(),
      ],
    );
  }

  Widget _buildProfileImage(double avatarSize) {
    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
      child: Center(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? ClipOval(
                child: Image.network(
                  imageUrl!,
                  width: avatarSize,
                  height: avatarSize,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildInitial(name ?? "Unknown Company", avatarSize);
                  },
                ),
              )
            : _buildInitial(name ?? "Unknown Company", avatarSize),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name ?? "Unknown Company",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Text(
          industry ?? "Unknown Industry",
          style: TextStyle(fontSize: 16, color: Colors.blueAccent.shade700),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildInitial(String name, double avatarSize) {
    return Text(
      name.isNotEmpty ? name[0].toUpperCase() : '?',
      style: TextStyle(
        fontSize: avatarSize * 0.5,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
    );
  }
}