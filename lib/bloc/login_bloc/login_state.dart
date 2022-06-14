class LoginState {
  // Definir variables
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool credentialsError;
  final String mensaje;

  bool get isFormValid => isEmailValid;

  // Constructor
  LoginState(
      {required this.isEmailValid,
      required this.isPasswordValid,
      required this.isSubmitting,
      required this.isSuccess,
      required this.isFailure,
      required this.credentialsError,
      this.mensaje = ""});

  // Cuatro estados:
  // - Vacio, empty
  factory LoginState.empty() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        credentialsError: false);
  }

  // - Cargando, loading
  factory LoginState.loading() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        credentialsError: false);
  }

  // - Falla, failure
  factory LoginState.failure() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        credentialsError: false);
  }
  factory LoginState.accessError({required String mensaje}) {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        credentialsError: true,
        mensaje: mensaje);
  }

  // - Exito, success
  factory LoginState.success() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        credentialsError: false);
  }

  factory LoginState.loggout() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        credentialsError: false);
  }

  // Funciones adicionales: copywith - update
  LoginState copyWith({
    required bool isEmailValid,
    required bool isPasswordValid,
    required bool isSubmitting,
    required bool isSuccess,
    required bool isFailure,
    required bool credentialsError,
  }) {
    return LoginState(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: isSubmitting,
      isSuccess: isSuccess,
      isFailure: isFailure,
      credentialsError: credentialsError,
    );
  }

  LoginState update(
      {required bool isEmailValid,
      bool isPasswordValid = true,
      String emailMensaje = "",
      passwordMensaje = ""}) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      credentialsError: false,
    );
  }
}
