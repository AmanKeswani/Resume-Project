import 'package:appwrite/models.dart';
import 'package:personal_project/core/core.dart';
import 'package:personal_project/core/models/models.dart';

abstract class INotesRepo {
  FutureEither<Document> createNote({
    required Notes notes,
  });
  
}
