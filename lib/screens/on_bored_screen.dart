import 'package:flutter/material.dart';
import 'package:shop_app/login/login_screen.dart';
import 'package:shop_app/sherd/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoredModel {
  final String image;
  final String title;
  final String bodytext;

  OnBoredModel({
    required this.image,
    required this.title,
    required this.bodytext,
  });
}

class OnBoredingScreen extends StatefulWidget {
  //const OnBoredingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoredingScreen> createState() => _OnBoredingScreenState();
}

class _OnBoredingScreenState extends State<OnBoredingScreen> {
  List<OnBoredModel> dataBoredSCreens = [
    OnBoredModel(
      image: 'assets/images/layer.png',
      title: 'title1',
      bodytext: 'bodytext1',
    ),
    OnBoredModel(
      image: 'assets/images/layer.png',
      title: 'title2',
      bodytext: 'bodytext2',
    ),
    OnBoredModel(
      image: 'assets/images/layer.png',
      title: 'title3',
      bodytext: 'bodytext3',
    ),
  ];

  var onboredConttroller = PageController();

  bool islast = false;

  void submit() {
    CacheHellper.setData(key: 'onbored', value: true).then((value) {
      if (value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: const Text(
              'SKIP',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildOnBoreding(dataBoredSCreens[index]),
                itemCount: dataBoredSCreens.length,
                physics: const BouncingScrollPhysics(),
                controller: onboredConttroller,
                onPageChanged: (value) {
                  if (value == dataBoredSCreens.length - 1) {
                    //  print('is last');

                    setState(() {
                      islast = true;
                    });
                  } else {
                    //   print('not last');
                    setState(() {
                      islast = false;
                    });
                  }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: onboredConttroller,
                  count: dataBoredSCreens.length,
                  effect: const WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Colors.blue,
                    spacing: 4,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      submit();
                    } else {
                      onboredConttroller.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoreding(OnBoredModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
              // fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text('${model.title}'),
          SizedBox(
            height: 20,
          ),
          Text('${model.bodytext}'),
        ],
      );
}
