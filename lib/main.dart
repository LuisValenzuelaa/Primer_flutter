import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  String mensajeDia = 'Stay Hard';
  String nombre = '';
  bool estaCargando = true;
  final List<String> variaciones = ['Even today', 'You will', 'You can', 'Always', 'Friend, ', 'Time to', ''];
  @override
  void initState(){
    super.initState();
    _verificarNuevoDia();
  }
  Future<void> _verificarNuevoDia() async{
    final prefs = await SharedPreferences.getInstance();
    final DateTime ahora = DateTime.now();
    final int diaActual = ahora.day;
    final int ultimoDiaGuardado = prefs.getInt('ultimo_dia_guardado') ?? 0;
    String prefijo;
    if(ultimoDiaGuardado != diaActual){
      prefijo = variaciones[Random().nextInt(variaciones.length)];
      await prefs.setInt('ultimo_dia_guardado', diaActual);
      await prefs.setString('prefijo_del_dia', prefijo);
    }else{
      prefijo = prefs.getString('prefijo_del_dia') ?? '';
    }
    setState(() {
      mensajeDia = '$prefijo Stay Hard';
      estaCargando = true;
      nombre = prefs.getString('nombre_del_usuario') ?? '';
    });
  }
  Future<void> _cargarNombre() async {
      final prefs = await SharedPreferences.getInstance();
      setState((){
        nombre = prefs.getString('nombre_del_usuario') ?? '';
      });
    }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 32,
          ),
          onPressed: () async{
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuScreen()
              ),
            );
            if (result == true){
              _cargarNombre();
            }
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
          mensajeDia,
          style: TextStyle(
            fontFamily: 'BBHBOGLE',
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.normal,
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          nombre,
          style: TextStyle(
            fontFamily: 'BBHBOGLE',
            fontSize: 28,
            color: Colors.amber,
            fontWeight: FontWeight.normal,
            letterSpacing: 1.5,
          ),
        ),
        ],)
      ),
    );
  }
}
class MenuScreen extends StatefulWidget{
  const MenuScreen({super.key});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}
class _MenuScreenState extends State<MenuScreen>{
  final TextEditingController controlador = TextEditingController();
  late SharedPreferences prefs;
  @override
  void initState(){
    super.initState();
    _initPrefs();
  }
  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Menu',
          style: TextStyle(
            fontFamily: 'BBHBOGLE',
            fontSize: 28,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 60,
                child: TextField(
                style: TextStyle(
                  fontFamily: 'BBHBOGLE',
                  fontSize: 17,
                  color: Colors.white,
                ),
                controller: controlador,
                decoration: const InputDecoration(
                  labelText: 'Write your name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  labelStyle: TextStyle(
                    fontFamily: 'BBHBOGLE',
                    fontSize: 17,
                    color: Colors.grey,
                  )
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white,),
                textStyle: TextStyle(
                  fontFamily: 'BBHBOGLE',
                  fontSize: 20,
                ),
              ),
              onPressed: () async{
                await prefs.setString('nombre_del_usuario', controlador.text);
                Navigator.pop(context, true);
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose(){
    controlador.dispose();
    super.dispose();
  }
}