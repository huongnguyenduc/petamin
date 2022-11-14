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

  // Constructor
  PetCardData({
    required this.name,
    required this.photo,
    required this.breed,
    required this.age,
    required this.sex,
    required this.price,
  });
}

class PetCard extends StatelessWidget {
  const PetCard({Key? key, required this.data}) : super(key: key);

  final PetCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppTheme.colors.white),
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
                    Text(data.name, style: CustomTextTheme.body1(context)),
                    Text('${data.price}\$',
                        style: CustomTextTheme.body1(context)),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Text('Breed: ',
                        style: CustomTextTheme.body2(context,
                            textColor: AppTheme.colors.grey)),
                    Text(data.breed, style: CustomTextTheme.body2(context)),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
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
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
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
    );
  }
}
