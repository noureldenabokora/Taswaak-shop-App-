import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app_cubit/shop_cubit.dart';
import 'package:shop_app/shop_app_cubit/shop_states.dart';

class FaveoriteScreen extends StatelessWidget {
  const FaveoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilderRec(
            condition: true,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildFavItem(),
              separatorBuilder: (context, index) => Container(
                height: 1,
                color: Colors.grey,
              ),
              itemCount: 10,
              //   ShopAppCubit.get(context).favoritemodel!.data!.data!.length,
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget buildFavItem() => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    'https://student.valuxapps.com/storage/uploads/products/1615440689wYMHV.item_XXL_36330138_142814934.jpeg',
                  ),
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
                //   if (model.price != model.oldprice)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  //  width: 80,
                  child: const Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.55,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 30),
            //  Text('dcdcdwsdwdwde'),
            Expanded(
              child: Column(
                children: [
                  Text(
                    ' Apple iPhone 12 Pro Max 256GB 6 GB RAM, Pacific Blue',
                    style: const TextStyle(fontSize: 17),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'data',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        'oldprice',
                        style: const TextStyle(
                          fontSize: 12,
                          //color: Colors.blue,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          //  ShopAppCubit.get(context).ChangeFavorite(model.id!);
                        },
                        //    color: Colors.white,
                        icon: CircleAvatar(
                          backgroundColor:
                              // !ShopAppCubit.get(context).faveorite[model.id]!
                              //     ? Colors.grey
                              Colors.blue,
                          radius: 35,
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
