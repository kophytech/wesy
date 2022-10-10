import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:wesy/users/users.dart';

part 'broadcast_state.dart';

class BroadcastCubit extends Cubit<BroadcastState> {
  BroadcastCubit(this.csRepository) : super(const BroadcastState());

  final CsRepository csRepository;

  void onTitleChanged(String title) {
    emit(state.copyWith(title: title));
    validate();
  }

  void onStartDateChanged(String date) {
    emit(state.copyWith(startDate: date));
    validate();
  }

  void onEndDateChanged(String date) {
    emit(state.copyWith(endDate: date));
    validate();
  }

  void onNoteChanged(String note) {
    emit(state.copyWith(note: note));
    validate();
  }

  void validate() {
    if (state.title.isNotEmpty &&
        state.startDate.isNotEmpty &&
        state.endDate.isNotEmpty &&
        state.note.isNotEmpty &&
        state.recipients.isNotEmpty) {
      emit(state.copyWith(buttonEnabled: true));
    } else {
      emit(state.copyWith(buttonEnabled: false));
    }
  }

  void onRecipientsChanged(List<UserModel> recipients) {
    final users = <String>[];
    for (final recipient in recipients) {
      users.add(recipient.userId ?? '');
    }
    emit(state.copyWith(recipients: users));
    validate();
  }

  Future<void> onSubmitted() async {
    try {
      emit(state.copyWith(status: BroadcastStatus.loading));
      print(state.recipients);
      final response = await csRepository.addBroadcast(
        title: state.title,
        startDate: state.startDate,
        endDate: state.endDate,
        note: state.note,
        users: state.recipients,
      );
      emit(
        state.copyWith(
          status: BroadcastStatus.success,
          successMessage: response.message,
        ),
      );
    } on AdminFailure {
      emit(
        state.copyWith(
          status: BroadcastStatus.error,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on AdminRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: BroadcastStatus.error,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: BroadcastStatus.error,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }
}
