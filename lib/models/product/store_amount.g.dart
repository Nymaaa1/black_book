// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_amount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreAmountModel _$StoreAmountModelFromJson(Map<String, dynamic> json) =>
    StoreAmountModel(
      total_cost: (json['total_cost'] as num?)?.toInt(),
      total_price: (json['total_price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StoreAmountModelToJson(StoreAmountModel instance) =>
    <String, dynamic>{
      'total_cost': instance.total_cost,
      'total_price': instance.total_price,
    };
