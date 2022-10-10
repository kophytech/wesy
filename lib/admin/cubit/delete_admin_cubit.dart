import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_admin_state.dart';

class DeleteAdminCubit extends Cubit<DeleteAdminState> {
  DeleteAdminCubit() : super(DeleteAdminInitial());
}
