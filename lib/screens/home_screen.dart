import 'package:flutter/material.dart';
import 'package:namer_app/widgets/random_phrase.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context){
    final String? texto = ModalRoute.of(context)?.settings.arguments as String?;
    final String frase = Phrase.fraseAleatoria; 
    return Scaffold(
      appBar: AppBar(
        
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 150,),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home', style: TextStyle(fontFamily: 'BBHBOGLE'),),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Home selected.', style: TextStyle(fontFamily: 'BBHBOGLE'),),)
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings', style: TextStyle(fontFamily: 'BBHBOGLE'),),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings selected.', style: TextStyle(fontFamily: 'BBHBOGLE'),),)
              );
            },
          )
          ],
        ),
      ),
      body: Center(
        child: Padding(padding: const EdgeInsets.all(25.0),
        child: Text(
          '$frase $texto',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'BBHBOGLE', letterSpacing: 3),
          textAlign: TextAlign.center,
        ),),
      ),
    );
  }
}