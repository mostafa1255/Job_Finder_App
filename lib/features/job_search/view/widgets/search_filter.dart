import 'package:flutter/material.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';

class SearchFilterWidget extends StatelessWidget {
  const SearchFilterWidget({
    super.key,
    required this.searchController,
    required this.onClickFilter,
    required this.onChangedTextField,
  });
  final TextEditingController searchController;
  final Function() onClickFilter;
  final Function(String) onChangedTextField;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Row(
      children: [
        Form(
          key: _formKey,
          child: Expanded(
            child: TextFormField(
              onChanged: onChangedTextField,
              controller: searchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AppColors.mainColor),
                ),
                prefixIcon: Icon(Icons.search),
                labelText: 'Search',
                hintText: 'Search for jobs',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.mainColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.filter_alt_sharp),
            onPressed: onClickFilter,
          ),
        ),
      ],
    );
  }
}
