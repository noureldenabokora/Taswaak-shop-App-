import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/end_points/end_points.dart';
import 'package:shop_app/login/login_states.dart';
import 'package:shop_app/modules/login_model.dart';
import 'package:shop_app/sherd/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginIntialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLodingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopLoginModel.FromJson(value.data);
      print(loginModel.message);
      print(loginModel.data.phone);
      emit(ShopLoginSucseesState(loginModel));
    }).catchError((error) {
      emit(ShopLoginEroorState());
    });
  }
}
