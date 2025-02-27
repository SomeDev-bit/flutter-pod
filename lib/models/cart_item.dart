import 'package:hive_flutter/hive_flutter.dart';

part 'cart_item.g.dart';


@HiveType(typeId: 0)
class CartItem extends HiveObject {

  @HiveField(0)
   int qty;

  @HiveField(1)
   String title;

  @HiveField(2)
   String image;

  @HiveField(3)
    int price;

  @HiveField(4)
   String id;

  @HiveField(5)
  String description;

   CartItem({required this.qty, required this.title, required this.image, required this.price, required this.id, required this.description});


   Map<String, dynamic>  toMap (){
     return {
       'title': title,
       'description': description,
       'price': price,
       'category': '',
       'brand': '',
       'image': image,
       'qty': qty
     };
   }


}