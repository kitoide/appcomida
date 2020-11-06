import 'package:appcomida/Home/home_controller.dart';
import 'package:appcomida/Home/home_model.dart';
import 'package:appcomida/Login/login_page.dart';
import 'package:appcomida/utils/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CarrinhoPage extends StatelessWidget {
  static const routeName = "/carrinho";

  final HomeController produtosController;

  CarrinhoPage({Key key, this.produtosController}) : super(key: key);

  CarrinhoPage args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Seus produtos"),
      ),
      body: Observer(builder: (_) {
        if (args.produtosController.getProdutosSelecionados.length == 0)
          return Container(
            child: Center(
              child: Text("Nada selecionado"),
            ),
          );

        return ListView(
          children: args.produtosController.getProdutosSelecionados
              .map((e) => Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              e.strMealThumb,
                              height: 100.0,
                              width: 100.0,
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.strMeal,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    e.strInstructions.substring(0, 100) + "...",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ]),
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              args.produtosController
                                  .selectProduto(e, !e.selecionado);
                            },
                            child: Icon(
                              e.selecionado
                                  ? Icons.remove_shopping_cart_outlined
                                  : Icons.add_shopping_cart_outlined,
                              color: e.selecionado ? Colors.red : Colors.green,
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ))
              .toList(),
        );
      }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(5),
        child: FlatButton.icon(
          color: Colors.green,
          onPressed: () async {
            if (args.produtosController.login.login.email == null) {
              var response =
                  await Navigator.pushNamed(context, LoginPage.routeName,
                      arguments: LoginPage(
                        produtosController: args.produtosController,
                      ));

              if (response != null && response == true) {
                _finalizarCompra(context);
              }
            } else {
               _finalizarCompra(context);
            }
          },
          icon: Icon(Icons.shopping_bag),
          label: Text("Finalizar Carrinho"),
        ),
      ),
    );
  }

  void _finalizarCompra(BuildContext context) async {
    await alerta(context, "Oba", "Produtos comprados com sucesso!");
    args.produtosController.listaProdutos = new HomeModel();
    Navigator.pop(context);
  }
}
