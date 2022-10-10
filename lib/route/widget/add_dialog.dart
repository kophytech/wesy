import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:wesy/route/cubit/route_cubit.dart';

extension AddDialogX on BuildContext {
  Future<void> showAddRouteDialog({
    Key? key,
    VoidCallback? onSubmitted,
    GlobalKey<FormState>? formKey,
    bool isAdmin = false,
  }) {
    final l10n = AppLocalizations.of(this)!;
    return showDialog<void>(
      context: this,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          key: key ?? const Key('0'),
          backgroundColor: CsColors.white,
          // contentPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          children: <Widget>[
            Text(
              l10n.create_route,
              textAlign: TextAlign.center,
              style: CsTextStyle.headline4.copyWith(
                color: CsColors.black,
                fontSize: 20,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    InputBox(
                      hintText: l10n.route_name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name cannot be empty';
                        }
                        return null;
                      },
                      onChanged: context.read<RouteCubit>().onRouteNameChanged,
                    ),
                    Gap(context.minBlockVertical * 3.0),
                    BlocBuilder<RouteCubit, RouteState>(
                      builder: (context, state) {
                        return SelectBox<String>(
                          value: state.branch,
                          onChanged: (value) => context
                              .read<RouteCubit>()
                              .onBranchChanged(value!),
                          items: [
                            DropdownMenuItem(
                              value: '',
                              child: Text(l10n.select_branch),
                            ),
                            DropdownMenuItem(
                              value: 'construction',
                              child: Text(l10n.construction),
                            ),
                            DropdownMenuItem(
                              value: 'store',
                              child: Text(l10n.store),
                            ),
                            DropdownMenuItem(
                              value: 'industry',
                              child: Text(l10n.industry),
                            ),
                          ],
                          validator: (dynamic value) {
                            if (value.toString().isEmpty) {
                              return 'Branch cannot be empty';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    Gap(context.minBlockVertical * 3.0),
                    if (!isAdmin) ...[
                      BlocBuilder<RouteCubit, RouteState>(
                        builder: (context, state) {
                          if (state.regions.isNotEmpty) {
                            return SelectBox<String>(
                              value: state.region,
                              onChanged: (value) => context
                                  .read<RouteCubit>()
                                  .onRegionNameChanged(value!),
                              items: state.regions.map((e) {
                                return DropdownMenuItem(
                                  value: e.id ?? '',
                                  child: Text(e.name ?? 'N/A'),
                                );
                              }).toList(),
                              validator: (dynamic value) {
                                if (value.toString().isEmpty) {
                                  return 'Region cannot be empty';
                                }
                                return null;
                              },
                            );
                          } else {
                            return SelectBox(
                              value: '',
                              onChanged: (value) {},
                              items: const [
                                DropdownMenuItem(
                                  value: '',
                                  child: Text('No Region Available'),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      Gap(context.minBlockVertical * 3.0),
                    ],
                    BlocBuilder<RouteCubit, RouteState>(
                      builder: (context, state) {
                        return LoaderButton(
                          text: l10n.submit,
                          isLoading:
                              state.addRouteStatus == AddRouteStatus.loading ||
                                  false,
                          onPressed: onSubmitted,
                        );
                      },
                    ),
                    Gap(context.minBlockVertical * 2.0),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
