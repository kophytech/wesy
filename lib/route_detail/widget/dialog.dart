import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:wesy/route_detail/cubit/route_detail_cubit.dart';

extension AddDialogX on BuildContext {
  Future<void> showWorkersDialog({
    Key? key,
    CsRepository? csRepository,
    String? region,
    String? routeId,
    List<Worker>? availableWorkers,
    VoidCallback? onPressed,
  }) {
    final l10n = AppLocalizations.of(this)!;
    //getWorkers(region: region)
    return showDialog<void>(
      context: this,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          key: key ?? const Key('0'),
          backgroundColor: CsColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          children: <Widget>[
            Text(
              l10n.select_worker,
              style: CsTextStyle.headline4.copyWith(
                fontWeight: CsFontWeight.bold,
              ),
            ),
            Gap(context.minBlockVertical * 2.0),
            BlocBuilder<RouteDetailCubit, RouteDetailState>(
              builder: (context, state) {
                if (state.getWorkerStatus == GetWorkerStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.getWorkerStatus == GetWorkerStatus.success) {
                  final newWorkers = <Worker>[];
                  for (final element in state.workers) {
                    final hasWorker = availableWorkers!.where(
                      (worker) => worker.id!.trim() == element.id!.trim(),
                    );
                    if (hasWorker.isEmpty) {
                      newWorkers.add(element);
                    }
                  }
                  return Column(
                    children: List.generate(
                      newWorkers.length,
                      (index) {
                        return ListTile(
                          leading: Checkbox(
                            value: state.workersId.isNotEmpty &&
                                state.workersId.contains(newWorkers[index].id),
                            onChanged: (value) {
                              context
                                  .read<RouteDetailCubit>()
                                  .onWorkerIdChanged(
                                    newWorkers[index].id!,
                                  );
                            },
                          ),
                          title: Text(
                            '${newWorkers[index].firstName} ${newWorkers[index].lastName}',
                            style: CsTextStyle.bodyText1.copyWith(
                              fontWeight: CsFontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            newWorkers[index].email!,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'No worker available in region',
                      style: CsTextStyle.bodyText2,
                    ),
                  );
                }
              },
            ),
            Gap(context.minBlockVertical * 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: back,
                  child: Text(
                    l10n.cancel,
                    style: CsTextStyle.headline5.copyWith(
                      fontWeight: CsFontWeight.semiBold,
                      fontSize: 20,
                      color: CsColors.danger,
                    ),
                  ),
                ),
                BlocBuilder<RouteDetailCubit, RouteDetailState>(
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        back();
                        Future.delayed(const Duration(milliseconds: 20), () {
                          showLoadingDialog();
                          BlocProvider.of<RouteDetailCubit>(context)
                              .workerSubmitted(
                            routeId: routeId,
                          )
                              .then((value) {
                            back();
                            if (value) {
                              showSuccessMessage('Worker added successfully');
                              Future.delayed(const Duration(milliseconds: 20),
                                  () {
                                read<RouteDetailCubit>()
                                    .getRouteDetails(routeId: routeId);
                              });
                            } else {
                              showErrorMessage('Unable to add worker');
                            }
                          });
                        });
                      },
                      child: Text(
                        'Ok',
                        style: CsTextStyle.headline5.copyWith(
                          fontWeight: CsFontWeight.semiBold,
                          fontSize: 20,
                          color: CsColors.primary,
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
