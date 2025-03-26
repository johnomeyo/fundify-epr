import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fundora/pages/investors/investors_details_page.dart';

class InvestorCard extends StatelessWidget {
  final String name;
  final String location;
  final String imageUrl;
  final String bio;
  final List<String> investmentFocus;
  final String contact;

  const InvestorCard({
    super.key,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.bio,
    required this.investmentFocus,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InvestorDetailsPage(
              name: name,
              location: location,
              imageUrl: imageUrl,
              bio: bio,
              investmentFocus: investmentFocus,
              contact: contact,
            ),
          ),
        );
      },
      child: Container(
        height: size.height * 0.2,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                height: size.height * 0.2,
                width: 250,
                placeholder: (context, url) => const Center(
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.broken_image,
                  color: Colors.red,
                  size: 50,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.verified,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 15,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        location,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}