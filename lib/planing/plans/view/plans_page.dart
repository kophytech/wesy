import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/planing/planing.dart';
import 'package:wesy/planing/plans/cubit/plans_cubit.dart';

class PlansPage extends StatelessWidget {
  const PlansPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlansCubit>(
      create: (context) =>
          PlansCubit(csRepository: context.read<CsRepository>())
            ..deviceTokenUpdated(
              context.read<AppBloc>().state.deviceToken,
            )
            ..getSchedules(),
      child: PlansView(),
    );
  }
}

class PlansView extends StatelessWidget {
  PlansView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<PlansCubit, PlansState>(
          listener: (context, state) {
            if (state.planStatus == PlanStatus.loading) {
              context.showLoadingDialog();
            } else if (state.planStatus == PlanStatus.success) {
              context.back();
              Future.delayed(
                const Duration(milliseconds: 30),
                () => context.showSuccessMessage(state.successMessage),
              );
            } else if (state.planStatus == PlanStatus.failure) {
              context.back();
              Future.delayed(
                const Duration(milliseconds: 30),
                () => context.showErrorMessage(state.errorMessage),
              );
            }
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: CustomAppBar(
                  title: l10n.my_plan,
                  onAddPressed: () {
                    context.addNewPlanDialog(
                      titleController: titleController,
                      noteController: noteController,
                      endDateController: endDateController,
                      startDateController: startDateController,
                      formKey: _formKey,
                      onSubmitted: (startDate, endDate, title, note) {
                        context.back();
                        context.read<PlansCubit>().updateSchedule(
                              Schedule(
                                title: title,
                                startDate: startDate,
                                endDate: endDate,
                                notes: note,
                                allDay: false,
                              ),
                            );
                        context.read<PlansCubit>().onDataChanged(
                              startDate: startDate,
                              endDate: endDate,
                              note: note,
                              title: title,
                            );
                        context.read<PlansCubit>().createPlan();
                      },
                    );
                  },
                ),
              ),
              Gap(context.minBlockVertical),
              Expanded(
                child: BlocBuilder<PlansCubit, PlansState>(
                  builder: (context, state) {
                    if (state.getPlanStatus == GetPlanStatus.success) {
                      return SfCalendar(
                        view: CalendarView.month,
                        dataSource: PlanDataSource(state.schedules),
                        monthViewSettings: const MonthViewSettings(
                          appointmentDisplayMode:
                              MonthAppointmentDisplayMode.appointment,
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
