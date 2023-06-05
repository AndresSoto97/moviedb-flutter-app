import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        GoRoute(
          path: 'movie/:id&:category',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            final category = state.pathParameters['category'];
            return MovieScreen(movieId: movieId, category: category!);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0',
    ),
  ],
);
