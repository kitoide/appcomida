import 'package:appcomida/Home/home_controller.dart';
import 'package:appcomida/utils/global.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";

  final HomeController produtosController;

  const LoginPage({Key key, this.produtosController}) : super(key: key);
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginPage args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        
        args.produtosController.login.signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.pop(context, true);
          } else {
            alerta(context, "Ops", "Não foi possível realizar seu login");
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Entrar com Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
