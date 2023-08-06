import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        title: const Text('About me'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[700],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30,40,30,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage('https://static.wikia.nocookie.net/netflix/images/8/8a/Namjoohyuk_picture_.png/revision/latest?cb=20220331000804'),
              ),
            ),
            Divider(
              height: 90,
              color: Colors.blueGrey[700],
            ),
            Text('NAME',
            style: TextStyle(
              color: Colors.grey[1000],
              letterSpacing: 2.0,
              fontSize: 16,
              
            ),),
            const SizedBox(height:10.0),
            const Text('Sriman',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
              fontSize: 28,  
            ),),
            const SizedBox(height: 30),


            Text('COUNTRY',
            style: TextStyle(
              color: Colors.grey[1000],
              letterSpacing: 2.0,
              fontSize: 16,
              
            ),),
            const SizedBox(height:10.0),
            const Text('India',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
              fontSize: 28,  
            ),),
            const SizedBox(height : 30),

            Row(
              children: [
                Icon(
                  Icons.mail,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 10),
                Text('followyourdream0623@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[1000]

                ),)

              ],)

          ],
        ),
      ),


      );
  }
}