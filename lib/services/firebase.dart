import 'package:budget_tracking_app/model/category_total_model.dart';
import 'package:budget_tracking_app/model/daily_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<List<DailyModel>?> get() async {
    try {
      var snapshot = await firestore.collection('daily').get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((e) => DailyModel.fromMap(e.data())).toList();
      }
      return null;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<List<CategoryTotalModel>> getTotalPriceByCategory() async {
    try {
      var snapshot = await firestore.collection('daily').get();
      if (snapshot.docs.isNotEmpty) {
        // Buat map untuk menyimpan total price berdasarkan category
        Map<String, double> totalPriceByCategory = {
          'asset/auto.png': 0,
          'asset/bank.png': 0,
          'asset/cash.png': 0,
          'asset/charity.png': 0,
          'asset/eating.png': 0,
          'asset/gift.png': 0,
        };

        // Iterasi melalui dokumen snapshot untuk menghitung total price berdasarkan category
        snapshot.docs.forEach((doc) {
          var data = doc.data() as Map<String, dynamic>;
          var dailyModel = DailyModel.fromMap(data);

          // Periksa apakah category sudah ada dalam map
          if (totalPriceByCategory.containsKey(dailyModel.icon)) {
            // Jika sudah ada, tambahkan harga dari daily model ke total price kategori tersebut
            totalPriceByCategory[dailyModel.icon] =
                totalPriceByCategory[dailyModel.icon]! + double.parse(dailyModel.price);
          }
        });

        // Buat list CategoryTotalModel dari map totalPriceByCategory
        List<CategoryTotalModel> result = totalPriceByCategory.entries
            .map((entry) => CategoryTotalModel(
                  category: entry.key,
                  totalPrice: entry.value,
                ))
            .toList();

        return result;
      }
      return [];
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> addDaily(DailyModel daily) async {
    try {
      var doc = firestore.collection('daily').doc();
      daily.id = doc.id;
      await doc.set(daily.toMap());
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> deleteDaily(String nId) async {
    try {
      var doc = firestore.collection('daily').doc(nId);
      await doc.delete();
    } catch (e) {
      throw e.toString();
    }
  }

  // static Future<void> updateNote(NoteModel note, String uid, String nId) async {
  //   try {
  //     var doc = firestore.collection('notes').doc(uid).collection('note').doc(nId);
  //     note.id = nId;
  //     await doc.update(note.toMap());
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  // static Future<void> remindNote(String noteId, DateTime? reminder, bool isReminder) async {
  //   try {
  //     await firestore.collection('notes').doc(auth.currentUser!.uid).collection('note').doc(noteId).update({
  //       'reminder': isReminder ? reminder : null,
  //       'isReminder': isReminder,
  //     });
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  // static Future<String> uploadImage(XFile file, String name) async {
  //   try {
  //     var imageFile = await file.readAsBytes();

  //     UploadTask task = storage.ref('images/$name.jpg').putData(
  //           imageFile,
  //           SettableMetadata(contentType: 'image/jpeg'),
  //         );

  //     String url = await task.then((value) {
  //       return value.ref.getDownloadURL();
  //     });
  //     return url;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  // static Future<void> logout() async {
  //   await auth.signOut();
  // }
}
