import 'package:shop_app/modules/change_favorites_model.dart';

abstract class ShopAppStates {}

class ShopAppItialAppstate extends ShopAppStates {}

class ShopAppChangeBottomNavBarAppstate extends ShopAppStates {}

class ShopAppGetHomeDataLoadingAppstate extends ShopAppStates {}

class ShopAppGetHomeDataSucssesfullAppstate extends ShopAppStates {}

class ShopAppGetHomeDataErrorAppstate extends ShopAppStates {}

class ShopAppGetCategroiesDataSucssesfullAppstate extends ShopAppStates {}

class ShopAppGetCategroiesDataErrorAppstate extends ShopAppStates {}

class ShopAppChangeFavoritesDataAppstate extends ShopAppStates {}

class ShopAppChangeFavoritesDataSucssesfullAppstate extends ShopAppStates {
  final ChangeFavoriteModel model;

  ShopAppChangeFavoritesDataSucssesfullAppstate(this.model);
}

class ShopAppChangeFavoritesDataErrorAppstate extends ShopAppStates {}

class ShopAppGetFavoritesDataSucssesfullAppstate extends ShopAppStates {}

class ShopAppGetFavoritesDataErrorAppstate extends ShopAppStates {}

class ShopAppGetUserDataLoadingAppstate extends ShopAppStates {}

class ShopAppGetUserDataSucssesfullAppstate extends ShopAppStates {}

class ShopAppGetUserDataErrorAppstate extends ShopAppStates {}
