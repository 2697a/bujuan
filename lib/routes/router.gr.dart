// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../pages/home/first/first_view.dart' deferred as _i1;
import '../pages/index/album_view.dart' as _i4;
import '../pages/index/main_view.dart' deferred as _i6;
import '../pages/login/login.dart' as _i2;
import '../pages/play_list/playlist.dart' as _i5;
import '../pages/user/user_view.dart' as _i3;

class RootRouter extends _i7.RootStackRouter {
  RootRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    FirstView.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.FirstView(),
        ),
      );
    },
    LoginView.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginView(),
      );
    },
    UserView.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.UserView(),
      );
    },
    AlbumView.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.AlbumView(),
      );
    },
    PlayList.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.PlayList(),
      );
    },
    MainView.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.MainView(),
        ),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/home',
          fullMatch: true,
        ),
        _i7.RouteConfig(
          FirstView.name,
          path: '/home',
          deferredLoading: true,
          children: [
            _i7.RouteConfig(
              '#redirect',
              path: '',
              parent: FirstView.name,
              redirectTo: 'index',
              fullMatch: true,
            ),
            _i7.RouteConfig(
              UserView.name,
              path: 'user',
              parent: FirstView.name,
            ),
            _i7.RouteConfig(
              AlbumView.name,
              path: 'search',
              parent: FirstView.name,
            ),
            _i7.RouteConfig(
              PlayList.name,
              path: 'playlist',
              parent: FirstView.name,
            ),
            _i7.RouteConfig(
              MainView.name,
              path: 'index',
              parent: FirstView.name,
              deferredLoading: true,
            ),
          ],
        ),
        _i7.RouteConfig(
          LoginView.name,
          path: '/login',
        ),
      ];
}

/// generated route for
/// [_i1.FirstView]
class FirstView extends _i7.PageRouteInfo<void> {
  const FirstView({List<_i7.PageRouteInfo>? children})
      : super(
          FirstView.name,
          path: '/home',
          initialChildren: children,
        );

  static const String name = 'FirstView';
}

/// generated route for
/// [_i2.LoginView]
class LoginView extends _i7.PageRouteInfo<void> {
  const LoginView()
      : super(
          LoginView.name,
          path: '/login',
        );

  static const String name = 'LoginView';
}

/// generated route for
/// [_i3.UserView]
class UserView extends _i7.PageRouteInfo<void> {
  const UserView()
      : super(
          UserView.name,
          path: 'user',
        );

  static const String name = 'UserView';
}

/// generated route for
/// [_i4.AlbumView]
class AlbumView extends _i7.PageRouteInfo<void> {
  const AlbumView()
      : super(
          AlbumView.name,
          path: 'search',
        );

  static const String name = 'AlbumView';
}

/// generated route for
/// [_i5.PlayList]
class PlayList extends _i7.PageRouteInfo<void> {
  const PlayList()
      : super(
          PlayList.name,
          path: 'playlist',
        );

  static const String name = 'PlayList';
}

/// generated route for
/// [_i6.MainView]
class MainView extends _i7.PageRouteInfo<void> {
  const MainView()
      : super(
          MainView.name,
          path: 'index',
        );

  static const String name = 'MainView';
}
