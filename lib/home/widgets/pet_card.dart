import 'package:Petamin/pet_adopt/pet_adopt.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:flutter/material.dart';

class PetCardData {
  final String name;
  final String photo;
  final String breed;
  final String sex;
  final String age;
  final double price;
  final String petId;
  final String? adoptId;

  // Constructor
  PetCardData({
    required this.name,
    required this.photo,
    required this.breed,
    required this.age,
    required this.sex,
    required this.price,
    required this.petId,
    this.adoptId,
  });
}

class PetCard extends StatelessWidget {
  const PetCard({Key? key, required this.data}) : super(key: key);

  final PetCardData data;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Ink(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
            child: InkWell(
              // onTap: () => {
              //   Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              //       builder: (context) => PetAdoptPage(
              //             id: data.petId,
              //           )))
              // },
              borderRadius: BorderRadius.circular(16.0),
              splashColor: AppTheme.colors.pink,
              child: Container(
                width: 160.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
                child: Column(
                  children: [
                    Container(
                      height: 120.0,
                      width: 160.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        image: DecorationImage(
                          image: NetworkImage(
                            data.photo,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(
                                data.name,
                                style: CustomTextTheme.label(context),
                                overflow: TextOverflow.ellipsis,
                              )),
                              (data.price != -1)
                                  ? Text(
                                      '${data.price.toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '')}\$',
                                      style: CustomTextTheme.label(context))
                                  : Text(''),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Flexible(
                                  child: Container(
                                padding: new EdgeInsets.only(right: 13.0),
                                child: Text(data.breed,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextTheme.body2(context)),
                              ))
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: AppTheme.colors.pink,
                                ),
                                child: Text(
                                  data.sex,
                                  style: CustomTextTheme.caption(context,
                                      textColor: AppTheme.colors.white),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: AppTheme.colors.grey,
                                ),
                                child: Text(
                                  '${data.age} Year',
                                  style: CustomTextTheme.caption(context,
                                      textColor: AppTheme.colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
