import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/bloc/cubit/auth_cubit.dart';
import 'package:marketplace/utils/colors.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStatus>(
        listener: (context, state) {
          if (state == AuthStatus.notAuthenticated) {
            Navigator.pushReplacementNamed(context, '/login');
          } else if (state == AuthStatus.authenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        child: Scaffold(
            body: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            SizedBox(height: 20),
            Text('Instant buy', style: TextStyle(color: primary, fontSize: 40))
          ],
        ))));
  }
}
