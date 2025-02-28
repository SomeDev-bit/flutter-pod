import 'package:freezed_annotation/freezed_annotation.dart';


part 'order_item.freezed.dart';
part 'order_item.g.dart';


@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    @JsonKey(name: '_id') required String id,
    @Default(0) int totalAmount,
    @Default([]) List<OrderData> products

  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}


@freezed
class OrderData with _$OrderData {
  const factory OrderData({

   required String title,
   required String description,
    required int price,
    required String category,
    required String brand,
    required String image,
    required String qty,

}) = _OrderData;

  factory OrderData.fromJson(Map<String, dynamic> json) =>
      _$OrderDataFromJson(json);
}
