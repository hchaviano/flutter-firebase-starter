import 'package:firebasestarter/constants/colors.dart';
import 'package:firebasestarter/employees/employees.dart';
import 'package:firebasestarter/home/cubit/home_cubit.dart';
import 'package:firebasestarter/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebasestarter/user_profile/user_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => HomeCubit(), child: const HomePages());
  }
}

class HomePages extends StatelessWidget {
  const HomePages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _index = context.watch<HomeCubit>().state.pageIndex;
    final _screens = [
      const EmployeesScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: _screens[_index],
      backgroundColor: AppColor.lightGrey,
      bottomNavigationBar: StarterBottomNavigationBar(
        index: _index,
        updateIndex: (int index) =>
            context.read<HomeCubit>().updatePageIndex(index),
      ),
    );
  }
}
