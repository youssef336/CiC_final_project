import 'package:flutter/material.dart';
import 'package:mysterybag/generated/l10n.dart';
import 'package:mysterybag/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context)!.homeViewTitle)),
      body: const HomeViewBody(),
    );
  }
}
