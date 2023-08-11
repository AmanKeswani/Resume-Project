import 'dart:convert';

import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';

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
    final client = Client();
    // Map<String, dynamic> data = json.decode(req.payload);
    Map data = json.decode(req.payload);

    // Uncomment the services you need, delete the ones you don't
    // final account = Account(client);
    // final avatars = Avatars(client);
    final database = Databases(client);
    // final functions = Functions(client);
    // final health = Health(client);
    // final locale = Locale(client);
    // final storage = Storage(client);
    // final teams = Teams(client);
    // final users = Users(client);

    if (req.variables['APPWRITE_FUNCTION_ENDPOINT'] == null ||
        req.variables['APPWRITE_FUNCTION_API_KEY'] == null) {
      print(
          "Environment variables are not set. Function cannot use Appwrite SDK.");
    } else {
      client
          .setEndpoint(req.variables['APPWRITE_FUNCTION_ENDPOINT'])
          .setProject(req.variables['APPWRITE_FUNCTION_PROJECT_ID'])
          .setKey(req.variables['APPWRITE_FUNCTION_API_KEY'])
          .setSelfSigned(status: true);

      Database batchDatabase = await database.create(
        databaseId: ID.unique(),
        name: "Batches",
      );
      Collection stdCollection = await database.createCollection(
        databaseId: batchDatabase.$id,
        collectionId: ID.unique(),
        name: data['collectionName'],
      );
      await database.createStringAttribute(
        databaseId: batchDatabase.$id,
        collectionId: stdCollection.$id,
        key: "students",
        size: 255,
        xrequired: false,
        array: true,
      );
      await database.createStringAttribute(
        databaseId: batchDatabase.$id,
        collectionId: stdCollection.$id,
        key: "std",
        size: 255,
        xrequired: true,
        // array: true,
        // xdefault: stdCollection.name,
      );
      await database.createStringAttribute(
        databaseId: batchDatabase.$id,
        collectionId: stdCollection.$id,
        key: "batchSymbol",
        size: 255,
        xrequired: true,
        // array: true,
        // xdefault: stdCollection.name,
      );
      await database.createStringAttribute(
        databaseId: batchDatabase.$id,
        collectionId: stdCollection.$id,
        key: "board",
        size: 255,
        xrequired: true,
        // array: true,
        // xdefault: stdCollection.name,
      );
      await database.createStringAttribute(
        databaseId: batchDatabase.$id,
        collectionId: stdCollection.$id,
        key: "batchNo",
        size: 255,
        xrequired: true,
        // array: true,
        // xdefault: stdCollection.name,
      );
    }

    res.json({
      'areDevelopersAwesome': true,
    });
  } catch (e) {
    res.json({'error': e.toString()});
  }
}
