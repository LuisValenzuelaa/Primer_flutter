import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override 
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController textController = TextEditingController();
  @override
  void dispose(){
    textController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
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
                  const SnackBar(content: const Text('Home selected..', style: TextStyle(fontFamily: 'BBHBOGLE'),))
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
                  const SnackBar(content: const Text('Settings selected.', style: TextStyle(fontFamily: 'BBHBOGLE')),)
                );
              }
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Center(child: Padding(padding: const EdgeInsets.all(80), 
          child: TextField(
            controller: textController,
            style: const TextStyle(fontFamily: 'BBHBOGLE'),
            decoration: const InputDecoration(
              labelText: 'Enter your name here',
              labelStyle: TextStyle(fontFamily: 'BBHBOGLE', color: Colors.grey), 
              floatingLabelStyle: TextStyle(fontFamily: 'BBHBOGLE', color: Colors.white),
              border: OutlineInputBorder(), 
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          ),
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
          ),
          ),),
          ElevatedButton(onPressed: () { 
            FocusScope.of(context).unfocus();
            final texto = textController.text;
            Navigator.pushNamed(context, '/', arguments: texto);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Settings Updated', style: TextStyle(fontFamily: 'BBHBOGLE'),)),
            );
           }, child: const Text('Save'),)
        ]
        ),
    );
  }
}