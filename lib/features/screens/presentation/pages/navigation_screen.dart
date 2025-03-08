import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shoppie_well/features/screens/presentation/pages/cart_screen.dart';

import 'main_home_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PersistentTabController _controller;
  final List<ScrollController> _scrollControllers = [
    ScrollController(),
    ScrollController(),
  ];
  DateTime? _lastPressed;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }



  @override
  void dispose() {
    for (final element in _scrollControllers) {
      element.dispose();
    }
    super.dispose();
  }

  List<Widget> _buildScreens() => [
    MainHomePage(),
    Container(),
    CartScreen(),
    Container(),
    Container(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home_filled),
      title: "Home",
      activeColorPrimary: Colors.red,
      inactiveColorPrimary: Colors.grey,
      scrollController: _scrollControllers.first,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.favorite),
      title: "Wishlist",
      activeColorPrimary: Colors.red,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(
        Icons.shopping_cart,
        color: Colors.white,
      ),
      title: "Cart",
      activeColorPrimary: Colors.red,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.search_rounded),
      title: "Search",
      activeColorPrimary: Colors.red,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.settings),
      title: "Settings",
      activeColorPrimary: Colors.red,
      inactiveColorPrimary: Colors.grey,
      scrollController: _scrollControllers.last,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.once,
      hideOnScrollSettings: HideOnScrollSettings(
        hideNavBarOnScroll: false, // Prevent hiding nav bar on scroll
        scrollControllers: _scrollControllers,
      ),
      padding: const EdgeInsets.only(top: 8),
      onWillPop: (final context) async {
        DateTime now = DateTime.now();
        if (_lastPressed == null ||
            now.difference(_lastPressed!) > const Duration(seconds: 2)) {
          _lastPressed = now;
          ScaffoldMessenger.of(context ?? this.context).showSnackBar(
            const SnackBar(
              content: Text("Press back again to exit"),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
        // Exit the app
        SystemNavigator.pop();
        return true;
      },
      backgroundColor: Colors.white,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 250),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
        onNavBarHideAnimation: OnHideAnimationSettings(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: NavBarStyle.style15,
      onItemSelected: (index) {

      },
    );
  }
}
