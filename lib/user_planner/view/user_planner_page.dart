import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:wesy/app/app.dart';
import 'package:wesy/planing/planing.dart';
import 'package:wesy/user_planner/cubit/planing_cubit.dart';

class UserPlannerPage extends StatelessWidget {
  const UserPlannerPage({Key? key, this.id}) : super(key: key);

  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PlaningCubit(csRepository: context.read<CsRepository>())
            ..updateUserId(id!)
            ..getSchedules(),
      child: UserPlannerView(),
    );
  }
}

class UserPlannerView extends StatelessWidget {
  UserPlannerView({Key? key}) : super(key: key);

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
        child: BlocListener<PlaningCubit, PlaningState>(
          listener: (context, state) {
            if (state.planStatus == PlanningStatus.loading) {
              context.showLoadingDialog();
            } else if (state.planStatus == PlanningStatus.success) {
              context.back();
              Future.delayed(
                const Duration(milliseconds: 30),
                () => context.showSuccessMessage(state.successMessage),
              );
            } else if (state.planStatus == PlanningStatus.failure) {
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
                  title: l10n.user_plan2,
                  onAddPressed: () {
                    context.addNewPlanDialog(
                      formKey: _formKey,
                      titleController: titleController,
                      startDateController: startDateController,
                      endDateController: endDateController,
                      noteController: noteController,
                      onSubmitted: (startDate, endDate, title, note) {
                        context.back();
                        context.read<PlaningCubit>().updateSchedule(
                              Schedule(
                                title: title,
                                startDate: startDate,
                                endDate: endDate,
                                notes: note,
                                allDay: false,
                              ),
                            );
                        context.read<PlaningCubit>().onDataChanged(
                              startDate: startDate,
                              endDate: endDate,
                              note: note,
                              title: title,
                            );
                        context.read<PlaningCubit>().createPlan();
                      },
                    );
                  },
                ),
              ),
              Gap(context.minBlockVertical * 3.0),
              Expanded(
                child: BlocBuilder<PlaningCubit, PlaningState>(
                  builder: (context, state) {
                    if (state.getPlanStatus == GetPlanningStatus.success) {
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
