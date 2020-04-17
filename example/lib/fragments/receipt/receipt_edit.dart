import 'package:sqlite_m8_demo/models/receipt.dart';
import 'package:sqlite_m8_demo/models/receipt.g.m8.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_m8_demo/pages/helpers/db_adapter_state.dart';

class ReceiptEditPage extends StatefulWidget {
  final Receipt currentReceipt;

  ReceiptEditPage({this.currentReceipt});

  _ReceiptEditPageState createState() => _ReceiptEditPageState(currentReceipt);
}

class _ReceiptEditPageState extends DbAdapterState<ReceiptEditPage> {
  final _formKey = GlobalKey<FormState>();

  Receipt _stateReceipt;
  String title;

  _ReceiptEditPageState(this._stateReceipt);

  @override
  void initState() {
    super.initState();

    _stateReceipt = _stateReceipt ??
        ReceiptProxy(
            isBio: true,
            expirationDate: null,
            quantity: null,
            numberOfItems: null,
            storageTemperature: null,
            description: null);
  }

  Future<void> submit() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      int id = await databaseProvider.updateReceipt(_stateReceipt);
      _stateReceipt.id = id;

      Navigator.of(context).pop(_stateReceipt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title ?? "Edit Receipt"),
        actions: <Widget>[
          IconButton(
            key: Key("saveReceiptButton"),
            icon: Icon(Icons.check),
            onPressed: submit,
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              autovalidate: false,
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    key: Key("receiptDescriptionField"),
                    initialValue: _stateReceipt.description,
                    decoration: InputDecoration(
                      hintText: "Description",
                      labelText: "Description*",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter description";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _stateReceipt.description = value;
                    },
                  ),
                  TextFormField(
                    key: Key("receiptDecompositionDurationField"),
                    decoration: InputDecoration(
                      hintText: "decomposing Duration as Duration",
                      labelText: "decomposing Duration*",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter decomposingDuration";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _stateReceipt.decomposingDuration =
                          Duration(milliseconds: int.parse(value));
                    },
                  ),
                  TextFormField(
                    key: Key("receiptExpirationDateField"),
                    initialValue:
                        _stateReceipt.expirationDate.toIso8601String(),
                    decoration: InputDecoration(
                      hintText: "expiration Date (format: 2071-05-30 17:50:03)",
                      labelText: "expiration Date*",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter expirationDate";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _stateReceipt.expirationDate = DateTime.parse(value);
                    },
                  ),
                  SwitchListTile(
                      key: Key("receiptIsBioSwitch"),
                      title: const Text('Is Bio'),
                      value: _stateReceipt.isBio,
                      onChanged: (bool val) =>
                          setState(() => _stateReceipt.isBio = val)),
                  TextFormField(
                    key: Key("receiptNumberOfItemsField"),
                    initialValue: _stateReceipt.numberOfItems.toString(),
                    decoration: InputDecoration(
                      hintText: "number of Items as int",
                      labelText: "number of Items*",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter numberOfItems";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _stateReceipt.numberOfItems = int.parse(value);
                    },
                  ),
                  TextFormField(
                    key: Key("receiptNumberOfMoleculesField"),
                    decoration: InputDecoration(
                      hintText: "numberOfMolecules as bigInt",
                      labelText: "numberOfMolecules*",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter numberOfMolecules";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _stateReceipt.numberOfMolecules = BigInt.parse(value);
                    },
                  ),
                  TextFormField(
                    key: Key("receiptQuantityField"),
                    initialValue: _stateReceipt.quantity.toString(),
                    decoration: InputDecoration(
                      hintText: "quantity as double",
                      labelText: "quantity*",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter quantity";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _stateReceipt.quantity = double.parse(value);
                    },
                  ),
                  TextFormField(
                    key: Key("receiptStorageTemperatureField"),
                    initialValue: _stateReceipt.storageTemperature.toString(),
                    decoration: InputDecoration(
                      hintText: "storage Temperature as num",
                      labelText: "storage Temperature*",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter storage Temperature";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      _stateReceipt.storageTemperature = num.parse(value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
