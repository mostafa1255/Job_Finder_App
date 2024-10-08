// ignore_for_file: prefer_const_constructors

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';

class ResumeUploadScreen extends StatefulWidget {
  const ResumeUploadScreen({super.key});

  @override
  State<ResumeUploadScreen> createState() => _ResumeUploadScreenState();
}

class _ResumeUploadScreenState extends State<ResumeUploadScreen> {
  ProfileCubit? profileCubit ;
  String fileName = '';
  UserModel? user ;


  @override
  void initState() {
    super.initState();
    profileCubit = BlocProvider.of<ProfileCubit>(context);
    // Schedule the asynchronous operation to fetch user information
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserInfo();
    });
  }

  Future<void> _fetchUserInfo() async {
    // Fetch user information from Firestore using the cubit method
    var fetchedUser =
        await BlocProvider.of<ProfileCubit>(context).getUserInfo();
    setState(() {
      user = fetchedUser;
    });
  }


  // Method to pick a PDF file
  Future<FilePickerResult?> pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );
      if (result != null) {
        setState(() {
          fileName = result.files.single.name;
        });
        return result;
      } else {
        // User canceled the picker
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Widget  buildBlock(){
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserLoaded) {
          return uploadPrompt();
        } else if (state is UserUpdated) {
          return displayUploadedFile();
        } else if (state is ProfileError) {
          return Center(child: Text(state.errorMessage));
        } else {
          return Center(child: Text('Error occurred'));
        }
      },
    );
  }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Resume'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Implement skip functionality
            },
            child: Text(
              'Skip',
              style: TextStyle(color: MyColor.primaryBlue, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resume or CV',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(255, 53, 104, 153), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
              child: buildBlock(),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget uploadPrompt() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(
              Icons.cloud_upload_outlined,
              size: 40,
              color: Colors.grey,
            ),
            SizedBox(height: 4),
            Text(
              'Upload your CV or Resume\nand use it when you apply for jobs',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 250, 250, 250),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Upload a PDF',
              style: TextStyle(
                  color: MyColor.primaryBlue,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 50.sp,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 53, 104, 153),
          ),
          onPressed: () {
            pickPDF().then((cvPdf) {
              if (cvPdf != null) {
                profileCubit!.uploadCVAndUpdateUser(cvPdf);
              }
            });
          }, // add your save function here
          child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Center(
                  child: Text(
                'Upload',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ))),
        ),
      ],
    );
  }

  Widget displayUploadedFile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 50,
          color: Colors.green,
        ),
        SizedBox(height: 8),
        Text(
          'File Uploaded: $fileName',
          style: TextStyle(fontSize: 16, color: Colors.grey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
