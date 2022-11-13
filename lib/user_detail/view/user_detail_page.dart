import 'package:Petamin/home/home.dart';
import 'package:Petamin/landing/cubit/landing_cubit.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:Petamin/user_detail/user_detail.dart';
import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Farah Anas'),
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
                        photo:
                            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=180&q=80',
                      ),
                      Column(
                        children: [
                          Text('${59}', style: CustomTextTheme.label(context)),
                          Text(
                            'Posts',
                            style: CustomTextTheme.body2(context),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserFollowView()));
                        },
                        child: Column(
                          children: [
                            Text('${1.2}K', style: CustomTextTheme.label(context)),
                            Text(
                              'Followers',
                              style: CustomTextTheme.body2(context),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text('${1.2}K', style: CustomTextTheme.label(context)),
                          Text(
                            'Following',
                            style: CustomTextTheme.body2(context),
                          ),
                        ],
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Farah Anas',
                      style: CustomTextTheme.label(context),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  children: [
                    Text(
                      'Everything will be ok!!',
                      style: CustomTextTheme.body2(context),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Row(children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Follow'),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                          backgroundColor: AppTheme.colors.green,
                          foregroundColor: AppTheme.colors.white),
                    )),
                    SizedBox(width: 16.0),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Message'),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                          backgroundColor: AppTheme.colors.white,
                          foregroundColor: AppTheme.colors.green),
                    )),
                  ])),
              TabBar(
                indicatorColor: AppTheme.colors.green,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: AppTheme.colors.green, width: 2.0),
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
                    GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        return PetCard(
                          data: petsMock[index], // TODO: Change to real data
                        );
                      },
                      itemCount: petsMock.length, // TODO: Change to real data
                    ),
                    // GridView.builder(
                    //   physics: NeverScrollableScrollPhysics(),
                    //   gridDelegate:
                    //   SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisSpacing: 4.0,
                    //     mainAxisSpacing: 4.0,
                    //     crossAxisCount: 3,
                    //   ),
                    //   itemCount: pet.photos!.length,
                    //   itemBuilder: (context, index) {
                    //     // Item rendering
                    //     return GestureDetector(
                    //       onTap: () async {
                    //         await showDialog(
                    //             context: context,
                    //             builder: (context) => ImageDialog(
                    //                 cubit: cubit,
                    //                 petAvatar: pet.avatarUrl!,
                    //                 name: pet.photos![index].id,
                    //                 image: pet
                    //                     .photos![index].imgUrl));
                    //       },
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //           image: DecorationImage(
                    //             fit: BoxFit.cover,
                    //             image: NetworkImage(
                    //                 pet.photos![index].imgUrl),
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ), // TODO: Add pet image list
                    Center(child: Text('Pet Image List')),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
