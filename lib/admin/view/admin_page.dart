import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wesy/admin/cubit/admin_cubit.dart';
import 'package:wesy/app/app.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AdminView();
  }
}

class AdminView extends StatefulWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AdminCubit>().getAllAdmins();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AdminCubit, AdminState>(
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
                context.read<AdminCubit>().deleteInital();
              });
              Future.delayed(const Duration(microseconds: 1510), () {
                context.read<AdminCubit>().getAllAdmins();
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
                  title: l10n.admins,
                  onAddPressed: () => context.push(WesyPages.addAdmin),
                ),
                Gap(context.minBlockVertical * 3.0),
                Expanded(
                  child: BlocBuilder<AdminCubit, AdminState>(
                    builder: (context, state) {
                      if (state.status == AdminStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.status == AdminStatus.success) {
                        return CustomDataTable(
                          length: state.admins.length,
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
                              width: 200,
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
                                      '${state.admins[index].firstName}  ${state.admins[index].lastName}',
                                  width: 150,
                                ),
                                ColumnTile(
                                  text: state.admins[index].email ?? 'N/A',
                                  width: 200,
                                ),
                                ColumnTile(
                                  text: state.admins[index].region != null
                                      ? state.admins[index].region!.name!
                                      : 'N/A',
                                ),
                                ColumnTile(
                                  text: state.admins[index].roles!.isNotEmpty
                                      ? state.admins[index].roles!.last
                                      : 'N/A',
                                ),
                                PopupMenuButton<String>(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: Text(l10n.edit),
                                        onTap: () => context.push(
                                          '${WesyPages.editAdmin}/${state.admins[index].id}',
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
                                              '${l10n.delete} ${l10n.admin}?',
                                              l10n.delete_msg,
                                              () => context
                                                  .read<AdminCubit>()
                                                  .deleteAdmin(
                                                    id: state.admins[index].id,
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
                      } else if (state.status == AdminStatus.failure) {
                        return CustomDataTable(
                          length: state.admins.length,
                          width: 600,
                          title: [
                            DataTableTitleTile(
                              text: l10n.sn,
                              onPressed: () {},
                            ),
                            DataTableTitleTile(
                              text: l10n.name,
                              width: 150,
                              isSort: true,
                              onPressed: () {},
                            ),
                            DataTableTitleTile(
                              text: l10n.email,
                              width: 200,
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
