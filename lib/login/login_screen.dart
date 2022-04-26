import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/const/constants.dart';
import 'package:shop_app/login/login_cubit.dart';
import 'package:shop_app/login/login_states.dart';
import 'package:shop_app/register/register_screen.dart';
import 'package:shop_app/screens/layout_screen.dart';
import 'package:shop_app/sherd/cache_helper.dart';

class LoginScreen extends StatelessWidget {
//  const LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSucseesState) {
            if (state.loginModel.status) {
              Fluttertoast.showToast(
                msg: '${state.loginModel.message}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );

              CacheHellper.setData(
                key: 'token',
                value: state.loginModel.data.token,
              );

              token = state.loginModel.data.token!;
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
            } else {
              //  print(state.loginModel.message);
              Fluttertoast.showToast(
                msg: '${state.loginModel.message}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            // appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        deafualtTextformField(
                          controller: emailController,
                          saved: (value) {},
                          obSecure: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Your email';
                            }
                            return null;
                          },
                          lable: "Email",
                          icon: const Icon(Icons.email_outlined),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        deafualtTextformField(
                          controller: passwordController,
                          saved: (value) {},
                          obSecure: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          lable: "Passwprd",
                          icon: const Icon(Icons.lock_outline),
                          suffixicon: const Icon(Icons.visibility_outlined),
                        ),
                        const SizedBox(height: 30),
                        ConditionalBuilderRec(
                          condition: state is! ShopLoginLodingState,
                          builder: (context) {
                            return FlatButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.blue,
                              minWidth: 400,
                              height: 50,
                            );
                          },
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account ?',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => RegieterScreen(),
                                ));
                              },
                              child: const Text('Register'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
