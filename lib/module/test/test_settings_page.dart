import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/module/auth/presentation/bloc/auth_bloc.dart';

class TestSettingsPage extends StatelessWidget {
  const TestSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        if(state.status == AuthStatus.unauthorized){
          context.go("/signin");
        }
      },
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                authBloc.add(AuthSignOutEvent());
              },
              child: const Text("Выйти")),
        ),
      ),
    );
  }
}
