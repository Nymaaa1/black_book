// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalSaleModel _$TotalSaleModelFromJson(Map<String, dynamic> json) =>
    TotalSaleModel(
      cost: (json['cost'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      price_money_types: (json['price_money_types'] as List<dynamic>?)
          ?.map((e) => TotalDetialSaleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      income: (json['income'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TotalSaleModelToJson(TotalSaleModel instance) =>
    <String, dynamic>{
      'cost': instance.cost,
      'price': instance.price,
      'income': instance.income,
      'count': instance.count,
      'price_money_types': instance.price_money_types,
    };
