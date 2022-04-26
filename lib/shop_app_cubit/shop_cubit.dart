import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/constants.dart';
import 'package:shop_app/end_points/end_points.dart';
import 'package:shop_app/modules/categories_model.dart';
import 'package:shop_app/modules/change_favorites_model.dart';
import 'package:shop_app/modules/home_model.dart';
import 'package:shop_app/screens/categeories_screen.dart';
import 'package:shop_app/screens/faveorite_screen.dart';
import 'package:shop_app/screens/products_screen.dart';
import 'package:shop_app/screens/settings_screen.dart';

import 'package:shop_app/sherd/dio_helper.dart';
import 'package:shop_app/shop_app_cubit/shop_states.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppItialAppstate());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FaveoriteScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNavBAr(int index) {
    currentIndex = index;
    emit(ShopAppChangeBottomNavBarAppstate());
  }

  HomeModel? homemodel;

  Map<int, bool> faveorite = {};

  void getHomeData() {
    emit(ShopAppGetHomeDataLoadingAppstate());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homemodel = HomeModel.FromJson(value.data);

      print(homemodel!.data!.products[0].name);
      homemodel!.data!.products.forEach((element) {
        faveorite.addAll({
          element.id!: element.favorites!,
        });
      });

      emit(ShopAppGetHomeDataSucssesfullAppstate());
    }).catchError((error) {
      emit(ShopAppGetHomeDataErrorAppstate());
      print(error);
    });
  }

  CategoriesModel? categoriesmodel;

  void getCategoriesData() {
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoriesmodel = CategoriesModel.FromJson(value.data);

      emit(ShopAppGetCategroiesDataSucssesfullAppstate());
    }).catchError((error) {
      emit(ShopAppGetCategroiesDataErrorAppstate());
      print(error);
    });
  }

  ChangeFavoriteModel? changefavoritemodel;
  void ChangeFavorite(int productId) {
    faveorite[productId] = !faveorite[productId]!;

    emit(ShopAppChangeFavoritesDataAppstate());

    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {'product_id': productId},
    ).then((value) {
      changefavoritemodel = ChangeFavoriteModel.FromJson(value.data);

      emit(ShopAppChangeFavoritesDataSucssesfullAppstate(changefavoritemodel!));
    }).catchError((erorr) {
      print(erorr.toString());

      faveorite[productId] = !faveorite[productId]!;

      emit(ShopAppChangeFavoritesDataErrorAppstate());
    });
  }

  // FavoriteModel? favoritemodel;

  // void getFavoritesData() {
  //   DioHelper.getData(
  //     url: FAVORITES,
  //     token: token,
  //   ).then((value) {
  //     favoritemodel = FavoriteModel.fromJson(value.data);
  //     // print('object');
  //     // print(homemodel.data!.banners);

  //     emit(ShopAppGetFavoritesDataSucssesfullAppstate());
  //   }).catchError((error) {
  //     emit(ShopAppGetFavoritesDataErrorAppstate());
  //     print(error);
  //   });
  // }

  // void getUserData() {
  //   DioHelper.getData(
  //     url: FAVORITES,
  //     token:
  //         'yVqvHToo3wiJZzHl0BqGaNr0vawYkWpGfuyqsx3gdFKpr4Ls2cst25qFElym9cKj3h67oX',
  //   ).then((value) {
  //     user = ShopLoginModel.FromJson(value.data);
  //     // print('object');
  //     // print(homemodel.data!.banners);
  //     print(user!.data.phone);

  //     emit(ShopAppGetFavoritesDataSucssesfullAppstate());
  //   }).catchError((error) {
  //     emit(ShopAppGetFavoritesDataErrorAppstate());
  //     print(error);
  //   });

}
