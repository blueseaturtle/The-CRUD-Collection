import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

//COMMON FIREBASE AND FIRESTORE FUNCTIONS

//DATA STORAGE
class CloudFirestoreService {
  static dynamic _filterCollection(String collection, List<dynamic> filters,
      {sortOrder}) {
    dynamic collectionRef;

    collectionRef = FirebaseFirestore.instance.collection(collection);
    filters.forEach((filter) {
      collectionRef =
          collectionRef.where(filter['name'], isEqualTo: filter['value']);
    });
    if (sortOrder != null) {
      sortOrder.forEach((sort) {
        collectionRef.orderBy(sort['field'], descending: sort['isDescending']);
      });
    }
    return collectionRef;
  }

  static Future<dynamic> write(String collection, dynamic payload) async {
    dynamic res;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(collection);
    await collectionRef.doc(payload['id']).set(payload).then((value) {
      res = true;
    }).catchError((error) {
      print(error);
      res = false;
    });
    return res;
  }

  static Future<dynamic> read(String collection, List<dynamic> filters,
      {limit, sortOrder}) async {
    List<dynamic> data = [];
    dynamic collectionRef =
        _filterCollection(collection, filters, sortOrder: sortOrder);
    if (limit != null) collectionRef = collectionRef.limit(limit);
    await collectionRef.get().then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) data = snapshot.docs;
    });
    return limit == 1 ? (data.isNotEmpty ? data[0] : null) : data;
  }

  static Future<dynamic> update(
      String collection, List<dynamic> filters, dynamic data) async {
    dynamic collectionRef = _filterCollection(collection, filters);
    dynamic result = true;

    await collectionRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((queryDoc) {
        FirebaseFirestore.instance
            .collection(collection)
            .doc(queryDoc.id)
            .update(data)
            .catchError((error) {
          print(error);
          result = false;
        });
      });
    }).catchError((error) {
      result = false;
    });

    return result;
  }

  static Future<dynamic> delete(
      String collection, List<dynamic> filters) async {
    dynamic res = true;
    dynamic collectionRef = _filterCollection(collection, filters);
    await collectionRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((queryDoc) {
        FirebaseFirestore.instance
            .collection(collection)
            .doc(queryDoc.id)
            .delete()
            .catchError((error) {
          res = false;
        });
      });
    }).catchError((error) {
      print(error);
      res = false;
    });
    return res;
  }
}

// IMAGE FILES STORAGE
class FirebaseStorageService {
  static FirebaseStorage fireBaseStorage = FirebaseStorage.instance;

  static Future<String> uploadFile(
      File file, String fileName, String filepath) async {
    Reference storageRef = fireBaseStorage.ref().child('/$filepath/$fileName');
    TaskSnapshot uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }

  static Future<void> deleteFile(String filePath, String fileName) async {
    Reference storageRef = fireBaseStorage.ref().child('/$filePath/$fileName');

    storageRef
        .delete()
        .then((value) => print("File deleted successfully"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteAllFilesInQuizDirectory(String filePath) async {
    fireBaseStorage.ref().child('/$filePath/').listAll().then((result) => {
          result.items.forEach((imageRef) {
            imageRef
                .delete()
                .then((value) => (value) => print("File deleted successfully"))
                .catchError((e) => print(e));
          })
        });
  }
}
