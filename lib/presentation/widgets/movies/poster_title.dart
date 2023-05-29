import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class PosterTitle extends StatelessWidget {
  const PosterTitle({
    super.key,
    required this.movie,
    this.showTitle = false,
  });

  final Movie movie;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Container(
      alignment: Alignment.bottomLeft,
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black,
          ],
          stops: [0.5, 1.0],
        ),
      ),
      child: SizedBox(
        height: 50,
        child: FadeInLeft(
          animate: showTitle,
          child: Text(
            movie.title,
            style: styles.titleMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
