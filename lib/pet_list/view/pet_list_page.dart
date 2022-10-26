import 'package:Petamin/pet_add/view/pet_add_page.dart';
import 'package:Petamin/pet_detail/pet_detail.dart';
import 'package:Petamin/pet_list/widgets/pet_avatar.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: PetListPage());

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
                "My pet",
                style: CustomTextTheme.subtitle(context,
                    textColor: AppTheme.colors.green),
              ),
            ],
          ),
        ),
        backgroundColor: AppTheme.colors.mediumGrey,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 30.0,
            crossAxisSpacing: 35.0,
            childAspectRatio: 3 / 4,
            children: [
              PetItem(
                name: "Tyler",
                photo:
                    "https://images.unsplash.com/photo-1592194996308-7b43878e84a6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
              ),
              AddPetItem()
            ],
          ),
        ));
  }
}

class PetItem extends StatelessWidget {
  const PetItem({Key? key, required this.name, required this.photo})
      : super(key: key);

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
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => const PetDetailPage()))
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
  const AddPetItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        child: InkWell(
          onTap: () => {
            Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (context) => const PetAddPage()))
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
                  "Add new",
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
