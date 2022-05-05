import "package:flutter/material.dart";
import "dart:io";
import "dart:convert";
import "package:path_provider/path_provider.dart";
import "GroceryListItem.dart";

class GroceryList extends ChangeNotifier {
  String _groceryListName;
  List<GroceryListItem> _groceryItems;

  GroceryList() {
    _groceryListName = "Grocery List";
    _groceryItems = [];
    load();
  }

  void load() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    var dataFile = File("${documentsDirectory.path}/data.json");

    var dataFileExists = await dataFile.exists();
    if (dataFileExists) {
      String fileContents = await dataFile.readAsString();
      print("Raw Json: ${fileContents}");
      Map<String, dynamic> userMap = jsonDecode(fileContents);

      _groceryListName = userMap["groceryListName"] ?? "Grocery List";
      if (userMap["groceryItems"] != null &&
          userMap["groceryItems"].length > 0) {
        var jsonMapItems = List.from(userMap["groceryItems"]);
        var groceryItems =
            jsonMapItems.map((item) => GroceryListItem.fromJson(item)).toList();
        _groceryItems.addAll(groceryItems);
      }
    }
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> retVal = {
      "groceryListName": _groceryListName,
      "groceryItems": _groceryItems.map((item) => item.toJson()).toList(),
    };

    return retVal;
  }

  void writeAllDataToFile() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    var dataFile = File("${documentsDirectory.path}/data.json");

    String listAsJson = jsonEncode(this);
    print("Encoded Json: ${listAsJson}");
    await dataFile.writeAsString(listAsJson);
  }

  void updateGroceryListName(String newName) async {
    if (newName.isNotEmpty) {
      _groceryListName = newName;
      writeAllDataToFile();
      notifyListeners();
    }
  }

  String get groceryListName => _groceryListName;
  List<GroceryListItem> get groceryItems => _groceryItems;

  int get numberOfItems => _groceryItems.fold(
      0, (value, item) => item.hasBeenPurchased ? value : value + 1);

  void addGroceryItem(GroceryListItem item) {
    _groceryItems.add(item);
    writeAllDataToFile();
    notifyListeners();
  }

  void togglePurchased(int pos) {
    _groceryItems[pos].hasBeenPurchased = !_groceryItems[pos].hasBeenPurchased;
    writeAllDataToFile();
    notifyListeners();
  }

  void removeGroceryItem(int pos) {
    _groceryItems.removeAt(pos);
    writeAllDataToFile();
    notifyListeners();
  }
}
