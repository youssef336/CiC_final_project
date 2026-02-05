// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysterybag/core/services/get_it_service.dart';
import 'package:mysterybag/core/widgets/custom_app_bar.dart';
import 'package:mysterybag/features/auth/domains/repos/auth_repo.dart';
import 'package:mysterybag/features/auth/presentation/manager/cubits/sign_up_cubit/signup_cubit.dart';
import 'package:mysterybag/features/auth/presentation/views/widgets/sign_up_view_body_bloc_consumer.dart';
import 'package:mysterybag/generated/l10n.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static const String routeName = '/sign-up';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        getIt<AuthRepo>(), // Use getIt to provide the AuthRepo instance
      ),
      child: Scaffold(
        appBar: Custom_app_bar(
          context,
          title: S.of(context).on_signup_Signup,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: const SignupViewBodyBlocConsumer(),
      ),
    );
  }
}
