import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reu_app/constants.dart';
import 'package:reu_app/screens/activity/activity.dart';
import 'package:reu_app/screens/home/home.dart';
import 'package:reu_app/screens/polls/polls.dart';
import 'package:reu_app/screens/residents/residents.dart';
import 'package:reu_app/screens/warnings/warnings.dart';
import 'package:reu_app/widgets/custom_drawer.dart';

class HomePageController extends StatelessWidget {
  HomePageController({super.key});

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    AppBar buildAppBar() {
      return AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: () {},
        ),
      );
    }

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        Scaffold(
          body: HomePage(),
          drawer: CustomDrawer(
            pageController: _pageController,
          ),
        ),
        Scaffold(
          body: PoolPage(),
          drawer: CustomDrawer(
            pageController: _pageController,
          ),
        ),
        Scaffold(
          body: WarningPage(),
          drawer: CustomDrawer(
            pageController: _pageController,
          ),
        ),
        Scaffold(
          body: ResidentsPage(),
          drawer: CustomDrawer(
            pageController: _pageController,
          ),
        ),
        Scaffold(
          body: ActivityPage(),
          drawer: CustomDrawer(
            pageController: _pageController,
          ),
        ),
      ],
    );
  }
}
