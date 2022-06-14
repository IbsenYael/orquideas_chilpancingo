import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orquideas_chilpancingo/bloc/login_bloc/login_bloc.dart';
import 'package:orquideas_chilpancingo/bloc/simple_bloc_delegate.dart';
import 'package:orquideas_chilpancingo/pages/Auth/login_page.dart';
import 'package:orquideas_chilpancingo/services/user_repository.dart';

import '../../bloc/authentication_bloc/authentication_bloc.dart';
import '../../bloc/authentication_bloc/authentication_event.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = UserRepository();
    return BlocOverrides.runZoned(() {
      return MultiBlocProvider(providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc(userRepository: userRepository)
            ..add(AppStarted()),
        ),
        BlocProvider(create: (_) => LoginBloc(userRepository: userRepository))
      ], child: const PageLogin());
    }, blocObserver: SimpleBlocObserver());
  }
}
