import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:orquideas_chilpancingo/bloc/login_bloc/login_event.dart';
import 'package:orquideas_chilpancingo/bloc/login_bloc/login_state.dart';
import 'package:rxdart/rxdart.dart';
import '../../services/user_repository.dart';
import '../../utils/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  final Validators _validators = Validators();
  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.empty()) {
    on<EmailChanged>(_onEmailChanged,
        transformer: _debounceRestartable(const Duration(milliseconds: 300)));
    on<LoginWithCredentialsPressed>(_loginWhithCredentials);
    on<Submitted>(_verifiInputs);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) async {
    emit(state.update(
        isEmailValid: Validators.isValidEmail(event.email),
        emailMensaje: "Correo electronico invalido"));
  }

  void _loginWhithCredentials(
      LoginWithCredentialsPressed event, Emitter<LoginState> emit) async {
    emit(LoginState.loading());

    try {
      Response data = await _userRepository
          .signIn({'email': event.email, 'password': event.password});
      Map<String, dynamic> response = Map<String, dynamic>.from(data.data);
      if (response['token'] != null) {
        await _validators.savePreferencesAuth(response['token']);
        emit(LoginState.success());
      } else {
        emit(LoginState.accessError(mensaje: response['msg']));
      }
    } on DioError catch (e) {
      if (e.response?.data != null && e.response?.statusCode != 307) {
        if (e.response?.statusCode == 404 || e.response?.statusCode == 502) {
          emit(LoginState.accessError(
              mensaje: "Algo ha ocurrido intenta mas tarde"));
        } else {
          Map<String, dynamic> response =
              Map<String, dynamic>.from(e.response?.data);
          emit(LoginState.accessError(mensaje: response['msg']));
        }
      } else {
        emit(LoginState.failure());
      }
    }
  }

  void _verifiInputs(Submitted event, Emitter<LoginState> emit) {
    emit(LoginState.accessError(
        mensaje: "Credenciales Invalidas, Verifica los campos"));
  }

  EventTransformer<EmailChanged> _debounceRestartable<EmailChanged>(
    Duration duration,
  ) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
