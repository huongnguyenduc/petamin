import 'dart:math' as math;

import 'package:Petamin/home/home.dart';
import 'package:Petamin/landing/landing.dart';
import 'package:Petamin/pet_adopt/view/pet_adopt_page.dart';
import 'package:Petamin/profile-info/cubit/profile_info_cubit.dart';
import 'package:Petamin/search/pet/search_pet.dart';
import 'package:Petamin/shared/constants.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:Petamin/user_detail/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:petamin_repository/petamin_repository.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LandingPage());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LandingCubit>(
          create: (_) => LandingCubit(),
        ),
        BlocProvider<SearchPetCubit>(
          create: (_) => SearchPetCubit(context.read<PetaminRepository>())
            ..searchAdoption('i', true),
        ),
      ],
      child: const LandingView(),
    );
  }
}

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((ProfileInfoCubit bloc) => bloc.state);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                        buildWhen: (previous, current) =>
                            previous.name != current.name,
                        builder: (context, state) {
                          return GestureDetector(
                            child: Avatar(
                              size: 28,
                              photo: state.avatarUrl.length > 0
                                  ? state.avatarUrl
                                  : ANONYMOUS_AVATAR,
                            ),
                          );
                        }),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name.length > 0 ? user.name : 'Unknown',
                            style: CustomTextTheme.subtitle(context),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppTheme.colors.green,
                                size: 16,
                              ),
                              Text(
                                user.address.length > 0 ? user.address : '',
                                style: CustomTextTheme.body2(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppTheme.colors.lightBorder, width: 1.5)),
                      child: IconButton(
                          onPressed: () {
                            // Navigate to SearchPetPage
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchPetPage(
                                      isFocusSearchBar: true,
                                    )));
                          },
                          icon: SvgPicture.asset(
                              "assets/icons/action=search-small.svg",
                              width: 24)),
                    )
                  ],
                ),
                SizedBox(height: 16.0),
                LandingBanner(),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Categories",
                        style: CustomTextTheme.heading4(context)),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppTheme.colors.lightBorder, width: 1.5)),
                      child: IconButton(
                          onPressed: () {
                            // Navigate to SearchPetPage
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchPetPage(
                                      isShowFilter: true,
                                    )));
                          },
                          icon: SvgPicture.asset(
                              "assets/icons/action=filter.svg",
                              width: 24)),
                    )
                  ],
                ),
                SizedBox(height: 8.0),
                // GridView with 2 columns and 2 rows
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3.5,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                    ),
                    itemCount: speciesData.length,
                    itemBuilder: (context, index) {
                      final data = speciesData.entries.elementAt(index);
                      return Material(
                        color: Colors.transparent,
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: data.value.color,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100.0),
                            onTap: () {
                              // Navigate to SearchPetPage
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SearchPetPage(
                                        selectedSpecies: data.key,
                                      )));
                            },
                            highlightColor: AppTheme.colors.ultraLightGreen,
                            splashColor: AppTheme.colors.ultraLightGreen,
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(data.value.iconAsset,
                                      width: 24),
                                  SizedBox(width: 8.0),
                                  Text(data.value.name,
                                      style: CustomTextTheme.body2(context,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Adopt me", style: CustomTextTheme.heading4(context)),
                    TextButton(
                      onPressed: () {
                        // Navigate to SearchPetPage
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchPetPage()));
                      },
                      child: Text(
                        "See all",
                        style: CustomTextTheme.body2(context,
                            textColor: AppTheme.colors.purple,
                            fontWeight: FontWeight.w600),
                      ),
                      clipBehavior: Clip.hardEdge,
                    )
                  ],
                ),
                SizedBox(height: 8.0),
                BlocBuilder<SearchPetCubit, SearchPetState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status ||
                        previous.selectedSpecies != current.selectedSpecies,
                    builder: (context, state) {
                      return SizedBox(
                        height: 230,
                        child: ListView.separated(
                          // Scroll horizontally
                          padding: EdgeInsets.symmetric(horizontal: 18),

                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final pet = context
                                .read<SearchPetCubit>()
                                .state
                                .searchResults[index];
                            return InkWell(
                                onTap: () => {
                                      Navigator.of(context, rootNavigator: true)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  PetAdoptPage(
                                                    id: pet.petId ?? '',
                                                  )))
                                    },
                                child: PetCard(
                                    data: PetCardData(
                                  petId: pet.petId ?? '',
                                  adoptId: pet.id ?? '',
                                  age: '${pet.pet?.year ?? '0'}',
                                  name: pet.pet?.name ?? '',
                                  photo: pet.pet?.avatarUrl ?? '',
                                  breed: pet.pet?.breed ?? '',
                                  sex: pet.pet?.gender ?? 'unknown',
                                  price: pet.price ?? 0,
                                  // ignore: todo
                                ))); // TODO: use real data
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 20.0,
                            );
                          },
                          itemCount: context
                                      .read<SearchPetCubit>()
                                      .state
                                      .searchResults
                                      .length >
                                  5
                              ? 5
                              : context
                                  .read<SearchPetCubit>()
                                  .state
                                  .searchResults
                                  .length,
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LandingBanner extends StatelessWidget {
  const LandingBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Transform.rotate(
              angle: -math.pi / 6,
              child: Icon(Icons.pets_rounded,
                  size: 64, color: AppTheme.colors.grey)),
          top: 8,
          right: 98,
        ),
        Positioned(
          child: Transform.rotate(
              angle: math.pi / 3,
              child: Icon(Icons.pets_rounded,
                  size: 24, color: AppTheme.colors.grey)),
          top: 10,
          right: 14,
        ),
        Positioned(
          child: Transform.rotate(
              angle: math.pi / 3,
              child: Icon(Icons.pets_rounded,
                  size: 30, color: AppTheme.colors.grey)),
          top: 40,
          right: 8,
        ),
        Container(
          height: 140.0,
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: AppTheme.colors.lightPurple.withOpacity(0.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Join our community\nof animal lovers",
                  style: CustomTextTheme.heading4(context)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Text("Join Now"),
                onPressed: () {},
              )
            ],
          ),
        ),
        Positioned(
          child: Lottie.asset("assets/lottie/adopt_box.json",
              width: 140, height: 140),
          top: 0,
          right: 12,
        )
      ],
    );
  }
}
