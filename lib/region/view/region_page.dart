import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wesy/app/app_router.dart';
import 'package:wesy/home/bloc/home_bloc.dart';
import 'package:wesy/region/cubit/region_cubit.dart';
import 'package:wesy/region/region.dart';

class RegionPage extends StatelessWidget {
  const RegionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RegionView();
  }
}

class RegionView extends StatefulWidget {
  const RegionView({Key? key}) : super(key: key);

  @override
  State<RegionView> createState() => _RegionViewState();
}

class _RegionViewState extends State<RegionView> {
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RegionCubit>().getAllRegions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final home = context.read<HomeBloc>().state;
    return BlocListener<RegionCubit, RegionState>(
      listener: (context, state) {
        if (state.addRegionStatus == AddRegionStatus.success) {
          context.back();
          Future.delayed(const Duration(microseconds: 500), () {
            context.showSuccessMessage(state.successMessage);
          });
        } else if (state.addRegionStatus == AddRegionStatus.failure) {
          context.back();
          Future.delayed(const Duration(microseconds: 500), () {
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
            Row(
              children: [
                InkResponse(
                  onTap: () => home.scaffoldKey!.currentState!.openDrawer(),
                  child: SvgPicture.asset(
                    'assets/svgs/drawer.svg',
                    color: CsColors.primary,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'All Regions',
                      style: CsTextStyle.bigText.copyWith(
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => context.showAddRegionDialog(
                    formKey: _formKey,
                    onchanged: (value) =>
                        context.read<RegionCubit>().onRegionNameChanged(value),
                    onSubmitted: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<RegionCubit>().addRegion();
                      }
                    },
                  ),
                  style: TextButton.styleFrom(
                    primary: CsColors.primary,
                  ),
                  child: Text(
                    'Add',
                    style: CsTextStyle.bodyText1.copyWith(
                      color: CsColors.primary,
                      fontWeight: CsFontWeight.semiBold,
                    ),
                  ),
                ),
              ],
            ),
            Gap(context.minBlockVertical * 5.0),
            Expanded(
              child: BlocBuilder<RegionCubit, RegionState>(
                builder: (context, state) {
                  if (state.status == RegionStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == RegionStatus.success) {
                    return ListView.separated(
                      itemCount: state.regions.length,
                      separatorBuilder: (context, index) {
                        return Gap(context.minBlockVertical * 2.0);
                      },
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => context.push(
                            '${WesyPages.region}/${state.regions[index].id}',
                          ),
                          child: Card(
                            elevation: 3,
                            child: ListTile(
                              title: Text(
                                state.regions[index].name ?? 'N/A',
                                style: CsTextStyle.headline4.copyWith(
                                  fontWeight: CsFontWeight.bold,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(15),
                              trailing: const Icon(
                                Icons.navigate_next,
                                size: 35,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
