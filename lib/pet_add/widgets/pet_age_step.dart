import 'package:Petamin/pet_add/pet_add.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetAge extends StatelessWidget {
  const PetAge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "How old is Tommy?",
            style: CustomTextTheme.heading2(context, textColor: Colors.white),
          ),
        ),
        SizedBox(
          height: 64,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0))),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Years",
                            style: CustomTextTheme.heading3(context),
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          BlocBuilder<PetAddCubit, PetAddState>(
                            buildWhen: (previous, current) =>
                                previous.year != current.year,
                            builder: (context, state) {
                              return NumberSelectSlider(
                                initialPage: state.year,
                                onPageChanged: (index, reason) => context
                                    .read<PetAddCubit>()
                                    .selectYear(index),
                                end: 30,
                                height: 72.0,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Months",
                            style: CustomTextTheme.heading3(context),
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          BlocBuilder<PetAddCubit, PetAddState>(
                            buildWhen: (previous, current) =>
                                previous.month != current.month,
                            builder: (context, state) {
                              return NumberSelectSlider(
                                initialPage: state.month,
                                onPageChanged: (index, reason) => context
                                    .read<PetAddCubit>()
                                    .selectMonth(index),
                                end: 11,
                                height: 72.0,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
                ),
                ElevatedButton(
                  key: const Key('next_property_raisedButton'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: const Size.fromHeight(40),
                      primary: AppTheme.colors.pink,
                      onSurface: AppTheme.colors.pink),
                  onPressed: () => context.read<PetAddCubit>().nextStep(),
                  child: Text('Next to Image',
                      style: CustomTextTheme.label(context)),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class NumberSelectSlider extends StatelessWidget {
  const NumberSelectSlider(
      {Key? key,
      required this.initialPage,
      this.onPageChanged,
      this.start = 0,
      this.end = 1,
      required this.height})
      : super(key: key);

  final int initialPage;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final int start;
  final int end;
  final double height;

  @override
  Widget build(BuildContext context) {
    final numberRange = Iterable<int>.generate(end + 1).toList();
    return Stack(
      children: [
        Center(
          child: Container(
            height: height,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: AppTheme.colors.lightPurple, width: 2.0)),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
              height: height,
              onPageChanged: onPageChanged,
              aspectRatio: 1.0,
              enableInfiniteScroll: false,
              initialPage: initialPage,
              viewportFraction: 0.2),
          items: numberRange
              .map((index) => Center(
                    child: Text(
                      numberRange[index].toString(),   
                      style: CustomTextTheme.heading2(context,
                          textColor: index == initialPage
                              ? AppTheme.colors.green
                              : Colors.grey),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
