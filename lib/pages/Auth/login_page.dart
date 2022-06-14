import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication_bloc/authentication_bloc.dart';
import '../../bloc/authentication_bloc/authentication_state.dart';
import '../user_loggedin.dart';
import 'body_login.dart';

class PageLogin extends StatelessWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return const UserLoggedIn();
        }
        if (state is Unauthenticated) {
          return const Bodylogin();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
