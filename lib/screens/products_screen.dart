//import 'dart:js';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/categories_model.dart';
import 'package:shop_app/modules/home_model.dart';
import 'package:shop_app/shop_app_cubit/shop_cubit.dart';
import 'package:shop_app/shop_app_cubit/shop_states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {
          if (state is ShopAppChangeFavoritesDataSucssesfullAppstate) {
            if (!state.model.status!) {
              Fluttertoast.showToast(
                msg: '${state.model.message}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 4,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          }
        },
        builder: (context, state) {
          return ConditionalBuilderRec(
            condition: ShopAppCubit.get(context).homemodel != null &&
                ShopAppCubit.get(context).categoriesmodel != null,
            builder: (context) => buildCuroserItem(
              ShopAppCubit.get(context).homemodel!,
              ShopAppCubit.get(context).categoriesmodel!,
              context,
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget buildCuroserItem(HomeModel model, CategoriesModel modell, context) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map(
                    (e) => Image(
                        // fit: BoxFit.cover,
                        image: NetworkImage(
                      '${e.image}',
                    )),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 3),
                viewportFraction: 1.0,
                height: 250,
                initialPage: 0,
                scrollDirection: Axis.horizontal,
                reverse: false,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categerioes',
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 3,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildcategroiusitem(modell.data!.data[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 13),
                      itemCount: modell.data!.data.length,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'New Products ',
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 3,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data!.products.length,
                (index) => buildGridItem(model.data!.products[index], context),
              ),
              childAspectRatio: 1 / 1.75,
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
            )
          ],
        ),
      );
  Widget buildcategroiusitem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image.toString()),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100,
            color: Colors.black.withOpacity(0.6),
            child: Text(
              '${model.name}',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
  Widget buildGridItem(ProductsModel model, context) => Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  '${model.image}',
                ),

                height: 185,
                //   fit: BoxFit.contain,
              ),
              if (model.price != model.oldprice)
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
//crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${model.name}',
                  style: const TextStyle(fontSize: 17),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${model.price}',
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
                    if (model.price != model.oldprice)
                      Text(
                        '${model.oldprice}',
                        style: const TextStyle(
                          fontSize: 12,
                          //color: Colors.blue,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopAppCubit.get(context).ChangeFavorite(model.id!);
                      },
                      //    color: Colors.white,
                      icon: CircleAvatar(
                        backgroundColor:
                            !ShopAppCubit.get(context).faveorite[model.id]!
                                ? Colors.grey
                                : Colors.blue,
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
      );
}
