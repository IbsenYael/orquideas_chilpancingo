import 'package:flutter/material.dart';
import 'package:orquideas_chilpancingo/widgets/text/texto.dart';
import 'package:provider/provider.dart';
import '../providers/models/user_model.dart';
import '../widgets/messenger/emergent_messages.dart';

class UserLoggedIn extends StatelessWidget {
  const UserLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.only(top: 70, left: 10),
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Texto(
                          texto: "Castorena Vazquez",
                          size: 20,
                          height: 21,
                          widht: 200,
                          minFont: 20,
                          maxFont: 20,
                          maxLines: 1),
                      Texto(
                          texto: "Ibsen Yael",
                          size: 20,
                          height: 21,
                          widht: 120,
                          minFont: 20,
                          maxFont: 20,
                          maxLines: 1),
                      Texto(
                          texto: "yaelcastorenas@gmail.com",
                          size: 12,
                          color: Theme.of(context).colorScheme.secondary,
                          height: 13,
                          widht: 180,
                          minFont: 12,
                          maxFont: 12,
                          maxLines: 1)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      minRadius: 50,
                      backgroundImage: Image.asset(
                        "assets/images/perfil.jpg",
                        fit: BoxFit.fill,
                      ).image,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 150),
            width: 394,
            height: 360,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).colorScheme.secondary),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                separatorBuilder: (context, i) => Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                itemCount: optionsUser.length,
                itemBuilder: (context, i) => ListTile(
                      leading: Icon(
                        optionsUser[i].icon,
                        color: Colors.black,
                      ),
                      title: Texto(
                          texto: optionsUser[i].titulo,
                          size: 14,
                          height: 15,
                          widht: 50,
                          minFont: 14,
                          maxFont: 14,
                          maxLines: 1),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                      onTap: () async {
                        optionsUser[i].onpress(context);
                      },
                    )),
          ),
        )
      ],
    );
  }
}

class _UserOptions {
  final IconData icon;
  final String titulo;
  final Function(BuildContext context) onpress;

  _UserOptions(this.icon, this.titulo, this.onpress);
}

var optionsUser = <_UserOptions>[
  _UserOptions(
      Icons.shopping_bag_outlined, "Mis Compras", (BuildContext context) {}),
  _UserOptions(
      Icons.favorite_border_outlined, "WishList", (BuildContext context) {}),
  _UserOptions(
      Icons.gps_fixed_outlined, "Mis Direcciones", (BuildContext context) {}),
  _UserOptions(Icons.share, "Invita a un amigo", (BuildContext context) {}),
  _UserOptions(Icons.logout, "Cerrar Sesión", (BuildContext context) {
    load(context, "Cerrando sesión");
    Provider.of<UserProvider>(context, listen: false).loggout(context);
  })
];
