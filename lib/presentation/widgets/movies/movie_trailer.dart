import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailer extends ConsumerWidget {
  const MovieTrailer({super.key, required this.movieId});

  final String movieId;

  @override
  Widget build(BuildContext context, ref) {
    final videos = ref.watch(moviesVideosProvider);
    final styles = Theme.of(context).textTheme;

    if (videos[movieId] == null) {
      return ListTile(
        title: Text(
          'Trailer',
          style: styles.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        contentPadding: EdgeInsets.zero,
        subtitle: const SizedBox(
          width: double.infinity,
          height: 120,
          child: Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    return _YoutubePlayer(youtubeKey: videos[movieId]!.youtubeKey);
  }
}

class _YoutubePlayer extends StatefulWidget {
  const _YoutubePlayer({required this.youtubeKey});

  final String youtubeKey;

  @override
  State<_YoutubePlayer> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<_YoutubePlayer> {
  late YoutubePlayerController youtubePlayerController;

  @override
  void initState() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.youtubeKey,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
    super.initState();
  }

  @override
  void dispose() {
    youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    return ListTile(
      title: Text(
        'Trailer',
        style: styles.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
      contentPadding: EdgeInsets.zero,
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: YoutubePlayer(controller: youtubePlayerController),
      ),
    );
  }
}
