import 'package:dart_appwrite/dart_appwrite.dart';

/*
  'req' variable has:
    'headers' - object with request headers
    'payload' - request body data as a string
    'variables' - object with function variables

  'res' variable has:
    'send(text, status: status)' - function to return text response. Status code defaults to 200
    'json(obj, status: status)' - function to return JSON response. Status code defaults to 200
  
  If an error is thrown, a response with code 500 will be returned.
*/

Future<void> start(final req, final res) async {
  try {
    print({"reached": "point 1"});
    final client = Client();
    print({"reached": "point 2"});

    // Uncomment the services you need, delete the ones you don't
    // final account = Account(client);
    // final avatars = Avatars(client);
    final database = Databases(client);
    print({"reached": "point 3"});

    // final functions = Functions(client);
    // final health = Health(client);
    // final locale = Locale(client);
    // final storage = Storage(client);
    // final teams = Teams(client);
    // final users = Users(client);

    if (req.variables['APPWRITE_FUNCTION_ENDPOINT'] == null ||
        req.variables['APPWRITE_FUNCTION_API_KEY'] == null) {
      print({"reached": "point 4"});
      print(
          "Environment variables are not set. Function cannot use Appwrite SDK.");
      print({"reached": "point 5"});
    } else {
      print({"reached": "point 6"});
      client
          .setEndpoint(req.variables['APPWRITE_FUNCTION_ENDPOINT'])
          .setProject(req.variables['APPWRITE_FUNCTION_PROJECT_ID'])
          .setKey(req.variables['APPWRITE_FUNCTION_API_KEY'])
          .setSelfSigned(status: true);
      print({"reached": "point 7"});

      var abc = await database.create(
        databaseId: ID.unique(),
        name: "Batches",
      );
      print(abc.toString());
      print({"reached": "point 8"});
    }

    print({"reached": "point 9"});
    res.json({
      'areDevelopersAwesome': true,
    });
    print({"reached": "point 10"});
  } catch (e) {
    print({"reached": "point 11"});
    res.json({'error': e.toString()});
  }
}
