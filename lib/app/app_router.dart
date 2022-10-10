import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wesy/add_worker/add_worker.dart';
import 'package:wesy/admin/admin.dart';
import 'package:wesy/admin/edit/edit.dart';
import 'package:wesy/broadcast/view/broadcast_page.dart';
import 'package:wesy/change_password/change_password.dart';
import 'package:wesy/construction/construction.dart';
import 'package:wesy/edit_profile/edit_profile.dart';
import 'package:wesy/edit_worker/view/edit_worker_page.dart';
import 'package:wesy/home/home.dart';
import 'package:wesy/industry/industry.dart'; 
import 'package:wesy/landing/landing.dart';
import 'package:wesy/landing/view/splash_page.dart';
import 'package:wesy/login/login.dart';
import 'package:wesy/pin/pin.dart';
import 'package:wesy/planing/planing.dart';
import 'package:wesy/region/region.dart';
import 'package:wesy/region_data/region_data.dart';
import 'package:wesy/register/register.dart';
import 'package:wesy/route/route.dart';
import 'package:wesy/route_detail/route_detail.dart';
import 'package:wesy/store/store.dart';
import 'package:wesy/unknown/unknown.dart';
import 'package:wesy/user_planner/user_planner.dart';
import 'package:wesy/worker/worker.dart';

class WesyPages {
  static const String landing = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgot = '/forgot';
  static const String home = '/home';
  static const String construction = '/construction';
  static const String store = '/store';
  static const String route = '/route';
  static const String routeDetails = '/route/detail';
  static const String region = '/region';
  static const String regionDetails = '/region';
  static const String industry = '/industry';
  static const String planing = '/planing';
  static const String splash = '/splash';
  static const String userPlaning = '/planing/user';
  static const String myPlan = '/planing/plan';
  static const String admin = '/admin';
  static const String addPin = '/pin/add';
  static const String pinDetails = '/pin/details';
  static const String addAdmin = '/admin/add';
  static const String editAdmin = '/admin/edit';
  static const String worker = '/worker';
  static const String editWorker = '/worker/edit';
  static const String addWorker = '/worker/add';
  static const String addBroadcast = '/broadcast/add';
  static const String changePassword = '/password/change';
  static const String editProfile = '/profile/edit';
}

class AppRouter {
  static GoRouter routes = GoRouter(
    routes: [
      GoRoute(
        path: WesyPages.landing,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const LandingPage(),
          );
        },
      ),
      GoRoute(
        path: WesyPages.login,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: WesyPages.register,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const RegisterPage(),
          );
        },
      ),
      GoRoute(
        path: WesyPages.home,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const HomePage(),
          );
        },
      ),
      GoRoute(
        path: WesyPages.changePassword,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const ChangePasswordPage(),
          );
        },
      ),
      GoRoute(
        path: WesyPages.editProfile,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const EditProfilePage(),
          );
        },
      ),
      GoRoute(
        path: WesyPages.addBroadcast,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const BroadcastPage(),
          );
        },
      ),
      GoRoute(
        path: WesyPages.planing,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const PlaningPage(),
          );
        },
      ),
      GoRoute(
        path: '${WesyPages.userPlaning}/:id',
        pageBuilder: (context, state) {
          final id = state.params['id'];
          return MaterialPage<void>(
            key: state.pageKey,
            child: UserPlannerPage(id: id),
          );
        },
      ),
      GoRoute(
        path: WesyPages.splash,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const SplashPage(),
          );
        },
      ),
      GoRoute(
        path: WesyPages.myPlan,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const PlansPage(),
          );
        },
      ),
      GoRoute(
        path: '${WesyPages.addPin}/:routeId',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: CreatePinPage(
              routeId: state.params['routeId']!,
              routeType: state.queryParams['type'] ?? 'others',
            ),
          );
        },
      ),
      GoRoute(
        path: '${WesyPages.pinDetails}/:pinId',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: PinDetailsPage(
              pinId: state.params['pinId']!,
              type: state.queryParams['type'] ?? '',
            ),
          );
        },
      ),
      GoRoute(
        path: '${WesyPages.editAdmin}/:adminId',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: EditAdminPage(adminId: state.params['adminId'] ?? ''),
          );
        },
      ),
      GoRoute(
        path: WesyPages.store,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const StorePage(),
          );
        },
      ),
      GoRoute(
        path: WesyPages.construction,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const ConstructionPage(),
          );
        },
      ),
      GoRoute(
        path: WesyPages.admin,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const AdminPage(),
          );
        },
      ),
      GoRoute(
        path: WesyPages.industry,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const IndustryPage(),
          );
        },
      ),
      GoRoute(
        path: WesyPages.route,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const RoutePage(),
          );
        },
      ),
      GoRoute(
        path: '${WesyPages.routeDetails}/:routeId',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: RouteDetailPage(routeId: state.params['routeId']!),
          );
        },
      ),
      GoRoute(
        path: WesyPages.addAdmin,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const CreateAdminPage(),
          );
        },
      ),
      GoRoute(
        path: WesyPages.worker,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const WorkerPage(),
          );
        },
      ),
      GoRoute(
        path: '${WesyPages.editWorker}/:workerId',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: EditWorkerPage(
              workerId: state.params['workerId'].toString(),
            ),
          );
        },
      ),
      GoRoute(
        path: WesyPages.region,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const RegionPage(),
          );
        },
      ),
      GoRoute(
        path: '${WesyPages.region}/:regionId',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: RegionDataPage(
              regionId: state.params['regionId'].toString(),
            ),
          );
        },
      ),
      GoRoute(
        path: WesyPages.addWorker,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const AddWorkerPage(),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: const UnknownPage(),
    ),
  );
}
