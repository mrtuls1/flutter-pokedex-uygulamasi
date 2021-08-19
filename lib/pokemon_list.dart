import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex_app/pokemon_detail.dart';
import 'model/pokedex.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {

  String url= "https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json";
  Pokedex pokedex;
  Future<Pokedex> veri;


  Future<Pokedex>pokemonlariGetir() async{

    var response = await http.get(url); //response bütün yapıdır
    var decodedJson=json.decode(response.body); //response yapısını json objelerine dönüştürdük. Artık bunlar oluşturulan model sınıfındaki değerlere atanabilir
    pokedex=Pokedex.fromJson(decodedJson);   ///1 ADIM
    return pokedex;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri =pokemonlariGetir();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: OrientationBuilder(
        builder: (context,oriantation){
          if(oriantation==Orientation.portrait){
            return FutureBuilder(future: veri,builder: (context,AsyncSnapshot<Pokedex>gelenPokedex){
              if(gelenPokedex.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }                                                                  /// 2. ADIM
              else if(gelenPokedex.connectionState==ConnectionState.done){
                return GridView.count(crossAxisCount: 2,children: gelenPokedex.data.pokemon.map((poke){
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PokemonDetail(pokemon: poke,)));
                    },
                    child: Hero(tag: poke.img, child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 150,
                            width: 150,
                            child: FadeInImage.assetNetwork(placeholder: "assets/loading.gif", image: poke.img,fit: BoxFit.contain,),
                          ),
                          Text(poke.name,style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )),
                  );
                }).toList(),);

                /*GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),itemBuilder: (context,index){
            return
          });*/
              }else{
                return null;
              }
            },);
          }else{
            return FutureBuilder(future: veri,builder: (context,AsyncSnapshot<Pokedex>gelenPokedex){
              if(gelenPokedex.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }                                                                  /// 2. ADIM
              else if(gelenPokedex.connectionState==ConnectionState.done){
                return GridView.extent(maxCrossAxisExtent: 300,children: gelenPokedex.data.pokemon.map((poke){
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PokemonDetail(pokemon: poke,)));
                    },
                    child: Hero(tag: poke.img, child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 150,
                            width: 150,
                            child: FadeInImage.assetNetwork(placeholder: "assets/loading.gif", image: poke.img,fit: BoxFit.contain,),
                          ),
                          Text(poke.name,style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )),
                  );
                }).toList(),);

                /*GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),itemBuilder: (context,index){
            return
          });*/
              }else{
                return null;
              }
            },);
          }
        },
      ),
    );
  }
}
