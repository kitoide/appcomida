// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  Computed<int> _$totalSelecionadosComputed;

  @override
  int get totalSelecionados => (_$totalSelecionadosComputed ??= Computed<int>(
          () => super.totalSelecionados,
          name: '_HomeControllerBase.totalSelecionados'))
      .value;
  Computed<List<Meals>> _$getProdutosSelecionadosComputed;

  @override
  List<Meals> get getProdutosSelecionados =>
      (_$getProdutosSelecionadosComputed ??= Computed<List<Meals>>(
              () => super.getProdutosSelecionados,
              name: '_HomeControllerBase.getProdutosSelecionados'))
          .value;

  final _$loadAtom = Atom(name: '_HomeControllerBase.load');

  @override
  bool get load {
    _$loadAtom.reportRead();
    return super.load;
  }

  @override
  set load(bool value) {
    _$loadAtom.reportWrite(value, super.load, () {
      super.load = value;
    });
  }

  final _$listaProdutosAtom = Atom(name: '_HomeControllerBase.listaProdutos');

  @override
  HomeModel get listaProdutos {
    _$listaProdutosAtom.reportRead();
    return super.listaProdutos;
  }

  @override
  set listaProdutos(HomeModel value) {
    _$listaProdutosAtom.reportWrite(value, super.listaProdutos, () {
      super.listaProdutos = value;
    });
  }

  final _$loginAtom = Atom(name: '_HomeControllerBase.login');

  @override
  LoginController get login {
    _$loginAtom.reportRead();
    return super.login;
  }

  @override
  set login(LoginController value) {
    _$loginAtom.reportWrite(value, super.login, () {
      super.login = value;
    });
  }

  final _$requestItensAsyncAction =
      AsyncAction('_HomeControllerBase.requestItens');

  @override
  Future requestItens() {
    return _$requestItensAsyncAction.run(() => super.requestItens());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic selectProduto(Meals e, bool select) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.selectProduto');
    try {
      return super.selectProduto(e, select);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
load: ${load},
listaProdutos: ${listaProdutos},
login: ${login},
totalSelecionados: ${totalSelecionados},
getProdutosSelecionados: ${getProdutosSelecionados}
    ''';
  }
}
