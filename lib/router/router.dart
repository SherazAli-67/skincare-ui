import 'package:go_router/go_router.dart';
import 'package:skincare/presentation/screens/welcome_screen.dart';

GoRouter router = GoRouter(
    initialLocation: NamedRoutes.welcome.routeName,
    routes: [
      GoRoute(path: NamedRoutes.welcome.routeName, builder: (_, state)=> WelcomeScreen())
    ],
);

enum NamedRoutes{
  welcome('/welcome');

  final String routeName;
  const NamedRoutes(this.routeName);
}