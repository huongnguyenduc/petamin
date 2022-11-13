import 'package:Petamin/home/home.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:Petamin/user_detail/user_detail.dart';
import 'package:flutter/material.dart';

class UserFollowView extends StatelessWidget {
  const UserFollowView({Key? key}) : super(key: key);

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
                TabBar(
                    indicatorColor: AppTheme.colors.green,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: AppTheme.colors.green, width: 2.0),
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
                  ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Avatar(
                            size: 40,
                            photo:
                                'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=180&q=80',
                          ),
                          title: Text('Farah Anas'),
                          subtitle: Text('farah.anas'),
                          trailing: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Follow'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        );
                      }),
                  ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserDetailPage()));
                          },
                          child: ListTile(
                            leading: Avatar(
                              size: 40,
                              photo:
                                  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=180&q=80',
                            ),
                            title: Text('Farah Anas'),
                            subtitle: Text('farah.anas'),
                            trailing: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Unfollow'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.colors.white,
                                  foregroundColor: AppTheme.colors.green,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                            ),
                          ),
                        );
                      }),
                ]))
              ],
            )));
  }
}
