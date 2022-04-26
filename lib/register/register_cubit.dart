import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/end_points/end_points.dart';
import 'package:shop_app/modules/login_model.dart';
import 'package:shop_app/register/register_states.dart';
import 'package:shop_app/sherd/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterIntialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLodingState());
    DioHelper.postData(
      url: Register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      loginModel = ShopLoginModel.FromJson(value.data);
      print(loginModel.message);
      print(loginModel.data.phone);
      emit(ShopRegisterSucseesState(loginModel));
    }).catchError((error) {
      emit(ShopRegisterEroorState());
    });
  }
}
