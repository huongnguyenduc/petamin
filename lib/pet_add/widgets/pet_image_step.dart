import 'package:Petamin/pet_add/pet_add.dart';
import 'package:Petamin/pet_list/cubit/pet_list_cubit.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PetImage extends StatelessWidget {
  const PetImage({
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
            "You are almost done!",
            style: CustomTextTheme.heading2(context, textColor: Colors.white),
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Let’s add Tommy’s photo and tell something about him",
            style: CustomTextTheme.subtitle(context, textColor: Colors.white),
          ),
        ),
        SizedBox(
          height: 36,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0))),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BlocBuilder<PetAddCubit, PetAddState>(
                                  buildWhen: (previous, current) =>
                                      previous.imageName != current.imageName,
                                  builder: (context, state) {
                                    if (state.imageFile == null)
                                      return GestureDetector(
                                        onTap: () => context
                                            .read<PetAddCubit>()
                                            .selectPetImage(
                                                ImageSource.gallery),
                                        child: Container(
                                          height: 130.0,
                                          width: 130.0,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppTheme.colors.lightPink),
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: AppTheme.colors.pink,
                                            size: 28.0,
                                          ),
                                        ),
                                      );
                                    return Container(
                                      height: 130.0,
                                      width: 130.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image:
                                                  FileImage(state.imageFile!),
                                              fit: BoxFit.cover)),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                TextField(
                                  key: const Key(
                                      'addPetForm_descriptionInput_textField'),
                                  onChanged: (description) => context
                                      .read<PetAddCubit>()
                                      .descriptionChanged(description),
                                  minLines: 1,
                                  maxLines: 5,
                                  textInputAction: TextInputAction.done,
                                  style: CustomTextTheme.label(context),
                                  decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Write about your pet',
                                      hintStyle: CustomTextTheme.label(context,
                                          textColor:
                                              AppTheme.colors.lightGrey)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Weight",
                                    style: CustomTextTheme.heading3(context),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Integral Weight
                                      BlocBuilder<PetAddCubit, PetAddState>(
                                        buildWhen: (previous, current) =>
                                            previous.integralWeight !=
                                            current.integralWeight,
                                        builder: (context, state) {
                                          return NumberSelectSliderSmall(
                                            initialPage: state.integralWeight,
                                            onPageChanged: (index, reason) =>
                                                context
                                                    .read<PetAddCubit>()
                                                    .selectIntegralWeight(
                                                        index),
                                            end: 99,
                                            height: 72.0,
                                          );
                                        },
                                      ),
                                      // Decimal Separator
                                      Text(
                                        ".",
                                        style:
                                            CustomTextTheme.heading2(context),
                                      ),
                                      // Fractional Weight
                                      BlocBuilder<PetAddCubit, PetAddState>(
                                        buildWhen: (previous, current) =>
                                            previous.fractionalWeight !=
                                            current.fractionalWeight,
                                        builder: (context, state) {
                                          return NumberSelectSliderSmall(
                                            initialPage: state.fractionalWeight,
                                            onPageChanged: (index, reason) =>
                                                context
                                                    .read<PetAddCubit>()
                                                    .selectFractionalWeight(
                                                        index),
                                            end: 9,
                                            height: 72.0,
                                          );
                                        },
                                      ),
                                      Text(
                                        "Kg",
                                        style:
                                            CustomTextTheme.heading2(context),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<PetAddCubit, PetAddState>(
                          buildWhen: (previous, current) =>
                              previous.imageName != current.imageName,
                          builder: (context, state) {
                            return ElevatedButton(
                              key: const Key('next_property_raisedButton'),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  minimumSize: const Size.fromHeight(40),
                                  primary: state.imageFile == null
                                      ? AppTheme.colors.lightGrey
                                      : AppTheme.colors.pink,
                                  onSurface: AppTheme.colors.pink),
                              onPressed: () async {
                                if (state.imageFile == null) {
                                  return;
                                } else {
                                 final result = await context.read<PetAddCubit>().addNewPet();
                                  if(result){
            
                                    Navigator.of(context).pop();
                                  }
                                }
                              },
                              child: Text('Done',
                                  style: CustomTextTheme.label(context)),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class NumberSelectSliderSmall extends StatelessWidget {
  const NumberSelectSliderSmall(
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
    return Container(
      height: 72.0,
      width: 50.0,
      child: CarouselSlider(
        options: CarouselOptions(
            height: height,
            onPageChanged: onPageChanged,
            aspectRatio: 1.0,
            enableInfiniteScroll: false,
            initialPage: initialPage,
            scrollDirection: Axis.vertical,
            viewportFraction: 0.55),
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
    );
  }
}
