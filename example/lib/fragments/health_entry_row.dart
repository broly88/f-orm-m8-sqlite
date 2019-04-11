import 'package:example/models/independent.g.m8.dart';
import 'package:flutter/material.dart';

typedef HealthEntryRowActionCallback = void Function(
    HealthEntryProxy healthEntry);

class HealthEntryRow extends StatelessWidget {
  HealthEntryRow({
    this.healthEntry,
    this.onPressed,
  }) : super(key: ObjectKey(healthEntry));

  final HealthEntryProxy healthEntry;

  final HealthEntryRowActionCallback onPressed;

  GestureTapCallback _getHandler(HealthEntryRowActionCallback callback) {
    return callback == null ? null : () => callback(healthEntry);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 6.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor))),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                  children: <Widget>[
                    Expanded(flex: 1, child: Text(healthEntry.description)),
                    Expanded(
                      flex: 2,
                      child: Text(
                        healthEntry.diagnosysDate.toString(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline:
                      DefaultTextStyle.of(context).style.textBaseline),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.orange,
              onPressed: _getHandler(onPressed),
            ),
          ],
        ),
      ),
    );
  }
}
