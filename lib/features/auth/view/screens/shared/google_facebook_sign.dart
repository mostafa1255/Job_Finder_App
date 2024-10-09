import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jop_finder_app/features/auth/viewmodel/cubit/auth_cubit.dart';

class GoogleFacebookSign extends StatelessWidget {
  const GoogleFacebookSign({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return InkWell(
              onTap: () {
                BlocProvider.of<AuthCubit>(context).signInWithGoogle(context);
              },
              child: SvgPicture.asset(
                'assets/images/google.svg',
                width: 30,
                height: 30,
              ),
            );
          },
        ),
        const Icon(
          Icons.facebook,
          color: Colors.blue,
          size: 38,
        ),
        const SizedBox(),
      ],
    );
  }
}
