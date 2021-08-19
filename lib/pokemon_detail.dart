import 'package:flutter/material.dart';
import 'package:pokedex_app/model/pokedex.dart';
import 'package:palette_generator/palette_generator.dart';

class PokemonDetail extends StatefulWidget {

  Pokemon pokemon;
  PokemonDetail({this.pokemon});

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {

  PaletteGenerator paletteGenerator;
  Color baskinRenk;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    baskinRenk=Colors.orangeAccent;
    baskinRengiBul();
  }

  void baskinRengiBul()  {
    Future<PaletteGenerator> fPaletGenerator =  PaletteGenerator.fromImageProvider(NetworkImage(widget.pokemon.img));
    fPaletGenerator.then((value){
      paletteGenerator = value;
      // debugPrint("secilen renk :" + paletteGenerator.dominantColor.color.toString());

      if(paletteGenerator != null && paletteGenerator.vibrantColor != null){
        baskinRenk = paletteGenerator.vibrantColor.color;
        setState(() {

        });
      }else if(paletteGenerator != null && paletteGenerator.dominantColor != null){
        baskinRenk = paletteGenerator.dominantColor.color;
        setState(() {

        });
      }else{
        debugPrint("NULL COLOR");
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baskinRenk,
      appBar: AppBar(elevation: 0,backgroundColor: baskinRenk,title: Text(widget.pokemon.name,textAlign: TextAlign.center,),),
      body: OrientationBuilder(
        builder: (context,oriantation){
          if(oriantation==Orientation.portrait){
            return DikeyBody(context);
          }else{
            return YatayBody(context);
          }
        },
      ),
    );
  }

  Stack DikeyBody(BuildContext context) {
    return Stack(
       children: <Widget>[
         Positioned(
           height: MediaQuery.of(context).size.height*7/10,
           width: MediaQuery.of(context).size.width-20,
           left: 10,
           top: MediaQuery.of(context).size.height*0.1,
           child: Card(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
             elevation: 6,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                SizedBox(height: 72,),
                 Text(widget.pokemon.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                 Text("Height : "+widget.pokemon.weight,),
                 Text("Weight : "+widget.pokemon.height,),
                 Text("Types",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: widget.pokemon.type.map((tip)=>Chip(backgroundColor: Colors.deepOrange.shade300,label: Text(tip,style: TextStyle(color: Colors.white),),)).toList(),
                 ),
                 Text("Weakness",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                 Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: widget.pokemon.weaknesses!=null  ? widget.pokemon.weaknesses.map((weakness)=>Chip(backgroundColor: Colors.deepOrange.shade300,label: Text(weakness,style: TextStyle(color: Colors.white),),)).toList():[Text("No Weakness")]
                 ),

                 Text("Prev Evolution",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                 Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: widget.pokemon.prevEvolution!=null  ? widget.pokemon.prevEvolution.map((evolution)=>Chip(backgroundColor: Colors.deepOrange.shade300,label: Text(evolution.name,style: TextStyle(color: Colors.white),),)).toList():[Text("The First Version")]
                 ),


                 Text("Next Evolution",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                 Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: widget.pokemon.nextEvolution!=null  ? widget.pokemon.nextEvolution.map((evolution)=>Chip(backgroundColor: Colors.deepOrange.shade300,label: Text(evolution.name,style: TextStyle(color: Colors.white),),)).toList():[Text("Final Version")]
                 ),


               ],
             ),
           ),
         ),

         Align(
           alignment: Alignment.topCenter,
           child: Hero(tag: widget.pokemon.img,child: Container(
             width: 150,
             height: 150,
             child: Image.network(widget.pokemon.img,fit: BoxFit.contain,),
           ),),
         ),
       ],
    );
  }

  Widget YatayBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width-20,
      height:MediaQuery.of(context).size.height*3/4,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.deepOrange),color: Colors.white,borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Hero(tag: widget.pokemon.img,child: Container(
              width: 150,
              child: Image.network(widget.pokemon.img,fit: BoxFit.fill,),
            ),
          ),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(height: 10,),
                  Text(widget.pokemon.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text("Height : "+widget.pokemon.weight,),
                  Text("Weight : "+widget.pokemon.height,),
                  Text("Types",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.type.map((tip)=>Chip(backgroundColor: Colors.deepOrange.shade300,label: Text(tip,style: TextStyle(color: Colors.white),),)).toList(),
                  ),
                  Text("Weakness",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon.weaknesses!=null  ? widget.pokemon.weaknesses.map((weakness)=>Chip(backgroundColor: Colors.deepOrange.shade300,label: Text(weakness,style: TextStyle(color: Colors.white),),)).toList():[Text("No Weakness")]
                  ),

                  Text("Prev Evolution",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon.prevEvolution!=null  ? widget.pokemon.prevEvolution.map((evolution)=>Chip(backgroundColor: Colors.deepOrange.shade300,label: Text(evolution.name,style: TextStyle(color: Colors.white),),)).toList():[Text("The First Version")]
                  ),


                  Text("Next Evolution",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon.nextEvolution!=null  ? widget.pokemon.nextEvolution.map((evolution)=>Chip(backgroundColor: Colors.deepOrange.shade300,label: Text(evolution.name,style: TextStyle(color: Colors.white),),)).toList():[Text("Final Version")]
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
