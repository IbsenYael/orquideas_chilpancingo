import 'package:bloc/bloc.dart';

import '../../services/user_repository.dart';
import '../../utils/validators.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(Uninitilized()) {
    on<AppStarted>(_onEvent);
    on<LoggedIn>(_onEventLoggedIn);
    on<LoggedOut>(_onEventLoggedOut);
  }

  void _onEvent(AppStarted event, Emitter<AuthenticationState> emit) async {
    bool validate = false;
    validate = await Validators().isTokenExist();
    if (validate) {
      emit(Authenticated());
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      emit(Unauthenticated());
    }
  }

  void _onEventLoggedIn(
      LoggedIn event, Emitter<AuthenticationState> emit) async {
    emit(Authenticated());
  }

  void _onEventLoggedOut(
      LoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(Unauthenticated());
  }
}
