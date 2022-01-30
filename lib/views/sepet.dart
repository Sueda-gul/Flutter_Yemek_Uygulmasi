import 'package:bitirme_projesi/cubit/sepet_cubit.dart';
import 'package:bitirme_projesi/entity/sepet_yemekler.dart';
import 'package:bitirme_projesi/views/anasayfa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';

class Sepet extends StatefulWidget {
  const Sepet({Key? key}) : super(key: key);

  @override
  _SepetState createState() => _SepetState();
}
class _SepetState extends State<Sepet> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text("Sepetim", style: TextStyle(fontSize: 32, color: Colors.amberAccent, fontFamily: "Creepster", fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
          }, icon: const Icon(Icons.home, size: 30, color: Colors.amberAccent,)),
        ],
      ),
      body: BlocBuilder<SepetCubit,List<SepetYemekler>>(
          builder: (context,sepetListesi){
            context.read<SepetCubit>().sepetYukle();
            var total = 0;
            if(sepetListesi.isNotEmpty){
              return ListView.builder(
                  itemCount: sepetListesi.length,
                  itemBuilder: (context, indeks){
                    var sepet = sepetListesi[indeks];
                    total += int.parse(sepet.yemek_fiyat);
                    if(indeks == sepetListesi.indexOf(sepetListesi.last)){
                      return Column(
                          children: [
                            Card(
                              color: Colors.transparent,
                              elevation: 500,
                              shadowColor: Colors.teal,
                              child: SizedBox(height: 150,
                                child: Row(
                                  children: [
                                    Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${sepet.yemek_resim_adi}",),
                                    const Spacer(flex: 20,),
                                    Text(
                                      "${sepet.yemek_adi} \n\n${sepet.yemek_siparis_adet} adet - ${sepet.yemek_fiyat} ₺",
                                      style: TextStyle(fontFamily: "Aclonica", fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                                    ),
                                    const Spacer(flex: 80,),
                                    IconButton(onPressed: (){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              backgroundColor: Colors.teal.shade100,
                                              content: Text("Silinsin Mi ?", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                              duration: Duration(seconds: 2),
                                              action: SnackBarAction(
                                                  label: "Evet",
                                                  textColor: Colors.indigo,
                                                  onPressed: (){
                                                    context.read<SepetCubit>().sepettenSil(int.parse(sepet.sepet_yemek_id));
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          backgroundColor: Colors.teal.shade100,
                                                          content: Text("Silindi!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),),
                                                          duration: Duration(seconds: 2),
                                                        )
                                                    );
                                                  }
                                              )
                                          )
                                      );
                                    }, icon: const Icon(Icons.delete_rounded, size: 30, color: Colors.teal)),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton.extended(
                                label: Text("Sepet Tutarı : $total ₺", style: TextStyle(color: Colors.amberAccent, fontSize: 22, fontWeight: FontWeight.bold),),
                                backgroundColor: Colors.teal.shade300,
                                icon: Icon(Icons.shopping_cart_outlined, color: Colors.amberAccent,),
                                onPressed: (){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.teal.shade100,
                                      content: Text("** Siparişiniz Alındı ** 15 dk'da kapıda ** ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                      duration: Duration(seconds: 5),
                                        )
                                    );},
                              ),
                            )
                          ]
                      );
                    }
                    return Card(
                      color: Colors.transparent,
                      elevation: 500.0,
                      shadowColor: Colors.teal,
                      child: SizedBox(height: 150,
                        child: Row(
                          children: [
                            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${sepet.yemek_resim_adi}",),
                            const Spacer(flex: 20,),
                            Text("${sepet.yemek_adi} \n\n${sepet.yemek_siparis_adet} adet - ${sepet.yemek_fiyat} ₺", style: TextStyle(fontFamily: "Aclonica", fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),),
                            const Spacer(flex: 80,),
                            IconButton(onPressed: (){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.teal.shade100,
                                      content: Text("Silinsin Mi ?", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                      duration: Duration(seconds: 2),
                                      action: SnackBarAction(
                                          label: "Evet",
                                          textColor: Colors.indigo,
                                          onPressed: (){
                                            context.read<SepetCubit>().sepettenSil(int.parse(sepet.sepet_yemek_id));
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.teal.shade100,
                                                  content: Text("Silindi!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),),
                                                  duration: Duration(seconds: 2),
                                                )
                                            );
                                          }
                                      )
                                  )
                              );
                            }, icon: const Icon(Icons.delete_rounded, size: 30, color: Colors.teal)),
                          ],
                        ),
                      ),
                    );},
              );
            } else{return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset("images/cook.png",),
                ),
                Text("Sepetiniz Boş :(", style: TextStyle(fontFamily: "Aclonica", fontSize: 36, fontWeight: FontWeight.bold, color: Colors.teal),)
              ],
            );}}
      ),
    );
  }
}
