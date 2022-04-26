import 'package:shop_app/modules/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginIntialState extends ShopLoginStates {}

class ShopLoginLodingState extends ShopLoginStates {}

class ShopLoginSucseesState extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSucseesState(this.loginModel);
}

class ShopLoginEroorState extends ShopLoginStates {}
