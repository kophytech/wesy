import 'package:cs_ui/cs_ui.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wesy/users/cubit/users_cubit.dart';
import 'package:wesy/users/models/user_model.dart';

class UsersDropDown extends StatelessWidget {
  const UsersDropDown({
    Key? key,
    required this.users,
    required this.usersCubit,
    required this.onchanged,
    this.labelText = 'Choose Recipients',
  }) : super(key: key);

  final List<UserModel> users;
  final UsersCubit usersCubit;
  final String labelText;
  final ValueChanged<List<UserModel>> onchanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      bloc: usersCubit,
      builder: (context, state) {
        return DropdownSearch<UserModel>.multiSelection(
          mode: Mode.MENU,
          items: users,
          showSelectedItems: true,
          showClearButton: true,
          showSearchBox: true,
          isFilteredOnline: true,
          itemAsString: (UserModel? u) => u?.farmerAsString() ?? '',
          filterFn: (farmer, filter) =>
              farmer!.farmerFilterByName(filter ?? ''),
          compareFn: (item, selectedItem) =>
              item?.userId == selectedItem?.userId,
          dropdownBuilder: _selectedItemBuilder,
          popupItemBuilder: _itemBuilder,
          popupSafeArea: const PopupSafeAreaProps(top: true, bottom: true),
          // scrollbarProps: const ScrollbarProps(
          //   isAlwaysShown: true,
          //   thickness: 7,
          // ),
          dropdownSearchDecoration: InputDecoration(
            hintStyle: CsTextStyle.caption.copyWith(
              color: CsColors.black.withOpacity(0.5),
            ),
            filled: true,
            fillColor: CsColors.white,
            labelStyle: CsTextStyle.caption.copyWith(
              color: CsColors.black.withOpacity(0.5),
            ),
            labelText: labelText,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
              borderSide: const BorderSide(color: CsColors.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
              borderSide: BorderSide(
                color: CsColors.black.withOpacity(0.3),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
              borderSide: BorderSide(
                color: CsColors.black.withOpacity(0.3),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
          ),
          onChanged: onchanged,
        );
      },
    );
  }

  Widget _selectedItemBuilder(
    BuildContext context,
    List<UserModel?> selectedItems,
  ) {
    if (selectedItems.isEmpty) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(labelText),
      );
    }
    return Wrap(
      children: selectedItems.map((e) {
        return Padding(
          padding: const EdgeInsets.all(4),
          child: UserCard(
            fullName: e!.fullName.toString(),
            userId: e.userId.toString(),
          ),
        );
      }).toList(),
    );
  }

  Widget _itemBuilder(
    BuildContext context,
    UserModel? item,
    bool isSelected,
  ) {
    return UserCard(
      fullName: item!.fullName.toString(),
      userId: item.userId.toString(),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.fullName,
    required this.userId,
  }) : super(key: key);

  final String fullName;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        fullName,
        style: CsTextStyle.bodyText2.copyWith(),
      ),
    );
  }
}
