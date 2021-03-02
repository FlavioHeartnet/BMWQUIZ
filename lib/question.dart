import 'package:http/http.dart' as http;
import 'dart:convert';

class Questions {
   int id;
   String question;
   String anwser;

  Questions({this.id, this.question, this.anwser});



   static List<Questions> fromJson(Map<String, dynamic> json) {
     List<Questions> list;
       json.forEach((key, value) {
         list.add(
             Questions(
               question: json['Question'],
               anwser: json['Anwser'],
             )
         );
       });

       return list;

   }


   static Future<List<Questions>> getAnwsers() async {
      //Caso não consiga fazer a API roda Local usar estes Mocks abaixo ( descomentar este codigo comentado )
     /*return (<Questions>[
       Questions(id: 1, anwser: "Germany", question: "BMW"),
       Questions(id: 2, anwser: "Japan", question: "Toyota"),
       Questions(id: 3, anwser: "England", question: "Mini"),
       Questions(id: 4, anwser: "USA", question: "General Motors"),
       Questions(id: 5, anwser: "England", question: "Rolls-Royce")
     ]);*/

     //Abaixo subistituir a url local para o local host criado do seu IISExpress ou usar pacote node iisexpress-proxy
     // site: https://www.npmjs.com/package/iisexpress-proxy e rodar iisexpress-proxy 'suaPorta' to 3000
     // e colocar na URL abaixo
      final response = await http.get(Uri.https('http://192.168.0.11/BMWQUIZ/QUIZ', ''));

      if (response.statusCode == 200) {

        return fromJson(jsonDecode(response.body));


      } else {

        throw Exception('Failed to load API');
      }
   }


}