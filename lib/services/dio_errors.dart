import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orquideas_chilpancingo/providers/models/user_model.dart';
import 'package:orquideas_chilpancingo/widgets/messenger/emergent_messages.dart';
import 'package:provider/provider.dart';

void handleError(DioError error, BuildContext context) async {
  String text = "";

  switch (error.response?.statusCode) {
    case 403:
      text = "No tienes permisos de acceso para estos recursos";
      break;
    case 422:
      text = "Los datos enviados son incorrectos";
      break;
    case 401:
      text = "No autorizado";
      await Provider.of<UserProvider>(context, listen: false)
          .expiresToken(context);
      break;
    case 404:
      text = "Informacion no encontrada, intenta mas tarde";
      break;
    case 500:
      text = "Algo sucedio con nuestros servidores";
      break;
    case 412:
      text = error.response!.data["message"];
      break;
    default:
      text = "Algo ha ocurrido, intenta mas tarde";
  }
  successMessage(context: context, text: text, error: true);
}
