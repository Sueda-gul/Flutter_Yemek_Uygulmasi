import 'package:bitirme_projesi/cubit/yemek_detay_cubit.dart';
import 'package:bitirme_projesi/entity/yemekler.dart';
import 'package:bitirme_projesi/views/sepet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YemekDetay extends StatefulWidget {
  final Yemekler yemek;
  const YemekDetay({required this.yemek});
  @override
  _YemekDetayState createState() => _YemekDetayState();
}

class _YemekDetayState extends State<YemekDetay> {
  @override
  void initState() {
    super.initState();
  }
  var adet = 0;
  var tutar = 0;
  void artis() {
    setState(() {
      adet++;
      tutar += int.parse(widget.yemek.yemek_fiyat);
    });
  }
  void azalis() {
    setState(() {
      adet--;
      tutar -= int.parse(widget.yemek.yemek_fiyat);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text(widget.yemek.yemek_adi, style: TextStyle(color: Colors.amberAccent, fontFamily: "Creepster",fontSize: 32, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}", width: 300, height: 300,),
            Text("Ücret : $tutar ₺", style: const TextStyle(fontFamily: "Aclonica",fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: (){
                      if(adet>0){ azalis(); }
                      else{ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.teal.shade200,
                            content: Text("Sipariş Adeti 0'dan Az Olamaz !!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                            duration: Duration(seconds: 2),));}},
                    child: const Icon(Icons.indeterminate_check_box_rounded, color: Colors.amberAccent, size: 40)
                ),
                Text("$adet", style: const TextStyle(fontFamily: "Aclonica", fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),),
                TextButton(onPressed: (){ artis(); }, child: const Icon(Icons.add_box_rounded, color: Colors.amberAccent, size: 40,)),
                SizedBox(width: 200, height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amberAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: Colors.teal, width: 2)
                      )
                    ),
                      onPressed: (){
                        if(adet == 0){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.teal.shade200,
                                content: Text("Sipariş Adeti 0 Olamanz!!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                duration: Duration(seconds: 2)));}
                        else{
                          context.read<YemekDetayCubit>().sepeteEkle(
                            int.parse(widget.yemek.yemek_id),
                            widget.yemek.yemek_adi,
                            widget.yemek.yemek_resim_adi,
                            int.parse(tutar.toString()),
                            int.parse(adet.toString()));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Sepet()));
                        }
                      },
                      child: const Text("Sepete Ekle", style: TextStyle(fontFamily: "Aclonica", fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal)),
                  ),
                )]
            )
          ],
        ),
      ),
    );
  }
}
