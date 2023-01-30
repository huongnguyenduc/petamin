import 'package:Petamin/app/app.dart';
import 'package:Petamin/pet-info/pet-info.dart';
import 'package:Petamin/pet_detail/cubit/pet_detail_cubit.dart';
import 'package:Petamin/pet_detail/cubit/pet_detail_state.dart';
import 'package:Petamin/pet_post/pet_post.dart';
import 'package:Petamin/shared/shared_widgets.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petamin_repository/petamin_repository.dart';

class PetDetailPage extends StatelessWidget {
  const PetDetailPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    final cubit = PetDetailCubit(context.read<PetaminRepository>());
    final userId = context.read<AppSessionBloc>().state.session.userId;
    void onGoBack() {
      cubit..getPetDetail(id: id, userId: userId);
    }

    return BlocProvider(
        create: (_) => cubit..getPetDetail(id: id, userId: userId),
        child: DefaultTabController(
            length: 1,
            child: Container(
                color: AppTheme.colors.white,
                child: BlocBuilder<PetDetailCubit, PetDetailState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status ||
                        previous.pet.photos != current.pet.photos,
                    builder: (context, state) {
                      final pet = state.pet;
                      // if (state.status == PetDetailStatus.loading) {
                      //   return const Center(
                      //     child: CircularProgressIndicator(),
                      //   );
                      // } else
                      if (state.status == PetDetailStatus.failure) {
                        showToast(msg: 'Can\'t load pet detail!');
                        return const Center();
                      } else {
                        return Scaffold(
                            backgroundColor: AppTheme.colors.white,
                            floatingActionButton: SpeedDial(
                              animatedIcon: AnimatedIcons.menu_close,
                              animatedIconTheme: IconThemeData(size: 22.0),
                              backgroundColor: AppTheme.colors.green,
                              visible: true,
                              curve: Curves.bounceIn,
                              overlayOpacity: 0.4,
                              children: [
                                SpeedDialChild(
                                    child: SvgPicture.asset(
                                      'assets/icons/send.svg',
                                      width: 16.0,
                                      height: 16.0,
                                    ),
                                    backgroundColor: AppTheme.colors.green,
                                    label: 'Transfer',
                                    labelStyle: TextStyle(fontSize: 18.0),
                                    onTap: () => Navigator.of(context,
                                            rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) => PetTransfer(
                                                  petId: pet.id!,
                                                  petAvatar: pet.avatarUrl!,
                                                  petName: pet.name!,
                                                )))),
                                SpeedDialChild(
                                    child: SvgPicture.asset(
                                      'assets/icons/home_heart.svg',
                                      width: 24.0,
                                      height: 24.0,
                                    ),
                                    backgroundColor: AppTheme.colors.green,
                                    label: pet.isAdopting == false
                                        ? 'Post Adopt'
                                        : 'Edit Adopt',
                                    labelStyle: TextStyle(fontSize: 18.0),
                                    onTap: () => Navigator.of(context,
                                                rootNavigator: true)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    pet.isAdopting == false
                                                        ? PetCreatePost(
                                                            petId: pet.id!,
                                                            petImage:
                                                                pet.avatarUrl!,
                                                            petName: pet.name!)
                                                        : PetEditPost(
                                                            petId: pet.id!,
                                                            petName: pet.name!,
                                                            petImage:
                                                                pet.avatarUrl!,
                                                          )))
                                            .then((_) {
                                          onGoBack();
                                        })),
                                SpeedDialChild(
                                    child: SvgPicture.asset(
                                      'assets/icons/add-photo.svg',
                                      width: 24.0,
                                      height: 24.0,
                                      color: AppTheme.colors.white,
                                    ),
                                    backgroundColor: AppTheme.colors.green,
                                    label: 'Add Photos',
                                    labelStyle: TextStyle(fontSize: 18.0),
                                    onTap: () => context
                                        .read<PetDetailCubit>()
                                        .selectMultipleImages()),
                                SpeedDialChild(
                                    child: Icon(
                                      Icons.delete,
                                      color: AppTheme.colors.white,
                                    ),
                                    backgroundColor: AppTheme.colors.green,
                                    label: 'Delete',
                                    labelStyle: TextStyle(fontSize: 18.0),
                                    onTap: () => showDialog(
                                        context: context,
                                        builder: (_context) => AlertDialog(
                                              title: const Text('Delete Pet '),
                                              content: const Text(
                                                  'Are you sure want to delete this pet?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(_context)
                                                            .pop(),
                                                    child:
                                                        const Text('Cancel')),
                                                TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              PetDetailCubit>()
                                                          .deletePet(
                                                              id: id,
                                                              context: context);
                                                    },
                                                    child: const Text('Delete'))
                                              ],
                                            ))),
                              ],
                            ),
                            body: CustomScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              slivers: [
                                SliverAppBar(
                                  automaticallyImplyLeading: false,
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                            width: 35.0,
                                            height: 35.0,
                                            decoration: BoxDecoration(
                                                color: AppTheme.colors.green
                                                    .withOpacity(0.4),
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                            child: Icon(
                                              Icons.arrow_back_outlined,
                                              color: AppTheme.colors.yellow,
                                            )),
                                      ),
                                      // Your widgets here
                                    ],
                                  ),
                                  bottom: PreferredSize(
                                    preferredSize: Size.fromHeight(20.0),
                                    child: Container(
                                      width: double.maxFinite,
                                      padding: EdgeInsets.only(
                                        top: 25.0,
                                      ),
                                      transform: Matrix4.translationValues(
                                          0.0, 1.0, 0.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25.0),
                                          topRight: Radius.circular(25.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  elevation: 0,
                                  pinned: true,
                                  expandedHeight: 350.0,
                                  stretch: true,
                                  onStretchTrigger: () async => {await 0},
                                  flexibleSpace: FlexibleSpaceBar(
                                    background: Image.network(
                                      pet.avatarUrl != null
                                          ? pet.avatarUrl!
                                          : 'https://images.pexels.com/photos/2173872/pexels-photo-2173872.jpeg?auto=compress&cs=tinysrgb&w=750&h=750&dpr=1',
                                      width: double.maxFinite,
                                      fit: BoxFit.cover,
                                    ),
                                    stretchModes: [StretchMode.zoomBackground],
                                  ),
                                ),
                                SliverToBoxAdapter(
                                    child: Container(
                                  padding:
                                      EdgeInsets.only(left: 30.0, right: 30.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            pet.name ?? 'Tyler',
                                            style: CustomTextTheme.heading3(
                                              context,
                                              textColor:
                                                  AppTheme.colors.solidGrey,
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            PetInfoPage(
                                                              pet: pet,
                                                            )))
                                                    .then((_) {
                                                  onGoBack();
                                                });
                                              },
                                              child: Container(
                                                width: 60.0,
                                                height: 40.0,
                                                child: Icon(Icons.edit),
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        pet.description ?? 'My lovely cat <3',
                                        style: CustomTextTheme.body2(context,
                                            textColor: AppTheme.colors.grey),
                                      ),
                                      SizedBox(
                                        height: 24.0,
                                      ),
                                      Container(
                                        height: 60.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          // shrinkWrap: true,
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            PetProperty(
                                              value:
                                                  ((pet.gender ?? '') == 'MALE')
                                                      ? 'Male'
                                                      : 'Female',
                                              label: 'Sex',
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            PetProperty(
                                              value:
                                                  '${pet.year}y${pet.month}m',
                                              label: 'Age',
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            PetProperty(
                                              value: pet.breed ?? '',
                                              label: 'Breed',
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            PetProperty(
                                              value: (pet.isNeuter ?? false)
                                                  ? 'Yes'
                                                  : 'No',
                                              label: 'Neutered',
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            PetProperty(
                                              value: '${pet.weight} kg',
                                              label: 'Weight',
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 10.0,
                                      // )
                                    ],
                                  ),
                                )),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: SliverAppBar(
                                    pinned: true,
                                    backgroundColor: Colors.white,
                                    toolbarHeight: 0.0,
                                    elevation: 0,
                                    expandedHeight: 0.0,
                                    collapsedHeight: 0.0,
                                    titleSpacing: 0,
                                    automaticallyImplyLeading: false,
                                    bottom: PreferredSize(
                                      preferredSize: Size.fromHeight(48),
                                      child: TabBar(
                                        indicatorColor: AppTheme.colors.green,
                                        indicator: UnderlineTabIndicator(
                                          borderSide: BorderSide(
                                              color: AppTheme.colors.green,
                                              width: 2.0),
                                          // insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0)
                                        ),
                                        labelColor: Colors.black,
                                        unselectedLabelColor:
                                            AppTheme.colors.grey,
                                        tabs: [
                                          Tab(
                                              icon: Icon(
                                            Icons.grid_3x3_outlined,
                                            // color: Colors.black,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SliverFillRemaining(
                                    child: TabBarView(children: [
                                  GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 4.0,
                                      crossAxisCount: 3,
                                    ),
                                    itemCount: pet.photos!.length,
                                    itemBuilder: (context, index) {
                                      // Item rendering
                                      return GestureDetector(
                                        onTap: () async {
                                          await showDialog(
                                              context: context,
                                              builder: (context) => ImageDialog(
                                                  cubit: cubit,
                                                  petAvatar: pet.avatarUrl!,
                                                  name: pet.name!,
                                                  image: pet
                                                      .photos![index].imgUrl));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  pet.photos![index].imgUrl),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ]))
                              ],
                            ));
                      }
                    }))));
  }
}

class PetProperty extends StatelessWidget {
  const PetProperty({
    required this.value,
    required this.label,
    Key? key,
  }) : super(key: key);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.colors.lightGrey,
            ),
            borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: CustomTextTheme.caption(context,
                  textColor: AppTheme.colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              label,
              style: CustomTextTheme.caption(context,
                  textColor: AppTheme.colors.grey, fontSize: 12.0),
            )
          ],
        ),
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  const ImageDialog({
    required this.image,
    required this.name,
    required this.petAvatar,
    required this.cubit,
    Key? key,
  }) : super(key: key);
  final String image;
  final String name;
  final String petAvatar;
  final PetDetailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                color: AppTheme.colors.black),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(petAvatar ??
                      'https://images.pexels.com/photos/2173872/pexels-photo-2173872.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=1'),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  name ?? '',
                  style: CustomTextTheme.caption(context,
                      textColor: AppTheme.colors.white),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0)),
                color: AppTheme.colors.black),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    final result = await cubit.deletePhoto(id: name);
                    if (result) Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: AppTheme.colors.black,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: AppTheme.colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
