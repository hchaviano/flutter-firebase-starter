import 'package:firebasestarter/constants/colors.dart';
import 'package:firebasestarter/employees/employees.dart';
import 'package:firebasestarter/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebasestarter/user_profile/user_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider<HomeCubit>(
        create: (_) => HomeCubit(),
        child: const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const _HomePages();
  }
}

class _HomePages extends StatelessWidget {
  const _HomePages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageIndex =
        context.select((HomeCubit cubit) => cubit.state.pageIndex);
    final _screens = [
      const EmployeesScreen(),
      const UserProfileScreen(),
    ];
    return Scaffold(
      body: _screens[pageIndex],
      backgroundColor: AppColor.lightGrey,
      bottomNavigationBar: StarterBottomNavigationBar(
        index: pageIndex,
        updateIndex: (int newIndex) =>
            context.read<HomeCubit>().updatePageIndex(newIndex),
      ),
    );
  }
}
