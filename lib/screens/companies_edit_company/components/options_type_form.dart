import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mewnu/models/companies/company.dart';
import 'package:mewnu/models/companies/option_model.dart';

class OptionsTypeForm extends StatefulWidget {
  const OptionsTypeForm(this.company);

  final Company company;
  @override
  _OptionsTypeFormState createState() => _OptionsTypeFormState();
}

class _OptionsTypeFormState extends State<OptionsTypeForm> {
  // int state.value != null && state.value.toInt();
  // dynamic state.value;
  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: widget.company.type,
      validator: (type) {
        if (type == null) return 'selecione uma categoria';
        return null;
      },
      builder: (state) {
        return SizedBox(
          height: 300,
          child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  title: ListTile(
                    leading: SvgPicture.asset(
                      options[index].svg,
                      height: 30,
                      color: state.value != null && state.value.toInt() == index
                          ? Colors.deepOrange
                          : Colors.grey[600],
                    ),
                    title: Text(
                      options[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: state.value != null && state.value.toInt() == index
                            ? Colors.deepOrange
                            : Colors.grey[600],
                      ),
                    ),
                    selected: state.value != null && state.value.toInt() == index,
                  ),
                  // ),
                  children: <Widget>[
                    Column(
                      children: options[index].items.map((element) {
                        return ListTile(
                          dense: true,
                          title: Text(
                            element['title'].toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: state.value == element['value']
                                  ? Colors.deepOrange
                                  : Colors.grey[600],
                            ),
                          ),
                          selected: state.value == element['value'],
                          onTap: () {
                            // setState(() {
                              state.setValue(element['value']);
                              state.didChange(state.value);
                              // state.value = element;
                              // state.value != null && state.value.toInt() = index;
                            // });
                          },
                          // ),
                        );
                      }).toList(),
                    ),
                  ],
                  // ),
                );
              }),
        );
      },
      onSaved: (value) => widget.company.type = double.parse(value.toString()),
    );
  }
}
