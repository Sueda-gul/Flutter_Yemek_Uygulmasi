import 'package:bitirme_projesi/entity/sepet_yemekler.dart';

class SepetCevap {
  List<SepetYemekler> sepetListesi;
  int success;

  SepetCevap({required this.sepetListesi, required this.success});

  factory SepetCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["sepet_yemekler"] as List;
    List<SepetYemekler> sepetListesi = jsonArray.map((e) => SepetYemekler.fromJson(e)).toList();
    return SepetCevap(sepetListesi: sepetListesi, success: json["success"] as int);
  }
}