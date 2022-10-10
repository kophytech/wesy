part of 'home_bloc.dart';

enum RouteTypeStatus {
  loading,
  success,
  failure,
}

enum PinPotentialStatus {
  loading,
  success,
  failure,
}

enum RegionsStatus {
  loading,
  success,
  failure,
}

enum RegionConstructionStatus {
  loading,
  success,
  failure,
}

enum ConstructionBranchStatus {
  loading,
  success,
  failure,
}

enum StoreBranchStatus {
  loading,
  success,
  failure,
}

enum IndustryBranchStatus {
  loading,
  success,
  failure,
}

enum WorkerRouteStatus {
  loading,
  success,
  failure,
}

enum RouteCountStatus {
  loading,
  success,
  failure,
}

class HomeState extends Equatable {
  const HomeState({
    this.scaffoldKey,
    this.currentIndex = 0,
    this.pinPotentialStatus = PinPotentialStatus.loading,
    this.routeTypeStatus = RouteTypeStatus.loading,
    this.regionsStatus = RegionsStatus.loading,
    this.regionConstructionStatus = RegionConstructionStatus.loading,
    this.constructionBranchStatus = ConstructionBranchStatus.loading,
    this.industryBranchStatus = IndustryBranchStatus.loading,
    this.storeBranchStatus = StoreBranchStatus.loading,
    this.routeTypeStats = const [],
    this.pinPotentialStats = const [],
    this.regionStats = const [],
    this.regionConstructionStats = const [],
    this.constructionBranchStats = const [],
    this.industryBranchStats = const [],
    this.storeBranchStats = const [],
    this.workerRouteCount = '',
    this.workerRouteStatus = WorkerRouteStatus.loading,
    this.routeCountStatus = RouteCountStatus.loading,
    this.routeCount = const [],
    this.pages = const [
      HomeBody(),
      RegionPage(),
      NotificationPage(),
      SettingPage(),
    ],
  });

  HomeState copyWith({
    int? currentIndex,
    List<Widget>? pages,
    GlobalKey<ScaffoldState>? scaffoldKey,
    RouteTypeStatus? routeTypeStatus,
    List<RouteTypeStats>? routeTypeStats,
    PinPotentialStatus? pinPotentialStatus,
    List<RouteTypeStats>? pinPotentialStats,
    List<RouteTypeStats>? regionStats,
    RegionsStatus? regionsStatus,
    RegionConstructionStatus? regionConstructionStatus,
    List<RouteTypeStats>? regionConstructionStats,
    ConstructionBranchStatus? constructionBranchStatus,
    StoreBranchStatus? storeBranchStatus,
    IndustryBranchStatus? industryBranchStatus,
    List<BranchStats>? constructionBranchStats,
    List<BranchStats>? storeBranchStats,
    List<BranchStats>? industryBranchStats,
    WorkerRouteStatus? workerRouteStatus,
    String? workerRouteCount,
    List<RouteTypeStats>? routeCount,
    RouteCountStatus? routeCountStatus,
  }) {
    return HomeState(
      currentIndex: currentIndex ?? this.currentIndex,
      pages: pages ?? this.pages,
      scaffoldKey: scaffoldKey ?? this.scaffoldKey,
      routeTypeStatus: routeTypeStatus ?? this.routeTypeStatus,
      routeTypeStats: routeTypeStats ?? this.routeTypeStats,
      pinPotentialStatus: pinPotentialStatus ?? this.pinPotentialStatus,
      pinPotentialStats: pinPotentialStats ?? this.pinPotentialStats,
      regionStats: regionStats ?? this.regionStats,
      regionsStatus: regionsStatus ?? this.regionsStatus,
      regionConstructionStatus:
          regionConstructionStatus ?? this.regionConstructionStatus,
      regionConstructionStats:
          regionConstructionStats ?? this.regionConstructionStats,
      constructionBranchStatus:
          constructionBranchStatus ?? this.constructionBranchStatus,
      industryBranchStatus: industryBranchStatus ?? this.industryBranchStatus,
      storeBranchStatus: storeBranchStatus ?? this.storeBranchStatus,
      constructionBranchStats:
          constructionBranchStats ?? this.constructionBranchStats,
      industryBranchStats: industryBranchStats ?? this.industryBranchStats,
      storeBranchStats: storeBranchStats ?? this.storeBranchStats,
      workerRouteStatus: workerRouteStatus ?? this.workerRouteStatus,
      workerRouteCount: workerRouteCount ?? this.workerRouteCount,
      routeCount: routeCount ?? this.routeCount,
      routeCountStatus: routeCountStatus ?? this.routeCountStatus,
    );
  }

  final int currentIndex;
  final List<Widget> pages;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final RouteTypeStatus routeTypeStatus;
  final PinPotentialStatus pinPotentialStatus;
  final List<RouteTypeStats> routeTypeStats;
  final List<RouteTypeStats> pinPotentialStats;
  final List<RouteTypeStats> regionStats;
  final RegionsStatus regionsStatus;
  final RegionConstructionStatus regionConstructionStatus;
  final List<RouteTypeStats> regionConstructionStats;
  final ConstructionBranchStatus constructionBranchStatus;
  final StoreBranchStatus storeBranchStatus;
  final IndustryBranchStatus industryBranchStatus;
  final List<BranchStats> constructionBranchStats;
  final List<BranchStats> storeBranchStats;
  final List<BranchStats> industryBranchStats;
  final String workerRouteCount;
  final WorkerRouteStatus workerRouteStatus;
  final List<RouteTypeStats> routeCount;
  final RouteCountStatus routeCountStatus;

  @override
  List<Object?> get props => [
        currentIndex,
        pages,
        scaffoldKey,
        routeTypeStatus,
        routeTypeStats,
        pinPotentialStatus,
        pinPotentialStats,
        regionStats,
        regionsStatus,
        regionConstructionStatus,
        regionConstructionStats,
        constructionBranchStatus,
        storeBranchStatus,
        industryBranchStatus,
        constructionBranchStats,
        storeBranchStats,
        industryBranchStats,
        workerRouteCount,
        workerRouteStatus,
        routeCount,
        routeCountStatus,
      ];
}
