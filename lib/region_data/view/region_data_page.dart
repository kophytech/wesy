import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:cs_ui/src/extension/size.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/home/home.dart';
import 'package:wesy/region_data/cubit/region_data_cubit.dart';

class RegionDataPage extends StatelessWidget {
  const RegionDataPage({Key? key, this.regionId}) : super(key: key);

  final String? regionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegionDataCubit(context.read<CsRepository>())
        ..getRegionStats(regionId!)
        ..getRegionPinStats(regionId!)
        ..getRouteStats(regionId!),
      child: const RegionDataView(),
    );
  }
}

class RegionDataView extends StatelessWidget {
  const RegionDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<RegionDataCubit>().state;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              const CustomAppBar(
                title: 'Route Data',
                hasAdd: false,
              ),
              Gap(context.minBlockVertical * 3.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocBuilder<RegionDataCubit, RegionDataState>(
                        builder: (context, state) {
                          if (state.status == RegionDataStatus.loading) {
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
                                        'Routes Count',
                                        style: CsTextStyle.headline4.copyWith(),
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
                          } else if (state.status == RegionDataStatus.success) {
                            return BarChartSample2(
                              title: 'Routes Count',
                              titles: (value) {
                                return state.regionStats[value.toInt()].label!;
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
                            return Container();
                          }
                        },
                      ),
                      Gap(context.minBlockVertical * 3.0),
                      BlocBuilder<RegionDataCubit, RegionDataState>(
                        builder: (context, state) {
                          if (state.regionDataPinStatus ==
                              RegionDataPinStatus.success) {
                            return CustomPieChart(
                              title: 'Pins Grouped By Potential',
                              labels: state.pinStats.map((e) {
                                final colors = <Color>[
                                  const Color.fromRGBO(0, 171, 85, 1),
                                  const Color.fromRGBO(24, 144, 255, 1),
                                  const Color.fromRGBO(255, 193, 7, 1),
                                  const Color(0xff13d38e)
                                ];
                                final index = state.pinStats.indexWhere(
                                  (element) => element.label == e.label,
                                );
                                return Indicator(
                                  color: colors[index],
                                  text: e.label!.capitalizeFirst,
                                  isSquare: false,
                                  // textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                                );
                              }).toList(),
                              data: state.pinStats.map((e) {
                                final colors = <Color>[
                                  const Color.fromRGBO(0, 171, 85, 1),
                                  const Color.fromRGBO(24, 144, 255, 1),
                                  const Color.fromRGBO(255, 193, 7, 1),
                                  const Color(0xff13d38e)
                                ];
                                final index = state.pinStats.indexWhere(
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
                                        'Pins Grouped By Potential',
                                        style: CsTextStyle.headline4.copyWith(),
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
                      BlocBuilder<RegionDataCubit, RegionDataState>(
                        builder: (context, state) {
                          if (state.regionDataRouteStatus ==
                              RegionDataRouteStatus.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state.regionDataRouteStatus ==
                              RegionDataRouteStatus.success) {
                            return CustomDataTable(
                              length: state.routeDetails.length,
                              width: 400,
                              title: [
                                DataTableTitleTile(
                                  text: 'S/N',
                                  onPressed: () {},
                                ),
                                DataTableTitleTile(
                                  text: 'Name',
                                  width: 150,
                                  isSort: true,
                                  onPressed: () {},
                                ),
                                DataTableTitleTile(
                                  text: 'Branch',
                                  width: 200,
                                  onPressed: () {},
                                ),
                                DataTableTitleTile(
                                  text: '',
                                  width: 50,
                                  onPressed: () {},
                                ),
                              ],
                              row: (context, index) {
                                return Row(
                                  children: [
                                    ColumnTile(
                                      text: state
                                          .routeDetails[index].name!.capitalize,
                                      width: 150,
                                      isLink: true,
                                      onTap: () => context.push(
                                        '${WesyPages.routeDetails}/${state.routeDetails[index].id}',
                                      ),
                                    ),
                                    ColumnTile(
                                      text: state.routeDetails[index].routeType!
                                              .isNotEmpty
                                          ? state.routeDetails[index].routeType!
                                              .capitalizeFirst
                                          : 'N/A',
                                      width: 150,
                                    ),
                                    PopupMenuButton<String>(
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: const Text('View'),
                                            onTap: () => context.push(
                                              '${WesyPages.routeDetails}/${state.routeDetails[index].id}',
                                            ),
                                          ),
                                        ];
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        padding: const EdgeInsets.fromLTRB(
                                          5,
                                          0,
                                          0,
                                          0,
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: const Icon(Icons.more_vert),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (state.regionDataRouteStatus ==
                              RegionDataRouteStatus.failure) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
