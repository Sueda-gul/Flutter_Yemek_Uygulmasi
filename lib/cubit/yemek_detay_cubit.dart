import 'package:bitirme_projesi/entity/sepet_yemekler.dart';
import 'package:bitirme_projesi/repository/yemeklerdao_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YemekDetayCubit extends Cubit<List<SepetYemekler>> {
  YemekDetayCubit():super(<SepetYemekler>[]);

  var yrepo = YemeklerDaoRepo();

  Future<void> sepeteEkle(int sepet_yemek_id, String yemek_adi, String yemek_resim_adi, int yemek_fiyat, int yemek_siparis_adet) async {
    await yrepo.sepeteYemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet);
  }

}