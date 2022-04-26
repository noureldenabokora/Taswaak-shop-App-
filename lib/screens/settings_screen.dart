import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/constants.dart';
import 'package:shop_app/login/login_screen.dart';
import 'package:shop_app/sherd/cache_helper.dart';
import 'package:shop_app/shop_app_cubit/shop_cubit.dart';
import 'package:shop_app/shop_app_cubit/shop_states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameControoler = TextEditingController();

    var emailControoler = TextEditingController();

    var phoneControoler = TextEditingController();
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                deafualtTextformField(
                  controller: nameControoler,
                  saved: (saved) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'name must not be Empty';
                    }
                    return null;
                  },
                  lable: 'Name',
                  icon: const Icon(Icons.person),
                  obSecure: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                deafualtTextformField(
                  controller: emailControoler,
                  saved: (saved) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'email must not be Empty';
                    }
                    return null;
                  },
                  lable: 'Email',
                  icon: const Icon(Icons.mail),
                  obSecure: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                deafualtTextformField(
                  controller: phoneControoler,
                  saved: (saved) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'phone must not be Empty';
                    }
                    return null;
                  },
                  lable: 'Phone',
                  icon: const Icon(Icons.phone),
                  obSecure: false,
                ),
                const SizedBox(
                  height: 30,
                ),
                FlatButton(
                  onPressed: () {
                    CacheHellper.removeData(key: token).then((value) {
                      if (value) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                      }
                    }).catchError((onError) {
                      print('error is $onError');
                    });
                  },
                  child: Text(
                    'Log out',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                  minWidth: double.infinity,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
