import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/categories_model.dart';
import 'package:shop_app/shop_app_cubit/shop_cubit.dart';
import 'package:shop_app/shop_app_cubit/shop_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => bulidItem(
              ShopAppCubit.get(context).categoriesmodel!.data!.data[index]),
          separatorBuilder: (context, index) => Container(
            height: 1,
            color: Colors.grey[400],
          ),
          itemCount:
              ShopAppCubit.get(context).categoriesmodel!.data!.data.length,
        ));
      },
    );
  }

  Widget bulidItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              height: 100,
              width: 100,
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              '${model.name!.toUpperCase()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                letterSpacing: 3,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
