// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      id: json['_id'] as String,
      totalAmount: (json['totalAmount'] as num?)?.toInt() ?? 0,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => OrderData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'totalAmount': instance.totalAmount,
      'products': instance.products,
    };

_$OrderDataImpl _$$OrderDataImplFromJson(Map<String, dynamic> json) =>
    _$OrderDataImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toInt(),
      category: json['category'] as String,
      brand: json['brand'] as String,
      image: json['image'] as String,
      qty: json['qty'] as String,
    );

Map<String, dynamic> _$$OrderDataImplToJson(_$OrderDataImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'category': instance.category,
      'brand': instance.brand,
      'image': instance.image,
      'qty': instance.qty,
    };
