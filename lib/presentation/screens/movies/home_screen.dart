import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.childView, required this.children});

  static const name = 'home-screen';

  final StatefulNavigationShell childView;
  final List<Widget> children;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        widget.childView.currentIndex,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: widget.children,
      ),
      /* Center(
        child: widget.childView,
      ), */
      bottomNavigationBar: CustomBottomNavigation(
        currentChild: widget.childView,
      ),
    );
  }
}
