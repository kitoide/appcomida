import 'package:appcomida/Carrinho/carrinho_page.dart';
import 'package:appcomida/Home/home_controller.dart';
import 'package:appcomida/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  HomeController _homeController = HomeController();

  AnimationController _controller;
  Animation gradientPosition;
  @override
  void initState() {
    loadAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Observer(builder: (_) {
            if (_homeController.login.login.email != null)
              return FlatButton.icon(
                onPressed: () {
                  _homeController.login.signOutGoogle();
                },
                icon: Icon(Icons.people),
                label: Text(_homeController.login.login.name),
              );
            else
              return FlatButton.icon(
                onPressed: () {
                  _homeController.login.signInWithGoogle();
                },
                icon: Icon(Icons.people),
                label: Text("Login"),
              );
          })
        ],
        title: Text(""),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          height: 50.0,
          color: Colors.red,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 28.0,
                  child: Stack(
                    children: <Widget>[
                      Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                      ),
                      Observer(builder: (_) {
                        return Positioned(
                          right: 0.0,
                          top: 0.0,
                          child: Container(
                            width: 15.0,
                            height: 15.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            child: Center(
                              child: Text(
                                _homeController.totalSelecionados.toString(),
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
                Container(
                  width: width * 0.3,
                  child: Center(
                    child: Text("Ver sacola",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w900)),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () async {
          if (_homeController.totalSelecionados == 0)
            alerta(context, "Ops!", "Selecione pelo menos um produto");
          else {
            await Navigator.pushNamed(context, CarrinhoPage.routeName,
                arguments: CarrinhoPage(
                  produtosController: _homeController,
                ));
            _homeController.requestItens();
          }
        },
      ),
      body: Observer(builder: (_) {
        return Container(
          child: _homeController.listaProdutos.meals != null &&
                  !_homeController.load
              ? ListView(
                  children: _homeController.listaProdutos.meals
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.strMeal,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            e.strInstructions
                                                    .substring(0, 100) +
                                                "...",
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
                                      _homeController.selectProduto(
                                          e, !e.selecionado);
                                    },
                                    child: Icon(
                                      e.selecionado
                                          ? Icons.remove_shopping_cart_outlined
                                          : Icons.add_shopping_cart_outlined,
                                      color: e.selecionado
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                )
              : Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _gradienteLoader(width, 80.0),
                      _gradienteLoader(width, 80.0),
                      _gradienteLoader(width, 80.0),
                    ],
                  ),
                ),
        );
      }),
    );
  }

  Widget _gradienteLoader(double width, double height) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(gradientPosition.value, 0),
          end: Alignment(-1, 0),
          colors: [Colors.black12, Colors.black26, Colors.black12],
        ),
      ),
    );
  }

  void loadAnimation() {
    _controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }
}
