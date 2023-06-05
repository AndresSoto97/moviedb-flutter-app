import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.childView});

  static const name = 'home-screen';

  final StatefulNavigationShell childView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: childView,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentChild: childView,
      ),
    );
  }
}
