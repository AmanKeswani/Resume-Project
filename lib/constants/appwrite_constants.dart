class AppwriteConstants {
  static const projectID = '64b8f32f6e086ff3dca3';
  static const endPoint = 'http://10.5.67.215:80/v1';
  static bool selfSigned = true;

  static const databaseID = '64ddd7d5c29a5d3a97a3';

  static const notesCollectionId = '64ddd7d658df6049c20f';
  static const syllabusCollectionId = '64ddd7d64c838e3c35d0';
  static const batchesCollectioId = '64ddd7d63f0f87d2cec1';
  static const marksCollectionId = '64ddd7d62fc5f02c6903';
  static const attendanceCollectionId = '64ddd7d621c5ebe65b0c';
  static const lecturesCollectionId = '64ddd7d613a263fd79bd';
  static const testsCollectionId = '64ddd7d6044482fbf439';
  static const facultyCollectionId = '64ddd7d5eae4f0dd6c07';
  static const studentsCollectionId = '64ddd7d5dcd84fc555ad';

  static const notesBucketId = '64df126e59b04168e746';
  static const practiceSheetBucketId = '';

  static String notesBucketFileUrl(String imageId) =>
      '$endPoint/storage/buckets/$notesBucketId/files/$imageId/view?project=$projectID&mode=admin';
  static String practiceSheetsBucketFileUrl(String imageId) =>
      '$endPoint/storage/buckets/$notesBucketId/files/$imageId/view?project=$projectID&mode=admin';

  // static const gbInBytes = 1073741824;

  const AppwriteConstants._();
}
