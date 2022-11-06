import 'package:Petamin/pet-info/pet-info.dart';
import 'package:Petamin/pet_detail/cubit/pet_detail_cubit.dart';
import 'package:Petamin/pet_detail/cubit/pet_detail_state.dart';
import 'package:Petamin/shared/shared_widgets.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petamin_repository/petamin_repository.dart';

class PetDetailPage extends StatelessWidget {
  const PetDetailPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => PetDetailCubit(context.read<PetaminRepository>())
          ..getPetDetail(id: id),
        child: DefaultTabController(
            length: 2,
            child: Container(
                color: AppTheme.colors.white,
                child: BlocBuilder<PetDetailCubit, PetDetailState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      final pet = state.pet;
                      if (state.status == PetDetailStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.status == PetDetailStatus.failure) {
                        showToast(msg: 'Can\'t load pet detail!');
                        return const Center();
                      } else {
                        return CustomScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          slivers: [
                            SliverAppBar(
                              automaticallyImplyLeading: false,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                        Navigator.pop(context);
                                      },
                                    child: Container(
                                      width: 35.0,
                                      height: 35.0,
                                      decoration: BoxDecoration(
                                          color: AppTheme.colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      child: Icon(
                                        Icons.arrow_back_outlined,
                                        color: AppTheme.colors.green,
                                      )),
                                  )
                                  ,
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
                                  pet.avatarUrl ??
                                  "https://images.pexels.com/photos/2173872/pexels-photo-2173872.jpeg?auto=compress&cs=tinysrgb&w=750&h=750&dpr=1",
                                  width: double.maxFinite,
                                  fit: BoxFit.cover,
                                ),
                                stretchModes: [StretchMode.zoomBackground],
                              ),
                            ),
                            SliverToBoxAdapter(
                                child: Container(
                              padding: EdgeInsets.only(left: 30.0, right: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        pet.name ?? "Tyler",
                                        style: CustomTextTheme.heading3(
                                          context,
                                          textColor: AppTheme.colors.solidGrey,
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                        PetInfoPage()));
                                          },
                                          child: Icon(Icons.edit))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    pet.description ?? "My lovely cat <3",
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
                                          value: ((pet.gender ?? "") == "MALE") ? "Male" : "Female" ,
                                          label: "Sex",
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        PetProperty(
                                          value: "${pet.year}y${pet.month}m",
                                          label: "Age",
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        PetProperty(
                                          value:  pet.breed ?? "",
                                          label: "Breed",
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        PetProperty(
                                          value: (pet.isNeuter ?? false) ? "Yes" : "No",
                                          label: "Neutered",
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        PetProperty(
                                          value: "${pet.weight} kg",
                                          label: "Weight",
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
                                    unselectedLabelColor: AppTheme.colors.grey,
                                    tabs: [
                                      Tab(
                                          icon: Icon(
                                        Icons.grid_3x3_outlined,
                                        // color: Colors.black,
                                      )),
                                      Tab(
                                        icon: Icon(
                                          Icons.pets,
                                          // color: Colors.black,
                                        ),
                                      )
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
                                itemCount: _items.length,
                                itemBuilder: (context, index) {
                                  // Item rendering
                                  return GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (_) => ImageDialog(
                                              image: _items[index].image));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              NetworkImage(_items[index].image),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Icon(
                                Icons.pets,
                                color: Colors.red,
                              )
                            ]))
                          ],
                        );
                      }
                    }))));
  }
}

final List<PetPhotoItem> _items = [
  PetPhotoItem(
      "https://images.pexels.com/photos/7752793/pexels-photo-7752793.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&dpr=1",
      "Stephan Seeber"),
  PetPhotoItem(
      "https://images.pexels.com/photos/1107807/pexels-photo-1107807.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&dpr=1",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/2361952/pexels-photo-2361952.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&dpr=1",
      "Liam Ganttt"),
  PetPhotoItem(
      "https://images.pexels.com/photos/667228/pexels-photo-667228.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&dpr=1",
      "Liam Gantt"),
  PetPhotoItem(
      "https://images.pexels.com/photos/179222/pexels-photo-179222.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&dpr=1",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/51439/pexels-photo-51439.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&dpr=1",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/3652805/pexels-photo-3652805.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&dpr=1",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/160839/cat-animal-love-pet-160839.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&dpr=1",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/4790612/pexels-photo-4790612.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&dpr=1",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/8519611/pexels-photo-8519611.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&dpr=1",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/1107807/pexels-photo-1107807.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&dpr=1",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/7319488/pexels-photo-7319488.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&dpr=1",
      "Liam Gant"),
];

class PetPhotoItem {
  final String image;
  final String name;
  PetPhotoItem(this.image, this.name);
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
    Key? key,
  }) : super(key: key);
  final String image;
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
                  backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/2173872/pexels-photo-2173872.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=1"),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  "Tyler",
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
                Icon(
                  Icons.delete_outline_rounded,
                  color: AppTheme.colors.white,
                  size: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
