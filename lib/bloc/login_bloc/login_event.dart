import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];

//cuatro eventos:
//cambio en el email
// Submitted - enviado
// LoginWithCredentialsPressed - login con credenciales
}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged({required this.email});
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  const Submitted({required this.email, required this.password});
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginWithCredentialsPressed(
      {required this.email, required this.password});
}
