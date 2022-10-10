import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/src/extension/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/industry/cubit/industry_cubit.dart';

class IndustryPage extends StatelessWidget {
  const IndustryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          IndustryCubit(context.read<CsRepository>())..getAllIndustries(),
      child: const IndustryView(),
    );
  }
}

class IndustryView extends StatelessWidget {
  const IndustryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<IndustryCubit, IndustryState>(
          listener: (context, state) {
            if (state.deleteStatus == DeleteStatus.loading) {
              context.back();
              Future.delayed(const Duration(microseconds: 500), () {
                context.showLoadingDialog();
              });
            } else if (state.deleteStatus == DeleteStatus.success) {
              context.back();
              Future.delayed(const Duration(microseconds: 500), () {
                context.showSuccessMessage(state.successMessage);
              });
              Future.delayed(const Duration(microseconds: 1000), () {
                context.read<IndustryCubit>().getAllIndustries();
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
                  title: l10n.industries,
                  hasAdd: false,
                ),
                Gap(context.minBlockVertical * 3.0),
                Expanded(
                  child: BlocBuilder<IndustryCubit, IndustryState>(
                    builder: (context, state) {
                      if (state.status == IndustryStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.status == IndustryStatus.success) {
                        return CustomDataTable(
                          length: state.industries.length,
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
                                  text: state.industries[index].route!.name!,
                                  width: 150,
                                  isLink: true,
                                  onTap: () => context.push(
                                    '${WesyPages.pinDetails}/${state.industries[index].id}',
                                  ),
                                ),
                                ColumnTile(
                                  text: state.industries[index].city ?? 'N/A',
                                ),
                                PopupMenuButton<String>(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: Text(l10n.view),
                                        onTap: () => context.push(
                                          '${WesyPages.pinDetails}/${state.industries[index].id}',
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
                                                  .read<IndustryCubit>()
                                                  .deleteIndustry(
                                                    pinId: state
                                                        .industries[index].id,
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
                      } else if (state.status == IndustryStatus.failure) {
                        return CustomDataTable(
                          length: state.industries.length,
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
