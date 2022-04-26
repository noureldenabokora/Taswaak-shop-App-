import 'package:shop_app/modules/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterIntialState extends ShopRegisterStates {}

class ShopRegisterLodingState extends ShopRegisterStates {}

class ShopRegisterSucseesState extends ShopRegisterStates {
  final ShopLoginModel loginModel;

  ShopRegisterSucseesState(this.loginModel);
}

class ShopRegisterEroorState extends ShopRegisterStates {}
