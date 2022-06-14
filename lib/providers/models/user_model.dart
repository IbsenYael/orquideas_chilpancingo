import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orquideas_chilpancingo/services/dio_errors.dart';

import '../../bloc/authentication_bloc/authentication_bloc.dart';
import '../../bloc/authentication_bloc/authentication_event.dart';
import '../../services/user_repository.dart';
import '../../utils/validators.dart';
import '../../widgets/messenger/emergent_messages.dart';

class UserProvider extends ChangeNotifier {
  UserRepository userRepository = UserRepository();

  Future<void> registerUser(
      BuildContext context, String email, String name, String password) async {
    try {
      await userRepository
          .newUser({'email': email, 'name': name, 'password': password});
      successMessage(
          context: context,
          text: "Se ha registrado al usuario satisfactoriamente");
    } on DioError catch (e) {
      handleError(e, context);
    }
  }

  Future<void> loggout(BuildContext context) async {
    try {
      Response data = await userRepository.signOut();
      Validators().delteStorageToken();
      successMessage(context: context, text: data.data["msg"]);
      BlocProvider.of<AuthenticationBloc>(context).add(
        LoggedOut(),
      );
    } on DioError catch (e) {
      handleError(e, context);
    }
  }

  Future<void> expiresToken(BuildContext context) async {
    BlocProvider.of<AuthenticationBloc>(context).add(
      LoggedOut(),
    );
    Validators().delteStorageToken();
  }
}
