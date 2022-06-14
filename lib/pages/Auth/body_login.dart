import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orquideas_chilpancingo/widgets/messenger/emergent_messages.dart';

import '../../bloc/authentication_bloc/authentication_bloc.dart';
import '../../bloc/authentication_bloc/authentication_event.dart';
import '../../bloc/login_bloc/login_bloc.dart';
import '../../bloc/login_bloc/login_event.dart';
import '../../bloc/login_bloc/login_state.dart';
import '../../widgets/button/button.dart';
import '../../widgets/inputs/input.dart';
import '../../widgets/modal/bottom_modal.dart';
import '../../widgets/text/texto.dart';

class Bodylogin extends StatefulWidget {
  const Bodylogin({Key? key}) : super(key: key);

  @override
  State<Bodylogin> createState() => _BodyloginState();
}

class _BodyloginState extends State<Bodylogin>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showHidePassword = true;
  late LoginBloc _loginBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    _showHidePassword = true;
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChange);

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    IconData iconSuffix = (_showHidePassword)
        ? FontAwesomeIcons.solidEye
        : FontAwesomeIcons.solidEyeSlash;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          successMessage(
              context: context, text: "Inicio de sesión fallido", error: true);
        }
        if (state.credentialsError) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          successMessage(context: context, text: state.mensaje, error: true);
        }
        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
              .showSnackBar(load(context, "Ingresando"));
        }
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          BlocProvider.of<AuthenticationBloc>(context).add(
            LoggedIn(),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          Widget error = (state.isEmailValid)
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Texto(
                        texto: "Correo electrónico no valido",
                        size: 12,
                        color: Colors.red,
                        font: FontWeight.bold,
                        height: 13,
                        widht: 200,
                        minFont: 12,
                        maxFont: 12,
                        maxLines: 1,
                        textAling: TextAlign.center,
                      )),
                );

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).viewPadding.top + 100)),
                Texto(
                  texto: "Iniciar Sesión",
                  size: 24,
                  font: FontWeight.bold,
                  height: 25,
                  widht: 200,
                  minFont: 24,
                  maxFont: 24,
                  maxLines: 1,
                  textAling: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 488,
                  width: 394,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 130,
                          width: 220,
                          padding: const EdgeInsets.all(15),
                          child: Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.cover,
                          )),
                      InputDesing(
                        readOnly: (state.isSubmitting),
                        controller: _emailController,
                        type: TextInputType.emailAddress,
                        icon: Icons.email,
                        textdescription: "Correo electrónico",
                        height: 50,
                        width: 378,
                      ),
                      error,
                      const SizedBox(
                        height: 25,
                      ),
                      InputDesing(
                        readOnly: (state.isSubmitting),
                        controller: _passwordController,
                        suffixIcon: IconButton(
                          icon: FaIcon(
                            iconSuffix,
                            size: 15,
                          ),
                          color: Theme.of(context).indicatorColor,
                          onPressed: () {
                            setState(() {
                              _showHidePassword = !_showHidePassword;
                            });
                          },
                        ),
                        icon: Icons.password,
                        textdescription: "Contraseña",
                        height: 50,
                        width: 378,
                        isSecret: _showHidePassword,
                        type: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: PrimaryButton(
                          width: 374.00,
                          height: 36.00,
                          textdescription: "Login",
                          onpress: () {
                            (isButtonEnabled(state))
                                ? _onFormSubmitted()
                                : _loginBloc.add(Submitted(
                                    email: _emailController.text,
                                    password: _passwordController.text));
                          },
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                            margin: const EdgeInsets.only(top: 30),
                            height: 30,
                            width: 30,
                            child: Image.asset(
                              "assets/images/icongoogle.png",
                              fit: BoxFit.cover,
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        child: Center(
                            child: Texto(
                                texto: "Registrate",
                                size: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.6),
                                height: 15,
                                widht: 200,
                                minFont: 14,
                                maxFont: 14,
                                maxLines: 1,
                                textAling: TextAlign.center)),
                        onTap: () {
                          _emailController.text = "";
                          _passwordController.text = "";
                          Modal().showModal(context, _emailController,
                              _passwordController, _nameController);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onEmailChange() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }
}
