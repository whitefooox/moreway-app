import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/module/auth/presentation/bloc/auth_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _logout(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.add(AuthSignOutEvent());
    context.go("/signin");
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Настройки"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.035),
        children: [
          const ListTile(
            leading: Icon(Icons.person),
            title: Text("Профиль"),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Выход из аккаунта"),
            onTap: () => _logout(context),
          )
        ],
      ),
    );
  }
}
