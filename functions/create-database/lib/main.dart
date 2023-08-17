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
  final client = Client();

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

  client
      .setEndpoint('http://192.168.251.189:80/v1')
      .setProject(req.variables['APPWRITE_FUNCTION_PROJECT_ID'])
      .setKey(
          '374d5900f2399ea3c290c1128b65bdd31ff42ec01f2312af2f30da6466698bfff9ba2b2c28d1942b9ebd2c57c4664cfb46bcbda435b81370b015fc84b2019da3e943ff3958bc886edc48dfced176554eace1ee1ffb84109bc7bb6bd16e57bd2800726628fe148eb4260bc5192483d689125fa4b0c73d97e4d7163fa4825debab')
      .setSelfSigned(status: true);

  Database coreDatabase =
      await database.create(databaseId: ID.unique(), name: "Core Database");

  Collection studentCollection = await database.createCollection(
      databaseId: coreDatabase.$id,
      permissions: [
        Permission.create('any'),
        Permission.delete('any'),
        Permission.read('any'),
        Permission.update('any'),
        Permission.write('any')
      ],
      collectionId: ID.unique(),
      name: "Students");
  Collection facultyCollection = await database.createCollection(
      databaseId: coreDatabase.$id,
      permissions: [
        Permission.create('any'),
        Permission.delete('any'),
        Permission.read('any'),
        Permission.update('any'),
        Permission.write('any')
      ],
      collectionId: ID.unique(),
      name: "Faculties");
  Collection testCollection = await database.createCollection(
      databaseId: coreDatabase.$id,
      permissions: [
        Permission.create('any'),
        Permission.delete('any'),
        Permission.read('any'),
        Permission.update('any'),
        Permission.write('any')
      ],
      collectionId: ID.unique(),
      name: "Tests");
  Collection lectureCollection = await database.createCollection(
      databaseId: coreDatabase.$id,
      permissions: [
        Permission.create('any'),
        Permission.delete('any'),
        Permission.read('any'),
        Permission.update('any'),
        Permission.write('any')
      ],
      collectionId: ID.unique(),
      name: "Lectures");
  Collection attendanceCollection = await database.createCollection(
      permissions: [
        Permission.create('any'),
        Permission.delete('any'),
        Permission.read('any'),
        Permission.update('any'),
        Permission.write('any')
      ],
      databaseId: coreDatabase.$id,
      collectionId: ID.unique(),
      name: "Attendance");
  Collection marksCollection = await database.createCollection(permissions: [
    Permission.create('any'),
    Permission.delete('any'),
    Permission.read('any'),
    Permission.update('any'),
    Permission.write('any')
  ], databaseId: coreDatabase.$id, collectionId: ID.unique(), name: "Marks");
  Collection batchesCollection = await database.createCollection(permissions: [
    Permission.create('any'),
    Permission.delete('any'),
    Permission.read('any'),
    Permission.update('any'),
    Permission.write('any')
  ], databaseId: coreDatabase.$id, collectionId: ID.unique(), name: "Batches");
  Collection syllabusCollection = await database.createCollection(permissions: [
    Permission.create('any'),
    Permission.delete('any'),
    Permission.read('any'),
    Permission.update('any'),
    Permission.write('any')
  ], databaseId: coreDatabase.$id, collectionId: ID.unique(), name: "Syllabus");
  Collection notesCollection = await database.createCollection(permissions: [
    Permission.create('any'),
    Permission.delete('any'),
    Permission.read('any'),
    Permission.update('any'),
    Permission.write('any')
  ], databaseId: coreDatabase.$id, collectionId: ID.unique(), name: "Notes");

  //////////////////////////////////////////// Student Collection //////////////////////////////////////////////
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: studentCollection.$id,
      key: "firstName",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: studentCollection.$id,
      key: "lastName",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: studentCollection.$id,
      key: "contactNumber",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: studentCollection.$id,
      key: "fatherName",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: studentCollection.$id,
      key: "fatherContactNumber",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: studentCollection.$id,
      key: "motherName",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: studentCollection.$id,
      key: "motherContactNumber",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: studentCollection.$id,
      key: "batch",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: studentCollection.$id,
      key: "emailID",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: studentCollection.$id,
      key: "subjects",
      size: 50,
      xrequired: false,
      array: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: studentCollection.$id,
      key: "std",
      size: 50,
      xrequired: true);

//////////////////////////////////////////// Faculty Collection //////////////////////////////////////////////
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: facultyCollection.$id,
      key: "firstName",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: facultyCollection.$id,
      key: "lastName",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: facultyCollection.$id,
      key: "contactNumber",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: facultyCollection.$id,
      key: "emailID",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: facultyCollection.$id,
      key: "subjects",
      size: 50,
      array: true,
      xrequired: false);

//////////////////////////////////////////// Tests Collection //////////////////////////////////////////////\

  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: testCollection.$id,
      key: "subject",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: testCollection.$id,
      key: "topics",
      array: true,
      size: 50,
      xrequired: false);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: testCollection.$id,
      key: "batch",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: testCollection.$id,
      key: "std",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: testCollection.$id,
      key: "attendanceID",
      size: 50,
      xrequired: false);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: testCollection.$id,
      key: "marksID",
      size: 50,
      xrequired: false);
  await database.createIntegerAttribute(
      databaseId: coreDatabase.$id,
      collectionId: testCollection.$id,
      key: "startTime",
      xrequired: true);
  await database.createIntegerAttribute(
      databaseId: coreDatabase.$id,
      collectionId: testCollection.$id,
      key: "endTime",
      xrequired: true);

//////////////////////////////////////////// Lecture Collection //////////////////////////////////////////////

  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: lectureCollection.$id,
      key: "subject",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: lectureCollection.$id,
      key: "facultyUID",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: lectureCollection.$id,
      key: "batch",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: lectureCollection.$id,
      key: "std",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: lectureCollection.$id,
      key: "attendanceID",
      size: 50,
      xrequired: false);
  await database.createIntegerAttribute(
      databaseId: coreDatabase.$id,
      collectionId: lectureCollection.$id,
      key: "startTime",
      xrequired: true);
  await database.createIntegerAttribute(
      databaseId: coreDatabase.$id,
      collectionId: lectureCollection.$id,
      key: "endTime",
      xrequired: true);

//////////////////////////////////////////// Attendance Collection //////////////////////////////////////////////

  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: attendanceCollection.$id,
      key: "lectureTestID",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: attendanceCollection.$id,
      key: "students",
      size: 50,
      xrequired: false,
      array: true);
  await database.createBooleanAttribute(
      databaseId: coreDatabase.$id,
      collectionId: attendanceCollection.$id,
      key: "presenty",
      xrequired: false,
      array: true);

//////////////////////////////////////////// Marks Collection //////////////////////////////////////////////

  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: marksCollection.$id,
      key: "testID",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: marksCollection.$id,
      key: "students",
      size: 50,
      xrequired: false,
      array: true);
  await database.createIntegerAttribute(
      databaseId: coreDatabase.$id,
      collectionId: marksCollection.$id,
      key: "marks",
      xrequired: false,
      array: true);

//////////////////////////////////////////// Batches Collection //////////////////////////////////////////////

  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: batchesCollection.$id,
      key: "students",
      size: 50,
      xrequired: false,
      array: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: batchesCollection.$id,
      key: "board",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: batchesCollection.$id,
      key: "std",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: batchesCollection.$id,
      key: "batchSymbol",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: batchesCollection.$id,
      key: "batchCategory",
      size: 50,
      xrequired: true);

//////////////////////////////////////////// Syllabus Collection //////////////////////////////////////////////

  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: syllabusCollection.$id,
      key: "subject",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: syllabusCollection.$id,
      key: "std",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: syllabusCollection.$id,
      key: "board",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: syllabusCollection.$id,
      key: "topics",
      size: 50,
      xrequired: false,
      array: true);

//////////////////////////////////////////// Notes Collection //////////////////////////////////////////////

  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: notesCollection.$id,
      key: "subject",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: notesCollection.$id,
      key: "std",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: notesCollection.$id,
      key: "board",
      size: 50,
      xrequired: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: notesCollection.$id,
      key: "topics",
      size: 50,
      xrequired: false,
      array: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: notesCollection.$id,
      key: "notesFileId",
      size: 50,
      xrequired: false,
      array: true);
  await database.createStringAttribute(
      databaseId: coreDatabase.$id,
      collectionId: notesCollection.$id,
      key: "practiceSheetFileId",
      size: 50,
      xrequired: false,
      array: true);

  // if (req.variables['APPWRITE_FUNCTION_ENDPOINT'] == null ||
  //     req.variables['APPWRITE_FUNCTION_API_KEY'] == null) {
  //   print(
  //       "Environment variables are not set. Function cannot use Appwrite SDK.");
  // } else {
  //   client
  //       .setEndpoint(req.variables['APPWRITE_FUNCTION_ENDPOINT'])
  //       .setProject(req.variables['APPWRITE_FUNCTION_PROJECT_ID'])
  //       .setKey(req.variables['APPWRITE_FUNCTION_API_KEY'])
  //       .setSelfSigned(status: true);
  // }

  // res.json({
  //   'areDevelopersAwesome': true,
  // });
}
