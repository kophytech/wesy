import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wesy/region/cubit/region_cubit.dart';

extension AddDialogX on BuildContext {
  Future<void> showAddRegionDialog({
    ValueSetter<String>? onchanged,
    VoidCallback? onSubmitted,
    GlobalKey<FormState>? formKey,
  }) {
    return showDialog<void>(
      context: this,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: CsColors.white,
          contentPadding: const EdgeInsets.all(25),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          children: <Widget>[
            Text(
              'Create New Region',
              textAlign: TextAlign.center,
              style: CsTextStyle.headline4.copyWith(
                color: CsColors.black,
                fontSize: 20,
              ),
            ),
            Gap(context.minBlockVertical * 5.0),
            Form(
              key: formKey,
              child: InputBox(
                hintText: 'Name of region',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name cannot be empty';
                  }
                },
                onChanged: onchanged,
              ),
            ),
            Gap(context.minBlockVertical * 3.0),
            BlocBuilder<RegionCubit, RegionState>(
              builder: (context, state) {
                return LoaderButton(
                  text: 'Submit',
                  isLoading:
                      state.addRegionStatus == AddRegionStatus.loading || false,
                  onPressed: onSubmitted,
                );
              },
            ),
            Gap(context.minBlockVertical * 2.0),
          ],
        );
      },
    );
  }
}
