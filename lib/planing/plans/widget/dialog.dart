import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

typedef OnEventAdd = Function(
  String startDate,
  String endDate,
  String title,
  String note,
);

extension AddDialogX on BuildContext {
  Future<void> addNewPlanDialog({
    Key? key,
    OnEventAdd? onSubmitted,
    TextEditingController? titleController,
    TextEditingController? startDateController,
    TextEditingController? endDateController,
    TextEditingController? noteController,
    GlobalKey<FormState>? formKey,
  }) {
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
              'New Plan',
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
                      hintText: 'Title',
                      // controller: titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Title cannot be empty';
                        }
                      },
                      onChanged: (value) {
                        titleController!.text = value;
                      },
                    ),
                    Gap(context.minBlockVertical * 2.0),
                    DateInputBox(
                      hintText: 'Start Date',
                      controller: startDateController,
                      mode: DateInputMode.datetime,
                      validator: (DateTime? e) => (e?.day ?? 0) == 1
                          ? 'Please not the first day'
                          : null,
                      onChanged: (value) {
                        startDateController!.text = value.toIso8601String();
                      },
                    ),
                    Gap(context.minBlockVertical * 2.0),
                    DateInputBox(
                      hintText: 'End Date',
                      mode: DateInputMode.datetime,
                      controller: endDateController,
                      validator: (DateTime? e) => (e?.day ?? 0) == 1
                          ? 'Please not the first day'
                          : null,
                      onChanged: (value) {
                        endDateController!.text = value.toIso8601String();
                      },
                    ),
                    Gap(context.minBlockVertical * 2.0),
                    TextArea(
                      // controller: noteController,
                      onChanged: (value) {
                        noteController!.text = value;
                      },
                      hintText: 'Note',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Note cannot be empty';
                        }
                      },
                    ),
                    Gap(context.minBlockVertical * 3.0),
                    LoaderButton(
                      text: 'Submit',
                      onPressed: () {
                        if (formKey!.currentState!.validate()) {
                          onSubmitted!(
                            startDateController!.text,
                            endDateController!.text,
                            titleController!.text,
                            noteController!.text,
                          );
                        }
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
