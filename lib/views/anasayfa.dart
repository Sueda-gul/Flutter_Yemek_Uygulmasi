import 'package:bitirme_projesi/cubit/anasayfa_cubit.dart';
import 'package:bitirme_projesi/entity/yemekler.dart';
import 'package:bitirme_projesi/views/sepet.dart';
import 'package:bitirme_projesi/views/yemek_detay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Doyuran Lezzet",
          style: TextStyle(fontSize: 32, color: Colors.amberAccent, fontFamily: "Creepster", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Sepet()));
              },
              icon: Icon(Icons.shopping_cart_outlined, size: 30, color: Colors.amberAccent,))
        ],
      ),
      body: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
        builder: (context,yemekListesi){
          if(yemekListesi.isNotEmpty){
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5/7
              ),
              itemCount: yemekListesi.length,
              itemBuilder: (context, indeks){
                var yemek = yemekListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => YemekDetay(yemek: yemek)));
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 500.0,
                    shadowColor: Colors.teal,
                    child: SizedBox(height: 50,
                      child: Column(
                        children: [
                          Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom:32.0),
                            child: Text("${yemek.yemek_adi} - ${yemek.yemek_fiyat} TL",
                              style: TextStyle(fontFamily: "Aclonica", fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            );
          }else{ return Center();}
        }
      )
    );
  }
}