import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  ProfileSetupPageState createState() => ProfileSetupPageState();
}

class ProfileSetupPageState extends State<ProfileSetupPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  File? _companyLogo;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool _allFieldsValid = false;

  // Form field controllers
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _fundingGoalController = TextEditingController();
  final TextEditingController _currentFundingController =
      TextEditingController();
  final TextEditingController _monthlyRevenueController =
      TextEditingController();
  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _solutionController = TextEditingController();

  String _selectedIndustry = "Technology";
  final List<String> _industries = [
    "Technology",
    "Finance",
    "Healthcare",
    "Education",
    "Renewable Energy",
    "Retail",
    "Other"
  ];

  @override
  void initState() {
    super.initState();
    // Add listeners to all text controllers to validate fields on change
    _companyNameController.addListener(_validateFields);
    _descriptionController.addListener(_validateFields);
    _fundingGoalController.addListener(_validateFields);
    _currentFundingController.addListener(_validateFields);
    _monthlyRevenueController.addListener(_validateFields);
    _problemController.addListener(_validateFields);
    _solutionController.addListener(_validateFields);
  }

  @override
  void dispose() {
    // Dispose all controllers
    _pageController.dispose();
    _companyNameController.dispose();
    _descriptionController.dispose();
    _fundingGoalController.dispose();
    _currentFundingController.dispose();
    _monthlyRevenueController.dispose();
    _problemController.dispose();
    _solutionController.dispose();
    super.dispose();
  }

  void _validateFields() {
    setState(() {
      _allFieldsValid = _companyNameController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty &&
          _fundingGoalController.text.isNotEmpty &&
          _currentFundingController.text.isNotEmpty &&
          _monthlyRevenueController.text.isNotEmpty &&
          _problemController.text.isNotEmpty &&
          _solutionController.text.isNotEmpty &&
          _companyLogo != null;
    });
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _pickLogo() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // Optimize by reducing image quality
    );

    if (pickedFile != null) {
      setState(() {
        _companyLogo = File(pickedFile.path);
      });
      _validateFields();
    }
  }

  void _submitForm() {
    if (_allFieldsValid) {
      // Here you would typically save the data and navigate
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile setup completed successfully!')),
      );
      // Navigate to the next screen
      // Navigator.of(context).pushReplacement(...);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Setup"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              LinearProgressIndicator(value: (_currentStep + 1) / 4),
              const SizedBox(height: 16),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentStep = index;
                    });
                  },
                  children: [
                    _buildBusinessInfoStep(),
                    _buildFinancialMetricsStep(),
                    _buildProblemSolutionStep(),
                    _buildFinalStep(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessInfoStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Step 1: Business Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextFormField(
            controller: _companyNameController,
            decoration: const InputDecoration(
              labelText: "Company Name*",
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value!.isEmpty ? "Company name is required" : null,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField(
            value: _selectedIndustry,
            decoration: const InputDecoration(
              labelText: "Industry*",
              border: OutlineInputBorder(),
            ),
            items: _industries.map((industry) {
              return DropdownMenuItem(
                value: industry,
                child: Text(industry),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedIndustry = value.toString();
              });
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: "Company Description*",
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            validator: (value) =>
                value!.isEmpty ? "Description is required" : null,
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickLogo,
                  icon: const Icon(Icons.upload),
                  label: const Text("Upload Company Logo*"),
                ),
                const SizedBox(height: 8),
                if (_companyLogo != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(_companyLogo!,
                        height: 100, fit: BoxFit.cover),
                  )
                else
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.business,
                        size: 50, color: Colors.grey),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 45),
              ),
              child: const Text("Next"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialMetricsStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Step 2: Financial Metrics",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextFormField(
            controller: _fundingGoalController,
            decoration: const InputDecoration(
              labelText: "Funding Goal (\$)*",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.attach_money),
            ),
            keyboardType: TextInputType.number,
            validator: (value) =>
                value!.isEmpty ? "Funding goal is required" : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _currentFundingController,
            decoration: const InputDecoration(
              labelText: "Current Funding (\$)*",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.attach_money),
            ),
            keyboardType: TextInputType.number,
            validator: (value) =>
                value!.isEmpty ? "Current funding is required" : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _monthlyRevenueController,
            decoration: const InputDecoration(
              labelText: "Monthly Revenue (\$)*",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.attach_money),
            ),
            keyboardType: TextInputType.number,
            validator: (value) =>
                value!.isEmpty ? "Monthly revenue is required" : null,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _previousStep,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 45),
                ),
                child: const Text("Back"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _nextStep,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 45),
                ),
                child: const Text("Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProblemSolutionStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Step 3: Problem & Solution",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextFormField(
            controller: _problemController,
            decoration: const InputDecoration(
              labelText: "Problem*",
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            validator: (value) =>
                value!.isEmpty ? "Problem description is required" : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _solutionController,
            decoration: const InputDecoration(
              labelText: "Solution*",
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            validator: (value) =>
                value!.isEmpty ? "Solution description is required" : null,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _previousStep,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 45),
                ),
                child: const Text("Back"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _nextStep,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 45),
                ),
                child: const Text("Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinalStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Step 4: Review & Submit",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReviewSection(
                    "Company Name", _companyNameController.text),
                _buildReviewSection("Industry", _selectedIndustry),
                _buildReviewSection("Description", _descriptionController.text),
                _buildReviewSection(
                    "Funding Goal", "\$${_fundingGoalController.text}"),
                _buildReviewSection(
                    "Current Funding", "\$${_currentFundingController.text}"),
                _buildReviewSection(
                    "Monthly Revenue", "\$${_monthlyRevenueController.text}"),
                _buildReviewSection("Problem", _problemController.text),
                _buildReviewSection("Solution", _solutionController.text),
                const SizedBox(height: 16),
                if (_companyLogo != null)
                  Center(
                    child: Column(
                      children: [
                        const Text("Company Logo",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(_companyLogo!,
                              height: 100, fit: BoxFit.cover),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _previousStep,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 45),
              ),
              child: const Text("Back"),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: _allFieldsValid ? _submitForm : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 45),
                backgroundColor: _allFieldsValid ? Colors.green : Colors.grey,
                foregroundColor: Colors.white,
              ),
              child: const Text("Finish"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(content),
          const Divider(),
        ],
      ),
    );
  }
}
