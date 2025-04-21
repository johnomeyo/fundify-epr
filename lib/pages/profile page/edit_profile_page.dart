import 'package:firebase_storage/firebase_storage.dart' show FirebaseStorage;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> currentProfileData;

  const EditProfilePage({super.key, required this.currentProfileData});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _companyNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _industryController;
  late TextEditingController _founderController;
  late TextEditingController _fundingGoalController;
  late TextEditingController _problemController;
  late TextEditingController _solutionController;
  File? _logoImage;
  late String _logo;
  @override
  void initState() {
    super.initState();
    // Initialize controllers with current profile data
    _companyNameController = TextEditingController(
        text: widget.currentProfileData['companyName'] ?? '');
    _descriptionController = TextEditingController(
        text: widget.currentProfileData['description'] ?? '');
    _industryController = TextEditingController(
        text: widget.currentProfileData['industry'] ?? '');
    _founderController =
        TextEditingController(text: widget.currentProfileData['founder'] ?? '');
    _fundingGoalController = TextEditingController(
        text: widget.currentProfileData['fundingGoal']?.toString() ?? '');
    _problemController =
        TextEditingController(text: widget.currentProfileData['problem'] ?? '');
    _solutionController = TextEditingController(
        text: widget.currentProfileData['solution'] ?? '');
    _logo = widget.currentProfileData['logo'] ?? '';
  }

  Future<void> _pickLogo() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        _logoImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('User not logged in')));
        return;
      }

      // Prepare update data
      Map<String, dynamic> updateData = {
        'companyName': _companyNameController.text,
        'description': _descriptionController.text,
        'industry': _industryController.text,
        'founder': _founderController.text,
        'fundingGoal': double.tryParse(_fundingGoalController.text) ?? 0,
        'problem': _problemController.text,
        'solution': _solutionController.text,
      };

      // Implement logo upload if _logoImage is not null
      // This would involve uploading the image to Firebase Storage
      // and getting the download URL to update in Firestore
      if (_logoImage != null) {
        // Your image storage logic
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('company_logos')
            .child('${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg');

        // Upload the image to Firebase Storage
        await storageRef.putFile(_logoImage!);

        // Get the download URL of the uploaded image
        final logoUrl = await storageRef.getDownloadURL();

        // Add the logo URL to the update data
        updateData['logo'] = logoUrl;
      }
      // Update Firestore document
      await FirebaseFirestore.instance
          .collection('startups')
          .doc(userId)
          .update(updateData);

      // Show success message and pop the page
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Profile Updated Successfully. Restart to see your changes')));
      Navigator.pop(context);
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    _companyNameController.dispose();
    _descriptionController.dispose();
    _industryController.dispose();
    _founderController.dispose();
    _fundingGoalController.dispose();
    _problemController.dispose();
    _solutionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            child: const Text("Save"),
            onPressed: _updateProfile,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo Pick Section
            GestureDetector(
              onTap: _pickLogo,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade200,
                child: _logoImage != null
                    ? ClipOval(
                        child: Image.file(_logoImage!, fit: BoxFit.cover))
                    : ClipOval(child: Image.network(_logo, fit: BoxFit.cover)),
              ),
            ),
            const SizedBox(height: 16),

            // Text Fields
            TextField(
              controller: _companyNameController,
              decoration: const InputDecoration(
                labelText: 'Company Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Company Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _industryController,
              decoration: const InputDecoration(
                labelText: 'Industry',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _founderController,
              decoration: const InputDecoration(
                labelText: 'Founder Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _fundingGoalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Funding Goal',
                prefixText: '\$',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _problemController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Problem Statement',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _solutionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Solution Statement',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
