import 'package:flutter/material.dart';

class ContactInformation extends StatelessWidget {
  const ContactInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListTile(
          leading: Icon(Icons.email),
          title: Text("johndoe@example.com"),
        ),
        ListTile(
          leading: Icon(Icons.link),
          title: Text("www.johndoeinvestments.com"),
        ),
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text("San Francisco, CA"),
        ),
      ],
    );
  }
}
