import 'package:Petamin/home/home.dart';
import 'package:Petamin/profile-info/cubit/profile_info_cubit.dart';
import 'package:Petamin/shared/constants.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:Petamin/user_detail/follow/cubit/follow_cubit.dart';
import 'package:Petamin/user_detail/follow/cubit/follow_state.dart';
import 'package:Petamin/user_detail/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petamin_repository/petamin_repository.dart';

class UserFollowView extends StatelessWidget {
  const UserFollowView({required this.userId, required this.name, Key? key})
      : super(key: key);
  final String userId;
  final String name;
  @override
  Widget build(BuildContext context) {
    final user = context.select((ProfileInfoCubit bloc) => bloc.state);
    return BlocProvider(
        create: (context) =>
            FollowCubit(context.read<PetaminRepository>())..getFollows(userId),
        child: Scaffold(
            appBar: AppBar(
              title: Text(name),
            ),
            body: DefaultTabController(
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
                      BlocBuilder<FollowCubit, FollowState>(
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
                                                        .read<FollowCubit>()
                                                        .unFollow(
                                                            state
                                                                .followers[
                                                                    index]
                                                                .userId!,
                                                            true);
                                                  } else {
                                                    context
                                                        .read<FollowCubit>()
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
                      BlocBuilder<FollowCubit, FollowState>(
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
                                                      .read<FollowCubit>()
                                                      .unFollow(
                                                          state.following[index]
                                                              .userId!,
                                                          false);
                                                } else {
                                                  context
                                                      .read<FollowCubit>()
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