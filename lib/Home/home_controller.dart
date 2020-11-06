import 'package:appcomida/Home/home_model.dart';
import 'package:appcomida/Login/login_controller.dart';
import 'package:appcomida/utils/global.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  bool load = false;

  @observable
  HomeModel listaProdutos = new HomeModel();


  @observable
  LoginController login = new LoginController();

  _HomeControllerBase() {
    requestItens();
  }

  @action
  requestItens() async {
    load = true;
    var response = await requestGet(
        "https://www.themealdb.com/api/json/v1/1/search.php?f=b");

    var listaProdutosAux = HomeModel.fromJson(response);

    if (listaProdutos.meals != null) {
      for (var item in listaProdutosAux.meals) {
        var select = listaProdutos.meals
                .firstWhere((element) => element.idMeal == item.idMeal)
                .selecionado ??
            false;

        item.selecionado = select;
      }
    }

    listaProdutos = listaProdutosAux;
    load = false;
  }

  @action
  selectProduto(Meals e, bool select) {
    for (var produto in listaProdutos.meals) {
      if (produto.idMeal == e.idMeal) {
        e.selecionado = select;
        produto = e;
      }
    }

    listaProdutos = listaProdutos;
  }

  @computed
  int get totalSelecionados => listaProdutos.meals != null
      ? listaProdutos.meals.where((e) => e.selecionado).length
      : 0;

  @computed
  List<Meals> get getProdutosSelecionados => listaProdutos.meals != null &&
          listaProdutos.meals.where((e) => e.selecionado).length > 0
      ? listaProdutos.meals.where((e) => e.selecionado).toList()
      : new List<Meals>();
}
