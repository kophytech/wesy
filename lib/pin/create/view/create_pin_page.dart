import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/pin/create/cubit/create_pin_cubit.dart';
import 'package:wesy/route_detail/cubit/route_detail_cubit.dart';

class CreatePinPage extends StatelessWidget {
  const CreatePinPage({
    Key? key,
    required this.routeId,
    required this.routeType,
  }) : super(key: key);

  final String routeId;
  final String routeType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreatePinCubit(context.read<CsRepository>())..onGetRouteId(routeId),
      child: CreatePinView(
        routeType: routeType,
      ),
    );
  }
}

class CreatePinView extends StatelessWidget {
  CreatePinView({Key? key, required this.routeType}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final String routeType;

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppBloc>().state;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<CreatePinCubit, CreatePinState>(
          listener: (context, state) {
            if (state.status == CreatePinStatus.loading) {
              context.showLoadingDialog();
            } else if (state.status == CreatePinStatus.failure) {
              context.back();
              Future.delayed(const Duration(microseconds: 40), () {
                context.showErrorMessage(state.errorMessage);
              });
            } else if (state.status == CreatePinStatus.success) {
              context.back();
              context.read<RouteDetailCubit>().updateLocationPin(state.pin);
              Future.delayed(const Duration(microseconds: 40), () {
                context.showSuccessMessage(state.successMessage);
              });
              Future.delayed(const Duration(microseconds: 1510), () {
                context.back();
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: l10n.create_pin,
                  hasAdd: false,
                ),
                Gap(context.minBlockVertical * 3.0),
                BlocBuilder<CreatePinCubit, CreatePinState>(
                  builder: (context, state) {
                    if (!state.hasLocation) {
                      return GestureDetector(
                        onTap: () {
                          context.read<CreatePinCubit>().onGetCurrentLocation();
                          Future.delayed(const Duration(milliseconds: 50), () {
                            context.read<CreatePinCubit>().onHasLocation(true);
                          });
                        },
                        child: Chip(
                          label: Text(l10n.current_location),
                          avatar: const Icon(
                            Icons.location_on,
                            color: CsColors.primary,
                          ),
                          backgroundColor: CsColors.white,
                          side: const BorderSide(color: Color(0xFFC5C8CB)),
                        ),
                      );
                    }
                    return Chip(
                      label: Text(
                        '${state.currentLocation.latitude} ${state.currentLocation.longitude}',
                      ),
                      deleteButtonTooltipMessage:
                          'Note: This is your current coordinate',
                      backgroundColor: CsColors.white,
                      side: const BorderSide(color: Color(0xFFC5C8CB)),
                      onDeleted: () =>
                          context.read<CreatePinCubit>().onHasLocation(false),
                    );
                  },
                ),
                Gap(context.minBlockVertical * 3.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputBox(
                            hintText: l10n.name_of_pin,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Name cannot be empty';
                            //   }
                            //   return null;
                            // },
                            onChanged:
                                context.read<CreatePinCubit>().onNameChanged,
                          ),
                          Gap(context.minBlockVertical * 3.0),
                          InputBox(
                            hintText: l10n.address,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Address cannot be empty';
                            //   }
                            //   return null;
                            // },
                            onChanged:
                                context.read<CreatePinCubit>().onAddressChanged,
                          ),
                          Gap(context.minBlockVertical * 3.0),
                          InputBox(
                            hintText: l10n.city,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'City cannot be empty';
                            //   }
                            //   return null;
                            // },
                            onChanged:
                                context.read<CreatePinCubit>().onCityChanged,
                          ),
                          Gap(context.minBlockVertical * 3.0),
                          InputBox(
                            hintText: l10n.postal_code,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Postal Code cannot be empty';
                            //   }
                            //   return null;
                            // },
                            inputType: TextInputType.number,
                            onChanged: context
                                .read<CreatePinCubit>()
                                .onPostalCodeChanged,
                          ),
                          Gap(context.minBlockVertical * 3.0),
                          InputBox(
                            hintText: l10n.company,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Company cannot be empty';
                            //   }
                            //   return null;
                            // },
                            onChanged:
                                context.read<CreatePinCubit>().onCompanyChanged,
                          ),
                          Gap(context.minBlockVertical * 3.0),
                          BlocBuilder<CreatePinCubit, CreatePinState>(
                            builder: (context, state) {
                              return SelectBox<String>(
                                value: state.potential,
                                onChanged: (value) => context
                                    .read<CreatePinCubit>()
                                    .onPotentialChanged(value!),
                                items: [
                                  DropdownMenuItem(
                                    value: '',
                                    child: Text(l10n.select_potential),
                                  ),
                                  DropdownMenuItem(
                                    value: 'low',
                                    child: Text(l10n.potential_low),
                                  ),
                                  DropdownMenuItem(
                                    value: 'medium',
                                    child: Text(l10n.potential_medium),
                                  ),
                                  DropdownMenuItem(
                                    value: 'high',
                                    child: Text(l10n.potential_high),
                                  ),
                                ],
                                // validator: (dynamic value) {
                                //   if (value.toString().isEmpty) {
                                //     return 'Potential cannot be empty';
                                //   }
                                //   return null;
                                // },
                              );
                            },
                          ),
                          BlocBuilder<CreatePinCubit, CreatePinState>(
                            builder: (context, state) {
                              if (routeType.toLowerCase() == 'construction') {
                                return Column(
                                  children: [
                                    Gap(context.minBlockVertical * 3.0),
                                    DateInputBox(
                                      hintText: l10n.start_date,
                                      // validator: (DateTime? e) {
                                      //   if (e.toString().isEmpty) {
                                      //     return 'Start date cannot be empty';
                                      //   }
                                      //   return null;
                                      // },
                                      onChanged: (value) {
                                        context
                                            .read<CreatePinCubit>()
                                            .onEndDateChanged(
                                              value.toIso8601String(),
                                            );
                                      },
                                    ),
                                    Gap(context.minBlockVertical * 3.0),
                                    DateInputBox(
                                      hintText: l10n.finish_date,
                                      // validator: (DateTime? e) {
                                      //   if (e.toString().isEmpty) {
                                      //     return 'Finish date cannot be empty';
                                      //   }
                                      //   return null;
                                      // },
                                      onChanged: (value) {
                                        context
                                            .read<CreatePinCubit>()
                                            .onStartDateChanged(
                                              value.toIso8601String(),
                                            );
                                      },
                                    ),
                                    Gap(context.minBlockVertical * 3.0),
                                    SelectBox<String>(
                                      value: '',
                                      onChanged: (value) => context
                                          .read<CreatePinCubit>()
                                          .onConstructionPhaseChanged(value!),
                                      items: [
                                        DropdownMenuItem(
                                          value: '',
                                          child: Text(l10n.construction_phase),
                                        ),
                                        const DropdownMenuItem(
                                          value: 'A',
                                          child: Text('A'),
                                        ),
                                        const DropdownMenuItem(
                                          value: 'B',
                                          child: Text('B'),
                                        ),
                                        const DropdownMenuItem(
                                          value: 'G',
                                          child: Text('G'),
                                        ),
                                      ],
                                      // validator: (dynamic value) {
                                      //   if (value.toString().isEmpty) {
                                      //     return 'Construction phase cannot be empty';
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                    Gap(context.minBlockVertical * 3.0),
                                    BlocBuilder<CreatePinCubit, CreatePinState>(
                                      builder: (context, state) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            PinCheckBox(
                                              text: 'E',
                                              value:
                                                  state.branches.contains('E'),
                                              onChanged: (value) => context
                                                  .read<CreatePinCubit>()
                                                  .onBranchesChanged('E'),
                                            ),
                                            PinCheckBox(
                                              text: 'H',
                                              value:
                                                  state.branches.contains('H'),
                                              onChanged: (value) => context
                                                  .read<CreatePinCubit>()
                                                  .onBranchesChanged('H'),
                                            ),
                                            PinCheckBox(
                                              text: 'S',
                                              value:
                                                  state.branches.contains('S'),
                                              onChanged: (value) => context
                                                  .read<CreatePinCubit>()
                                                  .onBranchesChanged('S'),
                                            ),
                                            PinCheckBox(
                                              text: 'MG',
                                              value:
                                                  state.branches.contains('MG'),
                                              onChanged: (value) => context
                                                  .read<CreatePinCubit>()
                                                  .onBranchesChanged('MG'),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }
                              return Container();
                            },
                          ),
                          Gap(context.minBlockVertical * 3.0),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<CreatePinCubit, CreatePinState>(
                  builder: (context, state) {
                    return SolidButton(
                      text: l10n.submit,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if ((state.currentLocation.latitude == 0 &&
                                  state.currentLocation.longitude == 0) ||
                              !state.hasLocation) {
                            return context.showErrorMessage(
                              'GPS coordinate is required to display the pin on the map',
                            );
                          }
                          context.read<CreatePinCubit>().createPin(routeType);
                        }
                      },
                    );
                  },
                ),
                Gap(context.minBlockVertical * 2.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PinCheckBox extends StatelessWidget {
  const PinCheckBox({
    Key? key,
    required this.text,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  final String text;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text),
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
