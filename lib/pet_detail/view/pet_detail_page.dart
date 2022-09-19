import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';

class PetDetailPage extends StatelessWidget {
  const PetDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: AppTheme.colors.white,
          body: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 35.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                            color: AppTheme.colors.white,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Icon(
                          Icons.arrow_back_outlined,
                          color: AppTheme.colors.green,
                        )),
                    // Your widgets here
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Container(
                    child: Center(
                        child: Container(
                      width: 60.0,
                      height: 2.0,
                      decoration: BoxDecoration(
                          color: AppTheme.colors.solidGrey,
                          borderRadius: BorderRadius.circular(2.0)),
                    )),
                    width: double.maxFinite,
                    padding: EdgeInsets.only(
                      top: 5.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                elevation: 0,
                pinned: true,
                expandedHeight: 350.0,
                stretch: true,
                onStretchTrigger: () async => {await 0},
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    "https://images.pexels.com/photos/2173872/pexels-photo-2173872.jpeg",
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                  stretchModes: [StretchMode.zoomBackground],
                ),
              ),
              SliverToBoxAdapter(
                  child: Container(
                padding: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tyler",
                          style: CustomTextTheme.heading3(
                            context,
                            textColor: AppTheme.colors.solidGrey,
                          ),
                        ),
                        Icon(Icons.edit)
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "My lovely cat <3",
                      style: CustomTextTheme.body2(context,
                          textColor: AppTheme.colors.grey),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      height: 60.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // shrinkWrap: true,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PetProperty(
                            value: "Male",
                            label: "Sex",
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          PetProperty(
                            value: "1 year",
                            label: "Age",
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          PetProperty(
                            value: "Persian",
                            label: "Breed",
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          PetProperty(
                            value: "Yes",
                            label: "Neutered",
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          PetProperty(
                            value: "1.1 kg",
                            label: "Weight",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.white,
                toolbarHeight: 0.0,
                elevation: 0,
                expandedHeight: 0.0,
                collapsedHeight: 0.0,
                titleSpacing: 0,
                automaticallyImplyLeading: false,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(48),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: TabBar(
                      indicatorColor: AppTheme.colors.green,
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              color: AppTheme.colors.green, width: 1),
                          insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0)),
                      labelColor: Colors.black,
                      unselectedLabelColor: AppTheme.colors.grey,
                      tabs: [
                        Tab(
                            icon: Icon(
                          Icons.grid_3x3_outlined,
                          // color: Colors.black,
                        )),
                        Tab(
                          icon: Icon(
                            Icons.pets,
                            // color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                  child: TabBarView(children: [
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    crossAxisCount: 3,
                  ),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    // Item rendering
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(_items[index].image),
                        ),
                      ),
                    );
                  },
                ),
                Icon(
                  Icons.pets,
                  color: Colors.black,
                )
              ]))
            ],
          )),
    );
  }
}

final List<PetPhotoItem> _items = [
  PetPhotoItem(
      "https://images.pexels.com/photos/7752793/pexels-photo-7752793.jpeg",
      "Stephan Seeber"),
  PetPhotoItem(
      "https://images.pexels.com/photos/1107807/pexels-photo-1107807.jpeg",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/2361952/pexels-photo-2361952.jpeg",
      "Liam Ganttt"),
  PetPhotoItem(
      "https://images.pexels.com/photos/667228/pexels-photo-667228.jpeg",
      "Liam Gantt"),
  PetPhotoItem(
      "https://images.pexels.com/photos/179222/pexels-photo-179222.jpeg",
      "Liam Gant"),
  PetPhotoItem("https://images.pexels.com/photos/51439/pexels-photo-51439.jpeg",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/3652805/pexels-photo-3652805.jpeg",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/160839/cat-animal-love-pet-160839.jpeg",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/4790612/pexels-photo-4790612.jpeg",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/8519611/pexels-photo-8519611.jpeg?auto=compress&cs=tinysrgb&w=1600",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/1107807/pexels-photo-1107807.jpeg?auto=compress&cs=tinysrgb&w=1600",
      "Liam Gant"),
  PetPhotoItem(
      "https://images.pexels.com/photos/7319488/pexels-photo-7319488.jpeg?auto=compress&cs=tinysrgb&w=1600",
      "Liam Gant"),
];

class PetPhotoItem {
  final String image;
  final String name;
  PetPhotoItem(this.image, this.name);
}

class PetProperty extends StatelessWidget {
  const PetProperty({
    required this.value,
    required this.label,
    Key? key,
  }) : super(key: key);
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.colors.lightGrey,
            ),
            borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: CustomTextTheme.caption(context,
                  textColor: AppTheme.colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              label,
              style: CustomTextTheme.caption(context,
                  textColor: AppTheme.colors.grey, fontSize: 12.0),
            )
          ],
        ),
      ),
    );
  }
}
