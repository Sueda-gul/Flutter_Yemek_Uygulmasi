import 'package:bitirme_projesi/entity/sepet_yemekler.dart';
import 'package:bitirme_projesi/repository/yemeklerdao_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetCubit extends Cubit<List<SepetYemekler>>{
  SepetCubit(): super(<SepetYemekler>[]);
  var yrepo = YemeklerDaoRepo();

  Future<void> sepetYukle() async {
    var liste = await yrepo.sepetiGetir();
    emit(liste);
  }

  Future<void> sepettenSil(int sepet_yemek_id) async{
    await yrepo.sepettenYemekSil(sepet_yemek_id);
    await sepetYukle();
  }
}