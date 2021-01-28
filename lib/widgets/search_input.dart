import 'package:flutter/material.dart';
import 'package:movify/style/styles.dart';
import 'package:movify/views/search_results_view.dart';

import 'alert_dialog.dart';

class SearchInput extends StatefulWidget {
  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {

  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        validator: (value){
          if(value.isEmpty){
            return CustomAlertDialog.showAlertDialog(context,"Warning","Enter search keyword");
          }else return null;
        },
        controller: _searchController,
        keyboardType: TextInputType.text,
        style: kFormInputText,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search for a film...",
          hintStyle: kHintText,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.all(12),
        ),
        onFieldSubmitted: (_){
          if(_searchController.text.trim().isEmpty){
            return CustomAlertDialog.showAlertDialog(context,"Warning","Enter search keyword");
          }
          Navigator.pushNamed(context, SearchResultsScreen.route,arguments: _searchController.text.trim());
        },
      ),
    );
  }
}
