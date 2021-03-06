import 'package:sqlite_m8_demo/fragments/gym/gym_place_row.dart';
import 'package:sqlite_m8_demo/models/gym_location.g.m8.dart';
import 'package:sqlite_m8_demo/pages/helpers/db_adapter_state.dart';
import 'package:sqlite_m8_demo/pages/helpers/snack_presenter.dart';
import 'package:flutter/material.dart';

class GymPlacesFragment extends StatefulWidget {
  final Key _parentScaffoldKey;

  GymPlacesFragment(this._parentScaffoldKey);

  _GymPlacesFragmentState createState() =>
      _GymPlacesFragmentState(_parentScaffoldKey);
}

class _GymPlacesFragmentState extends DbAdapterState<GymPlacesFragment> {
  List<GymLocationProxy> gymLocations;

  final TextEditingController _gymLocationController = TextEditingController();

  bool _validate = false;

  var _parentScaffoldKey;

  _GymPlacesFragmentState(this._parentScaffoldKey);

  @override
  void initState() {
    super.initState();

    if (gymLocations == null) {
      print("Init State load is called");
      gymLocations = [];
      _loadAsyncCurrentData().then((result) {
        setState(() {
          print("Loading database result is $result");
        });
      });
    }
  }

  Future<bool> _loadAsyncCurrentData() async {
    gymLocations = await databaseProvider.getGymLocationProxiesAll();
    return true;
  }

  Widget _container() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: TextField(
                      key: Key('gymLocation'),
                      controller: _gymLocationController,
                      decoration: InputDecoration(
                        hintText: "Type a short description",
                        labelText: "New Gym Place Entry",
                        errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      ),
                      onSubmitted: (text) async {
                        _saveGymLocation(text);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: RaisedButton(
                      key: Key('addGymPlaceButton'),
                      onPressed: () {
                        _saveGymLocation(_gymLocationController.value.text);
                      },
                      child: Icon(Icons.add,
                          color: Theme.of(context).accentIconTheme.color),
                      shape: CircleBorder(),
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gymLocations.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return GymLocationRow(
                  gymLocation: gymLocations[index],
                  onPressed: (h) {
                    _deleteGymLocation(h);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _container();
  }

  Future<void> _saveGymLocation(String text) async {
    try {
      if (_gymLocationController.text.isEmpty) {
        setState(() {
          _validate = true;
        });
        return;
      }

      var tempGymLocation = GymLocationProxy();
      tempGymLocation.description = text;
      var newId = await databaseProvider.saveGymLocation(tempGymLocation);
      tempGymLocation.id = newId;

      gymLocations.add(tempGymLocation);
      _gymLocationController.clear();

      setState(() {
        _validate = false;
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _deleteGymLocation(GymLocationProxy h) async {
    try {
      await databaseProvider.deleteGymLocation(h.id);
      gymLocations.remove(h);

      setState(() {});
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    SnackPresenter.showError(message, _parentScaffoldKey);
  }
}
