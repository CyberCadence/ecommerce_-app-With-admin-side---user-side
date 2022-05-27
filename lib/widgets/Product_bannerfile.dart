import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Productbanner extends StatelessWidget {
  const Productbanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        const Color.fromARGB(255, 255, 123, 0),
        Colors.blue.shade200
      ])),
      height: 200,
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('New Release',style: TextStyle(color: Colors.white),),
              SizedBox(
                height: 20,
              ),
              Text(
                'Cool shoes',
                style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Image(
              fit: BoxFit.cover,
              width: 125,
              image: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/shoe2.png?alt=media&token=8c9f66f4-bbfb-42f2-80ce-1811e7d7fab7'))
        ],
      ),
    );
  }
}
