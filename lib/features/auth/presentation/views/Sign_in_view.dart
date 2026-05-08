// ignore_for_file: file_names

// ignore_for_file: unchecked_use_of_nullable_value

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysterybag/core/services/get_it_service.dart';
import 'package:mysterybag/core/widgets/custom_app_bar.dart';
import 'package:mysterybag/features/auth/domains/repos/auth_repo.dart';
import 'package:mysterybag/features/auth/presentation/manager/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:mysterybag/generated/l10n.dart';

import 'widgets/sign_in_view_body_bloc_consumer.dart';

class SigninView extends StatelessWidget {
  static const String routeName = '/login';
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: Custom_app_bar(context, title: S.of(context)!.onLoginLogin),
      // body: const LoginViewBody(),
      body: BlocProvider(
        create: (context) => SignInCubit(
          getIt<AuthRepo>(), // Use getIt to provide the AuthRepo instance
        ),
        child: const SigninViewBodyBlocConsumer(),
      ),
    );
  }
}
