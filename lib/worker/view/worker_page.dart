import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/worker/cubit/worker_cubit.dart';

class WorkerPage extends StatelessWidget {
  const WorkerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const WorkerView();
  }
}

class WorkerView extends StatefulWidget {
  const WorkerView({Key? key}) : super(key: key);

  @override
  State<WorkerView> createState() => _WorkerViewState();
}

class _WorkerViewState extends State<WorkerView> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<WorkerCubit>().getAllWorkers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<WorkerCubit, WorkerState>(
          listener: (context, state) {
            if (state.deleteStatus == DeleteStatus.loading) {
              context.back();
              Future.delayed(const Duration(microseconds: 20), () {
                context.showLoadingDialog();
              });
            } else if (state.deleteStatus == DeleteStatus.success) {
              context.back();
              Future.delayed(const Duration(microseconds: 20), () {
                context.showSuccessMessage(state.successMessage);
                context.read<WorkerCubit>().deleteInital();
              });
              Future.delayed(const Duration(microseconds: 2000), () {
                context.read<WorkerCubit>().getAllWorkers();
              });
            } else if (state.deleteStatus == DeleteStatus.failure) {
              context.back();
              Future.delayed(const Duration(microseconds: 20), () {
                context.showErrorMessage(state.errorMessage);
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                CustomAppBar(
                  title: l10n.worker,
                  onAddPressed: () => context.push(WesyPages.addWorker),
                ),
                Gap(context.minBlockVertical * 3.0),
                Expanded(
                  child: BlocBuilder<WorkerCubit, WorkerState>(
                    builder: (context, state) {
                      if (state.status == WorkerStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.status == WorkerStatus.success) {
                        return CustomDataTable(
                          length: state.workers.length,
                          width: 600,
                          title: [
                            DataTableTitleTile(
                              text: l10n.sn,
                              onPressed: () {},
                            ),
                            DataTableTitleTile(
                              text: l10n.name,
                              width: 150,
                              onPressed: () {},
                            ),
                            DataTableTitleTile(
                              text: l10n.email,
                              width: 150,
                              onPressed: () {},
                            ),
                            DataTableTitleTile(
                              text: l10n.region,
                              onPressed: () {},
                            ),
                            DataTableTitleTile(
                              text: l10n.role,
                              onPressed: () {},
                            ),
                            const DataTableTitleTile(
                              text: '',
                            ),
                          ],
                          row: (context, index) {
                            return Row(
                              children: [
                                ColumnTile(
                                  text:
                                      '${state.workers[index].firstName} ${state.workers[index].lastName}',
                                  width: 150,
                                ),
                                ColumnTile(
                                  text: state.workers[index].email ?? 'N/A',
                                  width: 200,
                                ),
                                ColumnTile(
                                  text: state.workers[index].region != null
                                      ? state.workers[index].region!.name!
                                      : 'N/A',
                                ),
                                ColumnTile(
                                  text: state.workers[index].roles!.isNotEmpty
                                      ? state.workers[index].roles!.last
                                      : 'N/A',
                                ),
                                PopupMenuButton<String>(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: Text(l10n.edit),
                                        onTap: () => context.push(
                                          '${WesyPages.editWorker}/${state.workers[index].id}',
                                        ),
                                      ),
                                      PopupMenuItem(
                                        child: Text(l10n.delete),
                                        onTap: () {
                                          context.back();
                                          Future.delayed(
                                              const Duration(
                                                microseconds: 500,
                                              ), () {
                                            context.showDeleteDialog(
                                              '${l10n.delete} worker?',
                                              l10n.delete_msg,
                                              () => context
                                                  .read<WorkerCubit>()
                                                  .deleteWorker(
                                                    id: state.workers[index].id,
                                                  ),
                                            );
                                          });
                                        },
                                      )
                                    ];
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    alignment: Alignment.centerLeft,
                                    child: const Icon(Icons.more_vert),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (state.status == WorkerStatus.failure) {
                        return CustomDataTable(
                          length: state.workers.length,
                          width: 600,
                          title: [
                            DataTableTitleTile(
                              text: l10n.sn,
                              onPressed: () {},
                            ),
                            DataTableTitleTile(
                              text: l10n.name,
                              onPressed: () {},
                            ),
                            DataTableTitleTile(
                              text: l10n.email,
                              onPressed: () {},
                            ),
                            DataTableTitleTile(
                              text: l10n.region,
                              onPressed: () {},
                            ),
                            DataTableTitleTile(
                              text: l10n.role,
                              onPressed: () {},
                            ),
                          ],
                          row: (context, index) {
                            return Container();
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
