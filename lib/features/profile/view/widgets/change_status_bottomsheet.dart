import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_button.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';


class StatusUpdateBottomSheet extends StatefulWidget {
  const StatusUpdateBottomSheet({super.key , required this.profileCubit});
  final ProfileCubit profileCubit;

  @override
  StatusUpdateBottomSheetState createState() => StatusUpdateBottomSheetState();
}

class StatusUpdateBottomSheetState extends State<StatusUpdateBottomSheet> {

  

  String _selectedStatus = 'Available'; // Default value

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Available'),
            leading: Radio<String>(
              value: 'Available',
              groupValue: _selectedStatus,
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Hiring'),
            leading: Radio<String>(
              value: 'Hiring',
              groupValue: _selectedStatus,
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Hired'),
            leading: Radio<String>(
              value: 'Hired',
              groupValue: _selectedStatus,
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          Container(
              width: double.infinity,
              child: StyledButton(
                text: "Save Changes",
                onPressed: () {
                  widget.profileCubit.customUpdateToFirebaseProfile('status', _selectedStatus);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Status Updated Successfully"),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}