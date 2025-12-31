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
  final List<String> variaciones = ['Even today', 'You will', 'You can', 'Always', 'Buddy,', 'Time to', ''];
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
      estaCargando = false;
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
        title: Text(
          'Go to menu',
          style: TextStyle(
            fontFamily: 'BBHBOGLE',
            fontSize: 28,
          ),
        ),
        centerTitle: false,
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
  String? valorSeleccionado = '1 minute';
  final List<String> opciones = ['1 minute', '5 minutes', '30 minutes', '1 hour', '1 day'];
  final Map<String, int> mapaMinutos = {
    '1 minute': 1,
    '5 minutes': 5,
    '30 minutes': 30,
    '1 hour': 60,
    '1 day': 1440,
  };
  @override
  void initState(){
    super.initState();
    _initPrefs();
    _cargarNombrePorDefecto();
  }
  Future<void> _cargarNombrePorDefecto() async{
    final prefs = await SharedPreferences.getInstance();
    String nombreGuardado = prefs.getString('nombre_del_usuario') ?? '';
    controlador.text = nombreGuardado;
  }
  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    String? guardado = prefs.getString('intervalo_texto');
    if (guardado != null && opciones.contains(guardado)){
      setState(() {
        valorSeleccionado = guardado;
      });
    }
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
          'Back to home',
          style: TextStyle(
            fontFamily: 'BBHBOGLE',
            fontSize: 28,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                style: TextStyle(
                  fontFamily: 'BBHBOGLE',
                  fontSize: 17,
                  color: Colors.white, 
                ),
                controller: controlador,
                decoration: InputDecoration(
                  labelText: 'Write your name',
                  labelStyle: TextStyle(
                    fontFamily: 'BBHBOGLE',
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: DropdownButtonFormField<String>(
                initialValue: valorSeleccionado,
                decoration: InputDecoration(
                  labelText: 'Interval of reminder',
                  labelStyle: TextStyle(
                    fontFamily: 'BBHBOGLE',
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                ),
                dropdownColor: Colors.grey[900],
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'BBHBOGLE',
                  fontSize: 17,
                ),
                icon: Icon(Icons.arrow_drop_down, color: Colors.white,),
                items: opciones.map((String opcion){
                  return DropdownMenuItem<String>(
                    value: opcion,
                    child: Text(opcion),
                  );
              }).toList(),
              onChanged: (String? nuevoValor){
                setState(() {
                  valorSeleccionado = nuevoValor;
                });
              },
            ),
            ),
            SizedBox(height: 40,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(
                  fontFamily: 'BBHBOGLE',
                  fontSize: 20,
                ),
              ),
              onPressed: () async{
                 await prefs.setString('nombre_del_usuario', controlador.text);
                 if(valorSeleccionado != null){
                  int minutos = mapaMinutos[valorSeleccionado] ?? 1;
                  await prefs.setInt('intervalo_minutos', minutos);
                  await prefs.setString('intervalo_texto', valorSeleccionado!);
                 }
                 Navigator.pop(context, true);
              },
              child: Text('Save'),
            )
          ],
        ) 
        ) 
    );
  }
  @override
  void dispose(){
    controlador.dispose();
    super.dispose();
  }
}