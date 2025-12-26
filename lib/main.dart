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
    setState((){
      mensajeDia = '$prefijo Stay Hard';
      estaCargando = true;
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
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuScreen()
              ),
            );
          },
        ),
      ),
      body: Center(
        child: estaCargando ? Text(
          'Stay Hard',
          style: TextStyle(
            fontFamily: 'BBHBOGLE',
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.normal,
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ) : Text(
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
      ),
    );
  }
}
class MenuScreen extends StatelessWidget{
  const MenuScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Menu',
          style: TextStyle(
            fontFamily: 'BBHBOGLE',
            color: Colors.white,
            fontSize: 28,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Here goes the menu',
          style: TextStyle(
            fontFamily: 'BBHBOGLE',
            color: Colors.white,
            fontSize: 28,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}