import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

Future<dynamic> requestPost(String url, dynamic parametros) async {
  try {
    
    Response response = await post(url, body: parametros);

    return json.decode(response.body);
  } catch (e) {
    throw new Exception(e);
  }
}

Future requestGet(String url) async {
  try {

    Response response;
    response = await get(url);

    return json.decode(response.body);
  } catch (e) {
    throw new Exception(e);
  }
}

Future alerta(BuildContext context, String msg, String descricao) {
  // flutter defined function
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(msg),
        content: new Text(descricao),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Fechar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
