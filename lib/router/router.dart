import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skincare/presentation/providers/home_provider.dart';
import 'package:skincare/presentation/screens/cart_screen.dart';
import 'package:skincare/presentation/screens/categories_screen.dart';
import 'package:skincare/presentation/screens/home_screen.dart';
import 'package:skincare/presentation/screens/main_shell_screen.dart';
import 'package:skincare/presentation/screens/profile_screen.dart';
import 'package:skincare/presentation/screens/skin_analysis_screen.dart';
import 'package:skincare/presentation/screens/welcome_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.welcome.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (_, state) => const WelcomeScreen()),
    StatefulShellRoute.indexedStack(
      builder: (_, state, navigationShell) => MainShellScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NamedRoutes.home.routeName,
              builder: (_, state) => ChangeNotifierProvider(
                create: (_) => HomeProvider(),
                child: const HomeScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.categories.routeName, builder: (_, state) => const CategoriesScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.cart.routeName, builder: (_, state) => const CartScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: NamedRoutes.profile.routeName, builder: (_, state) => const ProfileScreen()),
          ],
        ),
      ],
    ),
    GoRoute(
      path: NamedRoutes.skinAnalysis.routeName,
      builder: (_, state) => const SkinAnalysisScreen(),
    ),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  home('/home'),
  categories('/categories'),
  cart('/cart'),
  profile('/profile'),
  skinAnalysis('/skin-analysis');

  final String routeName;
  const NamedRoutes(this.routeName);
}
