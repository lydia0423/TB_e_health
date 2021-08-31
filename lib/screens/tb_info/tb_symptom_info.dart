import 'package:flutter/material.dart';
import 'package:tb_e_health/screens/shared/common_app_bar.dart';

class SymptomsInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(title: 'Symptoms of Tuberculosis'),
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey)),
                child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'Typical symptoms of TB include:\n'
                      '- a persistent cough that lasts more than 3 weeks and usually brings up phlegm, which may be bloody\n'
                      '- Weight loss\n- Night sweats\n- High Temperature\n- Tiredness and Fatigue\n'
                      '- Lost of appetite\n- Swellings in the neck\n\n'
                      'You should see a GP if you have a cough that lasts more than 3 weeks or you cough up blood.\n',
                      style: TextStyle(fontSize: 18),
                    )))
          ],
        ));
  }
}
