import 'package:Petamin/home/home.dart';
import 'package:Petamin/pet_add/view/pet_add_page.dart';
import 'package:Petamin/pet_detail/pet_detail.dart';
import 'package:Petamin/pet_list/cubit/pet_list_state.dart';
import 'package:Petamin/pet_list/widgets/pet_avatar.dart';
import 'package:Petamin/shared/shared_widgets.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:Petamin/user_detail/cubit/user_detail_cubit.dart';
import 'package:Petamin/user_detail/cubit/user_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petamin_repository/petamin_repository.dart';

import '../cubit/pet_list_cubit.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: PetListPage());

  @override
  Widget build(BuildContext context) {
    final cubit = PetListCubit(context.read<PetaminRepository>());
    final userCubit = UserDetailCubit(context.read<PetaminRepository>());
    return MultiBlocProvider(
        providers: [
          BlocProvider<UserDetailCubit>(
            create: (_) => userCubit..getMyUserprofile(),
          ),
          BlocProvider<PetListCubit>(
            create: (_) => cubit..getPets(),
          ),
        ],
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: AppTheme.colors.mediumGrey,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'My pet',
                    style: CustomTextTheme.subtitle(context, textColor: AppTheme.colors.green),
                  ),
                ],
              ),
            ),
            backgroundColor: AppTheme.colors.mediumGrey,
            body: BlocBuilder<PetListCubit, PetListState>(
                buildWhen: (previous, current) => previous.status != current.status,
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status.isFailure) {
                    showToast(msg: "Can't load list pet!");
                  }
                  return DefaultTabController(
                    length: 2,
                    child: CustomScrollView(physics: AlwaysScrollableScrollPhysics(), slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: AppTheme.colors.mediumGrey,
                        pinned: true,
                        floating: true,
                        expandedHeight: 0,
                        bottom: TabBar(
                          indicatorColor: AppTheme.colors.green,
                          tabs: [
                            Tab(
                              child: Text(
                                'Available',
                                style: CustomTextTheme.subtitle(context, textColor: AppTheme.colors.green),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Adopting',
                                style: CustomTextTheme.subtitle(context, textColor: AppTheme.colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverFillRemaining(
                        child: TabBarView(children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 4,
                                    crossAxisSpacing: 35.0,
                                    mainAxisSpacing: 30.0),
                                itemCount: state.pets.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == 0) return AddPetItem(cubit: cubit);
                                  final pet = state.pets[index - 1];
                                  return PetItem(
                                    id: pet.id ?? '',
                                    name: pet.name ?? '',
                                    photo: pet.avatarUrl ??
                                        'https://images.unsplash.com/photo-1592194996308-7b43878e84a6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                                  );
                                },
                              )),
                          BlocBuilder<UserDetailCubit, UserDetailState>(
                              buildWhen: (previous, current) => previous.adoptList != current.adoptList,
                              builder: (context, state) {
                                return GridView.builder(
                                  padding: const EdgeInsets.all(16.0),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 18,
                                    mainAxisSpacing: 18,
                                    childAspectRatio: 0.8,
                                  ),
                                  itemBuilder: (context, index) {
                                    return PetCard(
                                      data: PetCardData(
                                        petId: state.adoptList[index].petId!,
                                        adoptId: state.adoptList[index].id!,
                                        age: state.adoptList[index].pet!.year.toString(),
                                        name: state.adoptList[index].pet!.name!,
                                        photo: state.adoptList[index].pet!.avatarUrl!,
                                        breed: state.adoptList[index].pet!.breed!,
                                        sex: state.adoptList[index].pet!.gender!,
                                        price: state.adoptList[index].price!,
                                      ),
                                    );
                                  },
                                  itemCount: state.adoptList.length, // TODO: Change to real data
                                );
                              }),
                        ]),
                      ),
                    ]),
                  );
                })));
  }
}

class PetItem extends StatelessWidget {
  const PetItem({Key? key, required this.id, required this.name, required this.photo}) : super(key: key);
  final String id;
  final String name;
  final String photo;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Ink(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
            child: InkWell(
                onTap: () => {
                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                          builder: (context) => PetDetailPage(
                                id: id,
                              )))
                    },
                borderRadius: BorderRadius.circular(10.0),
                splashColor: AppTheme.colors.pink,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                  padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  width: 150.0,
                  height: 200.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PetAvatar(
                        photo: photo,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(name, style: CustomTextTheme.label(context))
                    ],
                  ),
                ))));
  }
}

class AddPetItem extends StatelessWidget {
  const AddPetItem({required this.cubit, Key? key}) : super(key: key);
  final PetListCubit cubit;

  @override
  Widget build(BuildContext context) {
    void onGoBack() {
      cubit.getPets();
    }

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) => const PetAddPage()))
                .then((_) => onGoBack());
            debugPrint('Listttt pettttt');
          },
          borderRadius: BorderRadius.circular(10.0),
          splashColor: AppTheme.colors.pink,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            width: 150.0,
            height: 200.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_circle_outline_rounded,
                  color: AppTheme.colors.pink,
                  size: 32.0,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Add new',
                  style: CustomTextTheme.label(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
