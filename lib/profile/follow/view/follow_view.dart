import 'package:Petamin/home/home.dart';
import 'package:Petamin/profile-info/cubit/profile_info_cubit.dart';
import 'package:Petamin/profile/follow/cubit/my_follow_cubit.dart';
import 'package:Petamin/profile/follow/cubit/my_follow_state.dart';
import 'package:Petamin/shared/constants.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:Petamin/user_detail/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petamin_repository/petamin_repository.dart';

class FollowView extends StatelessWidget {
  const FollowView({required this.initIndex, Key? key}) : super(key: key);
  final int initIndex;
  @override
  Widget build(BuildContext context) {
    final user = context.select((ProfileInfoCubit bloc) => bloc.state);
    return BlocProvider(
        create: (context) => MyFollowCubit(context.read<PetaminRepository>())
          ..getFollows(user.userId),
        child: Scaffold(
            appBar: AppBar(
              title: Text(user.name),
            ),
            body: DefaultTabController(
                initialIndex: initIndex,
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                        indicatorColor: AppTheme.colors.green,
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              color: AppTheme.colors.green, width: 2.0),
                          // insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0)
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: AppTheme.colors.grey,
                        tabs: [
                          Tab(text: 'Followers'),
                          Tab(text: 'Following'),
                        ]),
                    Expanded(
                        child: TabBarView(children: [
                      BlocBuilder<MyFollowCubit, MyFollowState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return ListView.builder(
                                itemCount: state.followers.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        if (user.userId.compareTo(state
                                                .followers[index].userId!) !=
                                            0)
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserDetailPage(
                                                        userId: state
                                                            .followers[index]
                                                            .userId!,
                                                      )));
                                      },
                                      child: ListTile(
                                        leading: Avatar(
                                          size: 40,
                                          photo: state.followers[index].avatar!
                                                      .length >
                                                  0
                                              ? state.followers[index].avatar
                                              : ANONYMOUS_AVATAR,
                                        ),
                                        title:
                                            Text(state.followers[index].name!),
                                        subtitle:
                                            Text(state.followers[index].email!),
                                        trailing: user.userId.compareTo(state
                                                    .followers[index]
                                                    .userId!) !=
                                                0
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  if (state.followers[index]
                                                          .isFollow! ==
                                                      true) {
                                                    context
                                                        .read<MyFollowCubit>()
                                                        .unFollow(
                                                            state
                                                                .followers[
                                                                    index]
                                                                .userId!,
                                                            true);
                                                  } else {
                                                    context
                                                        .read<MyFollowCubit>()
                                                        .follow(
                                                            state
                                                                .followers[
                                                                    index]
                                                                .userId!,
                                                            true);
                                                  }
                                                },
                                                child: Text(
                                                    '${state.followers[index].isFollow! == true ? 'Following' : 'Follow'}'),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppTheme.colors.green,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                              )
                                            : null,
                                      ));
                                });
                          }),
                      BlocBuilder<MyFollowCubit, MyFollowState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return ListView.builder(
                                itemCount: state.following.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      if (user.userId.compareTo(
                                              state.following[index].userId!) !=
                                          0)
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserDetailPage(
                                                      userId: state
                                                          .following[index]
                                                          .userId!,
                                                    )));
                                    },
                                    child: ListTile(
                                      leading: Avatar(
                                        size: 40,
                                        photo: state.following[index].avatar!
                                                    .length >
                                                0
                                            ? state.following[index].avatar
                                            : ANONYMOUS_AVATAR,
                                      ),
                                      title: Text(state.following[index].name!),
                                      subtitle:
                                          Text(state.following[index].email!),
                                      trailing: user.userId.compareTo(state
                                                  .following[index].userId!) !=
                                              0
                                          ? ElevatedButton(
                                              onPressed: () {
                                                if (state.following[index]
                                                        .isFollow! ==
                                                    true) {
                                                  context
                                                      .read<MyFollowCubit>()
                                                      .unFollow(
                                                          state.following[index]
                                                              .userId!,
                                                          false);
                                                } else {
                                                  context
                                                      .read<MyFollowCubit>()
                                                      .follow(
                                                          state.following[index]
                                                              .userId!,
                                                          false);
                                                }
                                              },
                                              child: Text(
                                                  '${state.following[index].isFollow! == true ? 'Following' : 'Follow'}'),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppTheme.colors.white,
                                                  foregroundColor:
                                                      AppTheme.colors.green,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0))),
                                            )
                                          : null,
                                    ),
                                  );
                                });
                          }),
                    ]))
                  ],
                ))));
  }
}
