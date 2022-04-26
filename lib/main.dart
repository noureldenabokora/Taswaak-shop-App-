import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/constants.dart';
import 'package:shop_app/login/login_screen.dart';
import 'package:shop_app/screens/layout_screen.dart';
import 'package:shop_app/screens/on_bored_screen.dart';
import 'package:shop_app/sherd/cache_helper.dart';
import 'package:shop_app/sherd/dio_helper.dart';
import 'package:shop_app/shop_app_cubit/shop_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHellper.init();

  bool onboredShared = CacheHellper.getData(key: 'onbored');

  token = CacheHellper.getData(key: 'token');
  Widget widget;
  if (onboredShared != null) {
    if (token == null) {
      widget = LoginScreen();
    }
    widget = const HomeScreen();
  } else {
    widget = OnBoredingScreen();
  }
  print(onboredShared);
  print(token);

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopAppCubit()
            ..getHomeData()
            ..getCategoriesData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnBoredingScreen(),
      ),
    );
  }
}
