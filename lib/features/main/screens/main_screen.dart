import 'package:dev_connected/features/home_feed/presntation/screens/home_page/home_page.dart';
import 'package:dev_connected/features/main/cubit/navigation_cubit.dart';
import 'package:dev_connected/features/profile/presntation/screens/profile_screen/profile_view_screen.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.userEntity});
  final UserEntity? userEntity;
  @override
  Widget build(BuildContext context) {
    final pages = [HomePage(user: userEntity), ProfileViewScreen()];

    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, index) {
          return Scaffold(
            body: IndexedStack(index: index, children: pages),

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: index,

              onTap: (newIndex) {
                context.read<NavigationCubit>().changeIndex(newIndex);
              },

              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
