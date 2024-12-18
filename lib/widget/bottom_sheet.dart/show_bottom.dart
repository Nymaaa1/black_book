import "package:black_book/constant.dart";
import "package:black_book/models/sale/total.dart";
import "package:black_book/util/utils.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";

class BottomSheetsWidget extends StatelessWidget {
  BottomSheetsWidget({super.key, required this.data, required this.title});
  final NumberFormat format = NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
            Text(title,
                style: const TextStyle(
                    color: kPrimarySecondColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            const Divider(),
            ListTile(
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                      "Борлуулалтын нийт үнэ: ${format.format(data.price ?? 0)}"),
                  Utils.getUserRole() == "BOSS"
                      ? Text("Цэвэр ашиг: ${format.format(data.income ?? 0)}")
                      : const SizedBox.shrink(),
                  Text(
                      "Шилжүүлэг: ${format.format(data.price_money_types!.first.amount ?? 0)}₮\nКарт: ${format.format(data.price_money_types![1].amount ?? 0)}₮\nБэлэн: ${format.format(data.price_money_types!.last.amount ?? 0)}₮"),
                  Text("Зарсан барааны тоо: ${format.format(data.count ?? 0)}"),
                ]))
          ]))),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: kPrimaryColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok", style: TextStyle(color: kWhite))))
        ]));
  }

  final String title;
  final TotalSaleModel data;
}
