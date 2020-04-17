import 'package:sqlite_m8_demo/fragments/receipt/receipt_row.dart';
import 'package:sqlite_m8_demo/models/receipt.dart';
import 'package:sqlite_m8_demo/pages/helpers/db_adapter_state.dart';
import 'package:sqlite_m8_demo/pages/helpers/snack_presenter.dart';
import 'package:sqlite_m8_demo/routes/enhanced_route.dart';
import 'package:flutter/material.dart';

class ReceiptsFragment extends StatefulWidget {
  final Key _parentScaffoldKey;
  ReceiptsFragment(this._parentScaffoldKey);

  _ReceiptsFragmentState createState() =>
      _ReceiptsFragmentState(_parentScaffoldKey);
}

class _ReceiptsFragmentState extends DbAdapterState<ReceiptsFragment> {
  List<Receipt> receipts = [];

  var _parentScaffoldKey;

  _ReceiptsFragmentState(this._parentScaffoldKey);

  @override
  void initState() {
    super.initState();
    _loadAsyncCurrentData().then((result) => setState(() => receipts = result));
  }

  Future<List<Receipt>> _loadAsyncCurrentData() async {
    return await databaseProvider.getReceiptProxiesAll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: receipts.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return ReceiptRow(
                  receipt: receipts[index],
                  onPressedDelete: (h) {
                    _deleteReceipt(h);
                  },
                  onPressedUpdate: (h) {
                    _updateReceipt(h);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  key: Key("addReceiptButton"),
                  onPressed: () {
                    _addReceipt();
                  },
                  tooltip: "Add Receipt",
                  child: Icon(Icons.add)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addReceipt() async {
    final result = await Navigator.of(context).push(EnhancedRoute.addReceipt());

    if (result != null) {
      receipts.add(result);
    }

    _showMessage("Receipt added");
  }

  Future<void> _updateReceipt(Receipt receipt) async {
    await Navigator.of(context).push(EnhancedRoute.editReceipt(receipt));

    receipts.removeWhere((item) => item.id == receipt.id);
    receipts.add(receipt);
    setState(() {});

    _showMessage("Receipt updated");
  }

  Future<void> _deleteReceipt(Receipt h) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Confirm Delete Receipt"),
        actions: <Widget>[
          FlatButton(
            key: Key("confirmDeleteReceiptButton"),
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              _deleteReceiptFromDatabase(h);
            },
          ),
          FlatButton(
            key: Key("cancelDeleteReceiptButton"),
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _deleteReceiptFromDatabase(Receipt h) async {
    await databaseProvider.deleteReceipt(h.id);
    receipts.remove(h);
    setState(() {});

    _showMessage("Receipt deleted");
  }

  void _showMessage(String message) {
    SnackPresenter.showInfo(message, _parentScaffoldKey);
  }
}
