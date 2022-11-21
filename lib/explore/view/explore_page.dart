import 'dart:async';

import 'package:Petamin/explore/cubit/explore_cubit.dart';
import 'package:Petamin/home/home.dart';
import 'package:Petamin/shared/shared_widgets.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:Petamin/user_detail/view/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:petamin_repository/petamin_repository.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});

  static Page<void> page() => MaterialPage<void>(child: ExplorePage());
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    final _cubit = ExploreCubit(context.read<PetaminRepository>())..initData();
    String _query = '';

    _scrollListener() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        print('reach the bottom');
        _cubit.search(_query);
      }
      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        print('reach the top');
      }
    }

    _scrollController.addListener(_scrollListener);
    _onSearchChanged(String query) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 800), () {
        // do something with query
        _query = query;
        _cubit.search(query);
      });
    }

    return BlocProvider(
        create: (_) => _cubit,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  context.read<HomeCubit>().onMenuItemTapped(0);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppTheme.colors.green,
                ),
              ),
              elevation: 0,
              title: TextFormField(
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  color: Colors.black,
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: BlocBuilder<ExploreCubit, ExploreState>(
                  buildWhen: (previous, current) =>
                      previous.searchResults != current.searchResults ||
                      previous.status != current.status,
                  builder: (context, state) {
                    if (state.status == ExploreStatus.searching) {
                      EasyLoading.show();
                    } else {
                      EasyLoading.dismiss();
                    }
                    if (state.status == ExploreStatus.failure) {
                      showToast(msg: "Can't load result!");
                    }
                    if (state.status == ExploreStatus.success ||
                        state.status == ExploreStatus.newQuery) {
                      if (state.searchResults.isEmpty) {
                        return Center(child: Text('No result found!'));
                      }
                    }
                    return Column(children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16.0),
                          child: Text(
                              state.status == ExploreStatus.initial
                                  ? 'Suggestions'
                                  : 'Search Result',
                              textAlign: TextAlign.left,
                              style: CustomTextTheme.heading4(context))),
                      Expanded(
                          child: SizedBox(
                              child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          final chat = state.searchResults[index];
                          return GestureDetector(
                            onTap: () async {
                              Navigator.of(context).push<void>(
                                MaterialPageRoute(
                                  builder: (context) => UserDetailPage(
                                    userId: chat.userId!,
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(chat.avatar!),
                              ),
                              title: Text(chat.name ?? ''),
                              subtitle: Text(chat.address ?? ''),
                              trailing: Text('12:00'),
                            ),
                          );
                        },
                      )))
                    ]);
                  }),
            )));
  }
}
