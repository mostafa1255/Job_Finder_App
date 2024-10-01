import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jop_finder_app/features/auth/model/PostedJob_model.dart';

class JobPostScreen extends StatefulWidget {
  const JobPostScreen({super.key});

  @override
  _JobPostScreenState createState() => _JobPostScreenState();
}

class _JobPostScreenState extends State<JobPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final List<TextEditingController> _requirementControllers = [];
  File? _imageFile;

  void _addRequirementField() {
    setState(() {
      _requirementControllers.add(TextEditingController());
    });
  }

  void _removeRequirementField(int index) {
    setState(() {
      if (_requirementControllers.isNotEmpty) {
        _requirementControllers[index].dispose();
        _requirementControllers.removeAt(index);
      }
    });
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error picking image. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<String> _uploadImage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref =
          FirebaseStorage.instance.ref().child('job_images/$fileName');

      await ref.putFile(image);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<void> _postJob() async {
    if (_formKey.currentState!.validate()) {
      String? uploadedImageUrl;
      if (_imageFile != null) {
        uploadedImageUrl = await _uploadImage(_imageFile!);
      }

      final requirements =
          _requirementControllers.map((controller) => controller.text).toList();

      final postedJob = PostedJob(
        jobId: '',
        jobTitle: _jobTitleController.text,
        companyName: _companyNameController.text,
        description: _descriptionController.text,
        salary: _salaryController.text,
        location: _locationController.text,
        postedDate: DateTime.now(),
        applicantIds: [],
        jobTags: [],
        imageUrl: uploadedImageUrl,
        about: _aboutController.text,
        requirements: requirements,
      );

      try {
        await FirebaseFirestore.instance
            .collection('jobs')
            .add(postedJob.toMap());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Job posted successfully!'),
          backgroundColor: Colors.green,
        ));
        _clearForm();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error posting job. Please try again.'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  void _clearForm() {
    _jobTitleController.clear();
    _companyNameController.clear();
    _descriptionController.clear();
    _salaryController.clear();
    _locationController.clear();
    _aboutController.clear();
    _imageFile = null;
    for (var element in _requirementControllers) {
      element.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post a Job', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: _postJob,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.indigo,
          ),
          child: Text(
            'Post Job',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _jobTitleController,
                          label: 'Job Title',
                          icon: Icons.work,
                        ),
                        SizedBox(height: 16),
                        _buildTextField(
                          controller: _companyNameController,
                          label: 'Company Name',
                          icon: Icons.business,
                        ),
                        SizedBox(height: 16),
                        _buildTextField(
                          controller: _descriptionController,
                          label: 'Job Description',
                          icon: Icons.description,
                          maxLines: 3,
                        ),
                        SizedBox(height: 16),
                        _buildTextField(
                          controller: _salaryController,
                          label: 'Salary',
                          icon: Icons.attach_money,
                        ),
                        SizedBox(height: 16),
                        _buildTextField(
                          controller: _locationController,
                          label: 'Location',
                          icon: Icons.location_on,
                        ),
                        SizedBox(height: 16),
                        _buildTextField(
                          controller: _aboutController,
                          label: 'About the Job',
                          icon: Icons.info,
                          maxLines: 3,
                        ),
                        SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _requirementControllers.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    controller: _requirementControllers[index],
                                    label: 'Requirement ${index + 1}',
                                    icon: Icons.check,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.remove_circle,
                                      color: Colors.red),
                                  onPressed: () =>
                                      _removeRequirementField(index),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _addRequirementField,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.indigo,
                          ),
                          child: Text('Add Requirement',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _pickImage,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.indigo,
                          ),
                          child: Text('Pick an Image',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                        if (_imageFile != null) ...[
                          SizedBox(height: 16),
                          Image.file(
                            _imageFile!,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue, width: 1),
        ),
        filled: true,
        fillColor: Colors.white,
        errorStyle: TextStyle(color: Colors.red),
      ),
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
