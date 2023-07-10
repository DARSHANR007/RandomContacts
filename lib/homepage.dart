import 'package:flutter/material.dart';


import 'apiservices.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> datalist = [];
  RandomUserApi randomUserApi = RandomUserApi();

  void fetchData() async {
    List<Map<String, dynamic>> x = await randomUserApi.getData();
    setState(() {
      datalist = x;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("C O N T A C T S"),
        backgroundColor:Colors.transparent,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          var item=datalist[index];
          var fname=item['firstname'];
          var email=item['mail'];
          var dp=item['image'] as String;
          return GestureDetector(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  DetailsPage(pic:dp),
                  ),
                );
              },
                hoverColor: Colors.cyan,
               focusColor: Colors.brown,
              textColor: Colors.blue,
                title: Text(fname),
                subtitle: Text(email),
              trailing: CircleAvatar(backgroundImage:NetworkImage(dp),),

            ),
          );
        },
        itemCount: datalist.length,
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  DetailsPage({Key? key, required this.pic}) : super(key: key);

  final String pic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Picture'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Center(
        child: Transform.scale(
          scale:5,
          child: CircleAvatar(
            backgroundImage: NetworkImage(pic,scale:500*500),
          ),
        ),
      ),
    );
  }
}






