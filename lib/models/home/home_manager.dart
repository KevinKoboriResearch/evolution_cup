import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/home/section.dart';

class HomeManager extends ChangeNotifier {
  
  // HomeManager(){
  //   _loadSections();
  // }

  final List<Section> _sections = [];

  List<Section> _editingSections = [];

  bool editing = false;
  bool loading = false;
  
  Future<void> _loadSections(String companyId) async {
    FirebaseFirestore.instance.collection('companies').doc('$companyId').collection('categories').orderBy('pos').snapshots().listen((snapshot) {
      _sections.clear();
      for(final DocumentSnapshot document in snapshot.docs){
        _sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }

  void addSection(Section section){
    _editingSections.add(section);
    notifyListeners();
  }

  void removeSection(Section section){
    _editingSections.remove(section);
    notifyListeners();
  }

  List<Section> get sections {
    if(editing)
      return _editingSections;
    else
      return _sections;
  }

  void enterEditing(){
    editing = true;

    _editingSections = _sections.map((s) => s.clone()).toList();

    notifyListeners();
  }

  Future<void> saveEditing(String companyId) async {
    bool valid = true;
    for(final section in _editingSections){
      if(!section.valid()) valid = false;
    }
    if(!valid) return;

    loading = true;
    notifyListeners();

    int pos = 0;
    for(final section in _editingSections){
      await section.save(companyId, pos);
      pos++;
    }

    for(final section in List.from(_sections)){
      if(!_editingSections.any((element) => element.id == section.id)){
        await section.delete();
      }
    }

    loading = false;
    editing = false;
    notifyListeners();
  }

  void discardEditing(){
    editing = false;
    notifyListeners();
  }

}