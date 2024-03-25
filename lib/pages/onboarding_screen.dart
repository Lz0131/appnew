import 'package:flutter/material.dart';
import 'package:appnew/pages/home_page.dart';
import 'package:appnew/intro_screens/intro_page_1.dart';
import 'package:appnew/intro_screens/intro_page_2.dart';
import 'package:appnew/intro_screens/intro_page_3.dart';
import 'package:appnew/settings/app_value_notifier.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreen();
}

class _OnBoardingScreen extends State<OnBoardingScreen> {
  //Control para deslizamiento de la pagina en la que estamos
  PageController _controller = PageController();
  //Realizar un seguimiento si estamos en la ultima pagina o no
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                if (index == 2) {
                  onLastPage = true;
                } else {
                  onLastPage = false;
                }
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text('skip'),
                ),

                SmoothPageIndicator(controller: _controller, count: 3),

                //Next or Done
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage(
                                  themeNotifier: AppValueNotifier.themeNotifier,
                                );
                              },
                            ),
                          );
                        },
                        child: const Text('done'),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text('next'),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
