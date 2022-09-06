import 'package:flutter/material.dart';
import 'package:rest_api_json_db/user_model.dart';
import 'package:rest_api_json_db/api_service.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.blue,
    ),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late List<UserModel>? _userModel = [];
  @override
  void initState(){
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API'),
      ),

      body: _userModel == null || _userModel!.isEmpty
        ? const Center(
          child: CircularProgressIndicator(),
        ) : ListView.builder(
          itemCount: _userModel!.length,
          itemBuilder: (context, index){
            return Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(_userModel![index].id.toString()),
                      Text(_userModel![index].username),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(_userModel![index].website),
                      Text(_userModel![index].email),
                    ],
                  )
                ],
              ),
            );
          })
    );
  }

}
