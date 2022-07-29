import 'dart:io';

void main() {
  stdout.write("Enter Tree 1 (e.g 1,2,3):");
  String? str1 = stdin.readLineSync();
  List<int> tree1List = [];
  if(str1 != null || str1 != '') {
    tree1List = str1!.split(',').map(int.parse).toList();
  }
  stdout.write("Enter Tree 2 (e.g 1,2,3,4)");
  String? str2 = stdin.readLineSync();
  List<int> tree2List = [];
  if(str2!=null || str2 != '') {
    tree2List = str2!.split(',').map(int.parse).toList();
    tree2List.forEach((element) {
      if(element == 1){
        stdout.write("number 1 must not be in the list2");
        exit(0);
      }
    });
  }
  tree1List.sort((a,b){
    return a.compareTo(b);
  });
  tree2List.sort((a,b){
    return a.compareTo(b);
  });
  var set1 = tree1List.toSet();
  var set2 = tree2List.toSet();
  stdout.write('The answer is ${List.from(set1.difference(set2))}');
}