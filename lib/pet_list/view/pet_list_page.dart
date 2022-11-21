import 'package:Petamin/pet_add/view/pet_add_page.dart';
import 'package:Petamin/pet_detail/pet_detail.dart';
import 'package:Petamin/pet_list/cubit/pet_list_state.dart';
import 'package:Petamin/pet_list/widgets/pet_avatar.dart';
import 'package:Petamin/shared/shared_widgets.dart';
import 'package:Petamin/theme/theme.dart';
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
    return BlocProvider(
        create: (_) => cubit..getPets(),
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
                    style: CustomTextTheme.subtitle(context,
                        textColor: AppTheme.colors.green),
                  ),
                ],
              ),
            ),
            backgroundColor: AppTheme.colors.mediumGrey,
            body: BlocBuilder<PetListCubit, PetListState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status.isFailure) {
                    showToast(msg: "Can't load list pet!");
                  }
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
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
                      ));
                })));
  }
}

class PetItem extends StatelessWidget {
  const PetItem(
      {Key? key, required this.id, required this.name, required this.photo})
      : super(key: key);
  final String id;
  final String name;
  final String photo;
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Ink(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
            child: InkWell(
                onTap: () => {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(
                              builder: (context) => PetDetailPage(
                                    id: id,
                                  )))
                    },
                borderRadius: BorderRadius.circular(10.0),
                splashColor: AppTheme.colors.pink,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
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
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true)
                .push(
                    MaterialPageRoute(builder: (context) => const PetAddPage()))
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
