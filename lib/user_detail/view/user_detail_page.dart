import 'package:Petamin/chat/chat.dart';
import 'package:Petamin/home/home.dart';
import 'package:Petamin/pet_adopt/view/pet_adopt_page.dart';
import 'package:Petamin/shared/shared_widgets.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:Petamin/user_detail/cubit/user_detail_cubit.dart';
import 'package:Petamin/user_detail/cubit/user_detail_state.dart';
import 'package:Petamin/user_detail/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petamin_repository/petamin_repository.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({required this.userId, Key? key}) : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDetailCubit(context.read<PetaminRepository>())
        ..getUserprofile(userId),
      child: UserDetailView(),
    );
  }
}

class UserDetailView extends StatelessWidget {
  const UserDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((UserDetailCubit bloc) => bloc.state);
    return Scaffold(
        appBar: AppBar(
          title: Text(user.name),
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Avatar(
                        size: 40,
                        photo: user.avatarUrl,
                      ),
                      Column(
                        children: [
                          Text('${user.adoptList.length}',
                              style: CustomTextTheme.label(context)),
                          Text(
                            'Posts',
                            style: CustomTextTheme.body2(context),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserFollowView(
                                  userId: user.userId, name: user.name)));
                        },
                        child: Column(
                          children: [
                            Text('${user.countFollowers}',
                                style: CustomTextTheme.label(context)),
                            Text(
                              'Followers',
                              style: CustomTextTheme.body2(context),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserFollowView(
                                    userId: user.userId, name: user.name)));
                          },
                          child: Column(
                            children: [
                              Text('${user.countFollowings}',
                                  style: CustomTextTheme.label(context)),
                              Text(
                                'Following',
                                style: CustomTextTheme.body2(context),
                              ),
                            ],
                          )),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      user.name,
                      style: CustomTextTheme.label(context),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  children: [
                    Flexible(
                        child: Container(
                            padding: new EdgeInsets.only(right: 13.0),
                            child: Text(
                              user.bio,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextTheme.body2(context),
                            ))),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Row(children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        context.read<UserDetailCubit>().followCLick();
                      },
                      child: Text('${user.isFollow ? 'Following' : 'Follow'}'),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                          backgroundColor: AppTheme.colors.green,
                          foregroundColor: AppTheme.colors.white),
                    )),
                    SizedBox(width: 16.0),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () async {
                        final conversationId = await context
                            .read<UserDetailCubit>()
                            .createConversations(user.userId);
                        if (conversationId.length >= 0) {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                      conversationId: conversationId)));
                        } else {
                          showToast(msg: 'User is locked!');
                        }
                      },
                      child: Text('Message'),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                          backgroundColor: AppTheme.colors.white,
                          foregroundColor: AppTheme.colors.green),
                    )),
                  ])),
              TabBar(
                indicatorColor: AppTheme.colors.green,
                indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(color: AppTheme.colors.green, width: 2.0),
                  // insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0)
                ),
                labelColor: Colors.black,
                unselectedLabelColor: AppTheme.colors.grey,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.pets,
                      // color: Colors.black,
                    ),
                  ),
                  Tab(
                      icon: Icon(
                    Icons.grid_3x3_outlined,
                    // color: Colors.black,
                  )),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    BlocBuilder<UserDetailCubit, UserDetailState>(
                        buildWhen: (previous, current) =>
                            previous.petList != current.petList,
                        builder: (context, state) {
                          return GridView.builder(
                            padding: const EdgeInsets.all(16.0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 18,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () => {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    PetAdoptPage(
                                                      id: user
                                                          .petList[index].id!,
                                                      ownerId: user
                                                          .petList[index]
                                                          .userId!,
                                                    )))
                                      },
                                  child: PetCard(
                                    data: PetCardData(
                                      petId: user.petList[index].id!,
                                      age: user.petList[index].year.toString(),
                                      name: user.petList[index].name!,
                                      photo: user.petList[index].avatarUrl!,
                                      breed: user.petList[index].breed!,
                                      sex: user.petList[index].gender!,
                                      price: -1,
                                    ),
                                    // user.petList[index], // TODO: Change to real data
                                  ));
                            },
                            itemCount: user
                                .petList.length, // TODO: Change to real data
                          );
                        }),
                    BlocBuilder<UserDetailCubit, UserDetailState>(
                        buildWhen: (previous, current) =>
                            previous.adoptList != current.adoptList,
                        builder: (context, state) {
                          return GridView.builder(
                            padding: const EdgeInsets.all(16.0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 18,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () => {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    PetAdoptPage(
                                                      id: user.adoptList[index]
                                                          .petId!,
                                                      ownerId: user
                                                          .adoptList[index]
                                                          .userId!,
                                                    )))
                                      },
                                  child: PetCard(
                                    data: PetCardData(
                                      petId: user.adoptList[index].petId!,
                                      adoptId: user.adoptList[index].id!,
                                      age: user.adoptList[index].pet!.year
                                          .toString(),
                                      name: user.adoptList[index].pet!.name!,
                                      photo:
                                          user.adoptList[index].pet!.avatarUrl!,
                                      breed: user.adoptList[index].pet!.breed!,
                                      sex: user.adoptList[index].pet!.gender!,
                                      price: user.adoptList[index].price!,
                                    ),
                                  ));
                            },
                            itemCount: user
                                .adoptList.length, // TODO: Change to real data
                          );
                        }),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
