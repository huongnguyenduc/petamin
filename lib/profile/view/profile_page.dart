import 'package:Petamin/app/bloc/app_bloc.dart';
import 'package:Petamin/profile-info/profile-info.dart';
import 'package:Petamin/profile/widgets/widgets.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petamin_repository/petamin_repository.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ProfilePage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit(context.read<PetaminRepository>()),
      child: ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppTheme.colors.mediumGrey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Profile",
                style: CustomTextTheme.subtitle(context,
                    textColor: AppTheme.colors.green),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: AppTheme.colors.mediumGrey),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                UserInfo(),
                SizedBox(
                  height: 16,
                ),
                UserFollow(),
                SizedBox(
                  height: 16,
                ),
                ProfileItem(
                  title: "Edit Profile",
                  onTap: () => Navigator.of(context, rootNavigator: true).push(
                      new MaterialPageRoute(
                          builder: (context) => new ProfileInfoPage())),
                ),
                SizedBox(
                  height: 8,
                ),
                ProfileItem(title: "Favorite List"),
                SizedBox(
                  height: 8,
                ),
                ProfileItem(title: "Order details"),
                SizedBox(
                  height: 8,
                ),
                ProfileItem(title: "Order tracking"),
                SizedBox(
                  height: 8,
                ),
                ProfileItem(title: "Shipping Address"),
                SizedBox(
                  height: 8,
                ),
                ProfileItem(title: "Setting"),
                SizedBox(
                  height: 8,
                ),
                ProfileItem(
                  title: "Logout",
                  onTap: () {
                    context
                        .read<AppSessionBloc>()
                        .add(AppLogoutSessionRequested());
                    context
                        .read<AppSessionBloc>()
                        .add(AppLogoutSessionRequested());
                  },
                )
              ],
            ),
          ),
        ));
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({Key? key, required this.title, this.onTap})
      : super(key: key);
  final String title;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10.0),
          highlightColor: AppTheme.colors.pink,
          splashColor: AppTheme.colors.pink,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: CustomTextTheme.label(context),
                ),
                Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: AppTheme.colors.green,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserFollow extends StatelessWidget {
  const UserFollow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: AppTheme.colors.grey, width: 0.3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FollowItem(
            title: "pets",
            count: 3,
          ),
          FollowItem(
            title: "followers",
            count: 5,
          ),
          FollowItem(
            title: "following",
            count: 2,
          )
        ],
      ),
    );
  }
}

class FollowItem extends StatelessWidget {
  const FollowItem({Key? key, this.count, this.title}) : super(key: key);
  final count;
  final title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: CustomTextTheme.caption(context, fontWeight: FontWeight.w500),
        ),
        Text(
          title.toString(),
          style: CustomTextTheme.caption(context,
              textColor: AppTheme.colors.solidGrey),
        )
      ],
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((ProfileInfoCubit bloc) => bloc.state);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SquaredAvatar(
          photo: user.avatarUrl,
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            user.name == null
                ? Text(
                    "unknown",
                    style: CustomTextTheme.label(context),
                  )
                : Text(
                    user.name,
                    style: CustomTextTheme.label(context),
                  ),
            SizedBox(
              height: 8,
            ),
            Text(
              user.address ?? "unknown",
              style: CustomTextTheme.caption(context,
                  textColor: AppTheme.colors.grey),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              user.bio ?? "unknown",
              style: CustomTextTheme.caption(context),
            )
          ],
        )
      ],
    );
  }
}
