import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysterybag/core/services/get_it_service.dart';
import 'package:mysterybag/features/auth/domain/repo/auth_repo.dart';
import 'package:mysterybag/features/auth/presentation/manager/cubits/login/login_cubit.dart';
import 'package:mysterybag/features/auth/presentation/views/widgets/login_view_body_bloc_builder.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginCubit(getIt<AuthRepo>()),
          child: const LoginViewBodyBlocBuilder(),
        ),
      ),
    );
  }
}
