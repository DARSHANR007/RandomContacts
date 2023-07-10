import 'dart:convert';
import 'package:http/http.dart' as http;

class RandomUserApi {
  Future<List<Map<String, dynamic>>> getData() async {
    final uri = Uri.parse('https://randomuser.me/api/?results=500');
    var data = await http.get(uri);
    if (data.statusCode == 200) {
      var userdata = jsonDecode(data.body)['results']; // Access 'results' directly
      List<Map<String, dynamic>> getList = [];
      for (var x in userdata) {
        var firstname = x['name']['first'];
        var lastname = x['name']['last'];
        var mail = x['email'];
        var login = x['login']['username'];
        var image = x['picture']['thumbnail'];

        var finalData = {
          'firstname': firstname,
          'lastname': lastname,
          'mail': mail,
          'login': login,
          'image': image
        };

        getList.add(finalData);
      }
      return getList; // Move outside the loop
    } else {
      throw Exception("Failed to get data. Status code: ${data.statusCode}");

    }
  }
}
