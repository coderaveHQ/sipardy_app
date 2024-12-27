import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:sipardy_app/src/features/create_game/presentation/pages/create_game_page.dart';
import 'package:sipardy_app/src/features/game_room/presentation/pages/game_room_page.dart';
import 'package:sipardy_app/src/features/join_game/presentation/pages/join_game_page.dart';
import 'package:sipardy_app/src/features/menu/presentation/pages/menu_page.dart';

part 'router.g.dart';

/// The application router
@riverpod
GoRouter router(Ref ref) {

  // Construct the router
  final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: MenuRoute.location,
    routes: $appRoutes
  );

  // Dispose the router when the provider is disposed
  ref.onDispose(router.dispose);

  return router;
}

/// The root navigator key
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// The menu route
@TypedGoRoute<MenuRoute>(path: MenuRoute.location)
class MenuRoute extends GoRouteData {

  /// Default constructor
  const MenuRoute();

  /// The location of the route
  static const String location = '/';
  /// The full path of the route
  static const String path = location;

  /// The parent navigator key
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MenuPage();
  }
}

/// The create game route
@TypedGoRoute<CreateGameRoute>(path: CreateGameRoute.location)
class CreateGameRoute extends GoRouteData {

  /// Default constructor
  const CreateGameRoute();

  /// The location of the route
  static const String location = '/create';
  /// The full path of the route
  static const String path = location;

  /// The parent navigator key
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CreateGamePage();
  }
}

/// The join game route
@TypedGoRoute<JoinGameRoute>(path: JoinGameRoute.location)
class JoinGameRoute extends GoRouteData {

  /// Default constructor
  const JoinGameRoute();

  /// The location of the route
  static const String location = '/join';
  /// The full path of the route
  static const String path = location;

  /// The parent navigator key
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const JoinGamePage();
  }
}

/// The game room route
@TypedGoRoute<GameRoomRoute>(path: GameRoomRoute.location)
class GameRoomRoute extends GoRouteData {

  /// The room id
  final String id;

  /// Default constructor
  const GameRoomRoute(this.id);

  /// The location of the route
  static const String location = '/game/:id';
  /// The full path of the route
  static const String path = location;

  /// The parent navigator key
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return GameRoomPage(roomId: id);
  }
}