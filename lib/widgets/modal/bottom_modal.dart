import 'package:flutter/material.dart';
import 'package:orquideas_chilpancingo/providers/models/user_model.dart';
import 'package:orquideas_chilpancingo/widgets/messenger/emergent_messages.dart';
import 'package:orquideas_chilpancingo/widgets/text/texto.dart';
import 'package:provider/provider.dart';

import '../button/button.dart';
import '../inputs/input.dart';

class Modal {
  void showModal(BuildContext context, TextEditingController email,
      TextEditingController password, TextEditingController name) {
    showBottomSheet<void>(
        context: context,
        backgroundColor: Colors.white,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        elevation: 50,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(10),
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: Column(children: <Widget>[
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.close_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )),
              Texto(
                texto: "Registrate",
                size: 20,
                height: 21,
                widht: 150,
                maxLines: 1,
                minFont: 20,
                maxFont: 20,
                textAling: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              InputDesing(
                icon: Icons.person,
                textdescription: "Nombre",
                controller: name,
                height: 50,
                width: 378,
                readOnly: false,
                type: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              InputDesing(
                  controller: email,
                  icon: Icons.email,
                  textdescription: "Correo electrónico",
                  height: 50,
                  width: 378,
                  readOnly: false,
                  type: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              InputDesing(
                  controller: password,
                  icon: Icons.password,
                  textdescription: "Contraseña",
                  height: 50,
                  width: 378,
                  isSecret: true,
                  readOnly: false,
                  type: TextInputType.text),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: PrimaryButton(
                    width: 374.00,
                    height: 36.00,
                    textdescription: "Registrar",
                    onpress: () async {
                      load(context, "Registrando usuarios");
                      Provider.of<UserProvider>(context, listen: false)
                          .registerUser(
                              context, email.text, name.text, password.text)
                          .then((value) {
                        email.text = "";
                        password.text = "";
                        email.text = "";
                        Navigator.pop(context);
                      });
                    }),
              ),
            ]),
          );
        });
  }
}
