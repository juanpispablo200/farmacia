import 'package:flutter/material.dart';
import 'dart:ui';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //cuerpo del proyecto
      body: Stack(
        children: [
          Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image:  NetworkImage('https://ccq.ec/wp-content/uploads/2020/06/UIDE-1024x829.jpeg'),
            ),
          ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0), 
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                ),
            )
          ),
          //Segunda Parte
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Text('Articulos UIDE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 45.0
                ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Text('by Arisona Estate University',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 20.0
                  ),
                ),
              ),
              Container(
                //colocar primer boton
                margin: EdgeInsets.only(top: 30.0),
                width: 300.0,
                height: 40.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    )
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, 'login');
                  },
                  child: Text('Ingresar',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

