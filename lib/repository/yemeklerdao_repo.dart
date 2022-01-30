import 'package:bitirme_projesi/entity/sepet_yemekler.dart';
import 'package:bitirme_projesi/entity/sepet_yemekler_cevap.dart';
import 'package:bitirme_projesi/entity/yemekler.dart';
import 'package:bitirme_projesi/entity/yemekler_cevap.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class YemeklerDaoRepo {
  List<Yemekler> parseYemekCevap(String cevap) {
    var a = YemeklerCevap.fromJson(json.decode(cevap)).yemekListesi;
    return a;
  }
  List<SepetYemekler> parseSepetCevap(String cevap) {
    return SepetCevap.fromJson(json.decode(cevap)).sepetListesi;
  }

  Future<List<Yemekler>> tumYemekleriGetir() async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
    var cevap = await http.get(url);

    return parseYemekCevap(cevap.body);
  }
  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi, int yemek_fiyat, int yemek_sipari_adet) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    var veri = {
      "yemek_adi": yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat.toString(),
      "yemek_siparis_adet": yemek_sipari_adet.toString(),
      "kullanici_adi": "Süeda"};
    var cevap = await http.post(url, body: veri);
    print("Sepet kayıt : ${cevap.body}");
  }

  Future<List<SepetYemekler>> sepetiGetir() async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var veri = {"kullanici_adi": "Süeda"};
    var cevap = await http.post(url, body: veri);
    var liste = <SepetYemekler>[];
    try{
      return parseSepetCevap(cevap.body);
    }catch(e){
      return liste;
    }
  }
  Future<void> sepettenYemekSil(int sepet_yemek_id) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var veri = {"kullanici_adi": "Süeda", "sepet_yemek_id": sepet_yemek_id.toString() };
    var cevap = await http.post(url, body: veri);
    print("Sepetten yemek sil : ${cevap.body}");
  }
}
