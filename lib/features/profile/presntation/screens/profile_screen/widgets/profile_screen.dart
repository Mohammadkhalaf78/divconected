import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/profile/presntation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) =>
          ProfileBloc(sl(),sl(),sl())..add(GetProfileRequested()),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
        },
        child: Scaffold(
          body: Center(
            child: Text(
              'Profile Screen',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ),
    );
  }
}
