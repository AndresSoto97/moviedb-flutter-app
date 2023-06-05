import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomeScreen(
        childView: navigationShell,
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) {
                return const HomeView();
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
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) {
                return const FavoritesView();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) {
                return const FavoritesView();
              },
            ),
          ],
        ),
      ],
    ),
    
    /* ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomeView();
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
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesView();
          },
        ), */
    /* GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomeView();
          },
        ), 
      ],
    ),*/

    // RUTAS PADRE - HIJO
    /* GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(childView: FavoritesView()),
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
    ), */
  ],
);
