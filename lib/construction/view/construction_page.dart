import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/construction/cubit/construction_cubit.dart';

class ConstructionPage extends StatelessWidget {
  const ConstructionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConstructionCubit(context.read<CsRepository>())
        ..getAllConstructions(),
      child: const ConstructionView(),
    );
  }
}

class ConstructionView extends StatelessWidget {
  const ConstructionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ConstructionCubit, ConstructionState>(
          listener: (context, state) {
            if (state.deleteStatus == DeleteStatus.loading) {
              Future.delayed(const Duration(microseconds: 500), () {
                context.showLoadingDialog();
              });
            } else if (state.deleteStatus == DeleteStatus.success) {
              context.back();
              Future.delayed(const Duration(microseconds: 500), () {
                context.showSuccessMessage(state.successMessage);
              });
              Future.delayed(const Duration(microseconds: 1000), () {
                context.read<ConstructionCubit>().getAllConstructions();
              });
            } else if (state.deleteStatus == DeleteStatus.failure) {
              context.back();
              Future.delayed(const Duration(microseconds: 500), () {
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
                  title: l10n.constructions,
                  hasAdd: false,
                ),
                Gap(context.minBlockVertical * 3.0),
                Expanded(
                  child: BlocBuilder<ConstructionCubit, ConstructionState>(
                    builder: (context, state) {
                      if (state.status == ConstructionStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.status == ConstructionStatus.success) {
                        return CustomDataTable(
                          length: state.constructions.length,
                          width: 300,
                          title: [
                            DataTableTitleTile(
                              text: l10n.sn,
                              onPressed: () {},
                            ),
                            DataTableTitleTile(
                              text: l10n.route,
                              width: 150,
                              onPressed: () {},
                            ),
                            DataTableTitleTile(
                              text: l10n.city,
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
                                  text: state.constructions[index].route!.name!,
                                  width: 150,
                                  isLink: true,
                                  onTap: () => context.push(
                                    '${WesyPages.pinDetails}/${state.constructions[index].id}',
                                  ),
                                ),
                                ColumnTile(
                                  text:
                                      state.constructions[index].city ?? 'N/A',
                                ),
                                PopupMenuButton<String>(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: Text(l10n.view),
                                        onTap: () => context.push(
                                          '${WesyPages.pinDetails}/${state.constructions[index].id}',
                                        ),
                                      ),
                                      PopupMenuItem(
                                        child: Text(l10n.delete),
                                        onTap: () {
                                          context.back();
                                          Future.delayed(
                                              const Duration(microseconds: 500),
                                              () {
                                            context.showDeleteDialog(
                                              '${l10n.delete_pin}?',
                                              l10n.delete_msg,
                                              () => context
                                                  .read<ConstructionCubit>()
                                                  .deleteConstruction(
                                                    pinId: state
                                                        .constructions[index]
                                                        .id,
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
                                    alignment: Alignment.centerRight,
                                    child: const Icon(Icons.more_vert),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (state.status == ConstructionStatus.failure) {
                        return CustomDataTable(
                          length: state.constructions.length,
                          width: 300,
                          title: [
                            DataTableTitleTile(
                              text: l10n.sn,
                              onPressed: () {},
                            ),
                            DataTableTitleTile(
                              text: l10n.route,
                              width: 150,
                              onPressed: () {},
                            ),
                            DataTableTitleTile(
                              text: l10n.city,
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
