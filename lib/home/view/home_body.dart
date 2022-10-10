import 'package:cs_ui/cs_ui.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/home/bloc/home_bloc.dart';
import 'package:wesy/home/home.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   context.read<HomeBloc>().add(
    //         HomeStarted(
    //           appState: context.read<AppBloc>().state,
    //         ),
    //       );
    // });
  }

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeBloc>().state;
    final app = context.watch<AppBloc>().state;
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkResponse(
                onTap: () => home.scaffoldKey!.currentState!.openDrawer(),
                child: SvgPicture.asset(
                  'assets/svgs/drawer.svg',
                  color: CsColors.primary,
                ),
              ),
              const Spacer(),
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                onSelected: (value) {},
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      height: 50,
                      onTap: () =>
                          context.read<AppBloc>().add(const SetLocale('en')),
                      child: Center(
                        child: SvgPicture.asset(
                          'ic_flag_en'.svg,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      height: 50,
                      onTap: () =>
                          context.read<AppBloc>().add(const SetLocale('de')),
                      child: Center(
                        child: SvgPicture.asset(
                          'ic_flag_de'.svg,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      height: 50,
                      onTap: () =>
                          context.read<AppBloc>().add(const SetLocale('fr')),
                      child: Center(
                        child: SvgPicture.asset(
                          'ic_flag_fr'.svg,
                        ),
                      ),
                    ),
                  ];
                },
                child: BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    if (state.currentLocale == 'en') {
                      return Row(
                        children: [
                          SvgPicture.asset(
                            'ic_flag_en'.svg,
                          ),
                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      );
                    } else if (state.currentLocale == 'fr') {
                      return Row(
                        children: [
                          SvgPicture.asset(
                            'ic_flag_fr'.svg,
                          ),
                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      );
                    }
                    return Row(
                      children: [
                        SvgPicture.asset(
                          'ic_flag_de'.svg,
                        ),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    );
                  },
                ),
              ),
              if (1 == 2)
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: CsColors.primary,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: CsColors.primary),
                  ),
                  child: const Icon(
                    LineIcons.user,
                    color: CsColors.white,
                  ),
                ),
            ],
          ),
          Gap(context.minBlockVertical * 2.0),
          RichText(
            text: TextSpan(
              text: '${l10n.welcome} ',
              style: CsTextStyle.headline3,
              children: [
                TextSpan(
                  text: app.user.firstName,
                  style: CsTextStyle.headline3,
                ),
              ],
            ),
          ),
          Gap(context.minBlockVertical * 3.0),
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<AppBloc, AppState>(
                builder: (context, state) {
                  if (state.user.roles!.length == 3) {
                    return Column(
                      children: [
                        //makeGroupData
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state.regionsStatus == RegionsStatus.success) {
                              return BarChartSample2(
                                title: l10n.route_store,
                                titles: (value) {
                                  return state.regionStats[value.toInt()].label!
                                      .substring(0, 3);
                                },
                                data: state.regionStats.map((e) {
                                  final index = state.regionStats.indexWhere(
                                    (element) => element.label == e.label,
                                  );
                                  return BarChartGroupData(
                                    barsSpace: 4,
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        y: e.count!.toDouble(),
                                        colors: [CsColors.primary],
                                        width: 10,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              );
                            } else {
                              return Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          l10n.route_store,
                                          style:
                                              CsTextStyle.headline4.copyWith(),
                                        ),
                                      ),
                                      Gap(context.minBlockVertical * 2.0),
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Gap(context.minBlockVertical * 3.0),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state.routeTypeStatus ==
                                RouteTypeStatus.success) {
                              return CustomPieChart(
                                title: l10n.route_percentage,
                                labels: state.routeTypeStats.map((e) {
                                  final colors = <Color>[
                                    const Color.fromRGBO(0, 171, 85, 1),
                                    const Color.fromRGBO(24, 144, 255, 1),
                                    const Color.fromRGBO(255, 193, 7, 1),
                                    const Color(0xff13d38e)
                                  ];
                                  final index = state.routeTypeStats.indexWhere(
                                    (element) => element.label == e.label,
                                  );
                                  return Indicator(
                                    color: colors[index],
                                    text: e.label!.capitalizeFirst,
                                    isSquare: false,
                                    // textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                                  );
                                }).toList(),
                                data: state.routeTypeStats.map((e) {
                                  final colors = <Color>[
                                    const Color.fromRGBO(0, 171, 85, 1),
                                    const Color.fromRGBO(24, 144, 255, 1),
                                    const Color.fromRGBO(255, 193, 7, 1),
                                    const Color(0xff13d38e)
                                  ];
                                  final index = state.routeTypeStats.indexWhere(
                                    (element) => element.label == e.label,
                                  );
                                  return PieChartSectionData(
                                    color: colors[index].withOpacity(1),
                                    value: e.count! * 10.0,
                                    title: '${e.count! * 10}%',
                                    radius: 100,
                                    titleStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffffffff),
                                    ),
                                    titlePositionPercentageOffset: 0.6,
                                    borderSide: BorderSide(
                                      color: colors[index].withOpacity(0),
                                    ),
                                  );
                                }).toList(),
                              );
                            } else {
                              return Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          l10n.route_percentage,
                                          style:
                                              CsTextStyle.headline4.copyWith(),
                                        ),
                                      ),
                                      Gap(context.minBlockVertical * 2.0),
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Gap(context.minBlockVertical * 3.0),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state.regionConstructionStatus ==
                                RegionConstructionStatus.success) {
                              return BarChartSample2(
                                title: l10n.route_construction,
                                titles: (value) {
                                  return state
                                      .regionConstructionStats[value.toInt()]
                                      .label!
                                      .substring(0, 3);
                                },
                                data: state.regionConstructionStats.map((e) {
                                  final index =
                                      state.regionConstructionStats.indexWhere(
                                    (element) => element.label == e.label,
                                  );
                                  return BarChartGroupData(
                                    barsSpace: 4,
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        y: e.count!.toDouble(),
                                        colors: [CsColors.primary],
                                        width: 10,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              );
                            } else {
                              return Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          l10n.route_construction,
                                          style:
                                              CsTextStyle.headline4.copyWith(),
                                        ),
                                      ),
                                      Gap(context.minBlockVertical * 2.0),
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Gap(context.minBlockVertical * 3.0),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state.pinPotentialStatus ==
                                PinPotentialStatus.success) {
                              return CustomPieChart(
                                title: l10n.pin_potential,
                                labels: state.pinPotentialStats.map((e) {
                                  final colors = <Color>[
                                    const Color.fromRGBO(0, 171, 85, 1),
                                    const Color.fromRGBO(24, 144, 255, 1),
                                    const Color.fromRGBO(255, 193, 7, 1),
                                    const Color(0xff13d38e)
                                  ];
                                  final index =
                                      state.pinPotentialStats.indexWhere(
                                    (element) => element.label == e.label,
                                  );
                                  return Indicator(
                                    color: colors[index],
                                    text: e.label!.capitalizeFirst,
                                    isSquare: false,
                                    // textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                                  );
                                }).toList(),
                                data: state.pinPotentialStats.map((e) {
                                  final colors = <Color>[
                                    const Color.fromRGBO(0, 171, 85, 1),
                                    const Color.fromRGBO(24, 144, 255, 1),
                                    const Color.fromRGBO(255, 193, 7, 1),
                                    const Color(0xff13d38e)
                                  ];
                                  final index =
                                      state.pinPotentialStats.indexWhere(
                                    (element) => element.label == e.label,
                                  );
                                  return PieChartSectionData(
                                    color: colors[index].withOpacity(1),
                                    value: e.count! * 10.0,
                                    title: '${e.count! * 10}%',
                                    radius: 100,
                                    titleStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffffffff),
                                    ),
                                    titlePositionPercentageOffset: 0.6,
                                    borderSide: BorderSide(
                                      color: colors[index].withOpacity(0),
                                    ),
                                  );
                                }).toList(),
                              );
                            } else {
                              return Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          l10n.pin_potential,
                                          style:
                                              CsTextStyle.headline4.copyWith(),
                                        ),
                                      ),
                                      Gap(context.minBlockVertical * 2.0),
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Gap(context.minBlockVertical * 3.0),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state.constructionBranchStatus ==
                                ConstructionBranchStatus.success) {
                              return BarChartSample2(
                                title: l10n.con_visit,
                                titles: (value) {
                                  return getMonthWithValue(
                                    state.constructionBranchStats[value.toInt()]
                                        .label!,
                                  );
                                },
                                data: state.constructionBranchStats.map((e) {
                                  final index =
                                      state.constructionBranchStats.indexWhere(
                                    (element) => element.label == e.label,
                                  );
                                  return BarChartGroupData(
                                    barsSpace: 4,
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        y: e.count!.toDouble(),
                                        colors: [CsColors.primary],
                                        width: 10,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              );
                            } else {
                              return Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          l10n.con_visit,
                                          style:
                                              CsTextStyle.headline4.copyWith(),
                                        ),
                                      ),
                                      Gap(context.minBlockVertical * 2.0),
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Gap(context.minBlockVertical * 3.0),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state.storeBranchStatus ==
                                StoreBranchStatus.success) {
                              return BarChartSample2(
                                title: l10n.store_visit,
                                titles: (value) {
                                  return getMonthWithValue(
                                    state
                                        .storeBranchStats[value.toInt()].label!,
                                  );
                                },
                                data: state.storeBranchStats.map((e) {
                                  final index =
                                      state.storeBranchStats.indexWhere(
                                    (element) => element.label == e.label,
                                  );
                                  return BarChartGroupData(
                                    barsSpace: 4,
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        y: e.count!.toDouble(),
                                        colors: [CsColors.primary],
                                        width: 10,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              );
                            } else {
                              return Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          l10n.store_visit,
                                          style:
                                              CsTextStyle.headline4.copyWith(),
                                        ),
                                      ),
                                      Gap(context.minBlockVertical * 2.0),
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Gap(context.minBlockVertical * 3.0),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state.industryBranchStatus ==
                                IndustryBranchStatus.success) {
                              return BarChartSample2(
                                title: l10n.industry_visit,
                                titles: (value) {
                                  return getMonthWithValue(
                                    state.industryBranchStats[value.toInt()]
                                        .label!,
                                  );
                                },
                                data: state.industryBranchStats.map((e) {
                                  final index =
                                      state.industryBranchStats.indexWhere(
                                    (element) => element.label == e.label,
                                  );
                                  return BarChartGroupData(
                                    barsSpace: 4,
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        y: e.count!.toDouble(),
                                        colors: [CsColors.primary],
                                        width: 10,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              );
                            } else {
                              return Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          l10n.industry_visit,
                                          style:
                                              CsTextStyle.headline4.copyWith(),
                                        ),
                                      ),
                                      Gap(context.minBlockVertical * 2.0),
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  } else if (state.user.roles!.length == 2) {
                    return Column(
                      children: [
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state.routeCountStatus ==
                                RouteCountStatus.success) {
                              return BarChartSample2(
                                title: l10n.route_count,
                                titles: (value) {
                                  return state
                                          .routeCount[value.toInt()].label ??
                                      '';
                                },
                                data: state.routeCount.map((e) {
                                  final index = state.routeCount.indexWhere(
                                    (element) => element.label == e.label,
                                  );
                                  return BarChartGroupData(
                                    barsSpace: 4,
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        y: e.count!.toDouble(),
                                        colors: [CsColors.primary],
                                        width: 10,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              );
                            } else {
                              return Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          l10n.route_count,
                                          style:
                                              CsTextStyle.headline4.copyWith(),
                                        ),
                                      ),
                                      Gap(context.minBlockVertical * 2.0),
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Gap(context.minBlockVertical * 3.0),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state.pinPotentialStatus ==
                                PinPotentialStatus.success) {
                              return CustomPieChart(
                                title: l10n.pin_grouped_by_pontential,
                                labels: state.pinPotentialStats.map((e) {
                                  final colors = <Color>[
                                    const Color.fromRGBO(0, 171, 85, 1),
                                    const Color.fromRGBO(24, 144, 255, 1),
                                    const Color.fromRGBO(255, 193, 7, 1),
                                    const Color(0xff13d38e)
                                  ];
                                  final index =
                                      state.pinPotentialStats.indexWhere(
                                    (element) => element.label == e.label,
                                  );
                                  return Indicator(
                                    color: colors[index],
                                    text: e.label!.capitalizeFirst,
                                    isSquare: false,
                                    // textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                                  );
                                }).toList(),
                                data: state.pinPotentialStats.map((e) {
                                  final colors = <Color>[
                                    const Color.fromRGBO(0, 171, 85, 1),
                                    const Color.fromRGBO(24, 144, 255, 1),
                                    const Color.fromRGBO(255, 193, 7, 1),
                                    const Color(0xff13d38e)
                                  ];
                                  final index =
                                      state.pinPotentialStats.indexWhere(
                                    (element) => element.label == e.label,
                                  );
                                  return PieChartSectionData(
                                    color: colors[index].withOpacity(1),
                                    value: e.count! * 10.0,
                                    title: '${e.count! * 10}%',
                                    radius: 100,
                                    titleStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffffffff),
                                    ),
                                    titlePositionPercentageOffset: 0.6,
                                    borderSide: BorderSide(
                                      color: colors[index].withOpacity(0),
                                    ),
                                  );
                                }).toList(),
                              );
                            } else {
                              return Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          l10n.pin_potential,
                                          style:
                                              CsTextStyle.headline4.copyWith(),
                                        ),
                                      ),
                                      Gap(context.minBlockVertical * 2.0),
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Gap(context.minBlockVertical * 3.0),
                      ],
                    );
                  } else {
                    return Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state.workerRouteStatus ==
                                WorkerRouteStatus.success) {
                              return Column(
                                children: [
                                  Align(
                                    child: Text(
                                      l10n.your_routes,
                                      style: CsTextStyle.headline4.copyWith(),
                                    ),
                                  ),
                                  Gap(context.minBlockVertical * 4.0),
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: CsColors.primary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          state.workerRouteCount,
                                          style: CsTextStyle.headline1.copyWith(
                                            color: CsColors.white,
                                          ),
                                        ),
                                        Text(
                                          l10n.route,
                                          style: CsTextStyle.headline4.copyWith(
                                            color: CsColors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Align(
                                    child: Text(
                                      l10n.your_routes,
                                      style: CsTextStyle.headline4.copyWith(),
                                    ),
                                  ),
                                  Gap(context.minBlockVertical * 2.0),
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getMonthWithValue(int value) {
    switch (value) {
      case 1:
        return 'Ja';
      case 2:
        return 'Fe';
      case 3:
        return 'Ma';
      case 4:
        return 'Ap';
      case 5:
        return 'Ma';
      case 6:
        return 'Ju';
      case 7:
        return 'Ju';
      case 8:
        return 'Au';
      case 9:
        return 'Se';
      case 10:
        return 'Oc';
      case 11:
        return 'No';
      case 12:
        return 'De';
      default:
        return 'Unk';
    }
  }
}
