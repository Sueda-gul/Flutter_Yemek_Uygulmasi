import 'package:bitirme_projesi/entity/yemekler.dart';
import 'package:bitirme_projesi/repository/yemeklerdao_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit(): super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepo();

  Future<void> yemekleriYukle() async {
    var liste = await yrepo.tumYemekleriGetir();
    emit(liste);
  }

}