import 'package:flutter/material.dart';

class SideEffectInfo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            Container(
              height: 100,
              width: 500,
              child: Center(
                child: Text(
                  'Side Effects of Tuberculosis',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets. all(20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
                child:Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'Like all medicines, the medicine you take to cure TB infection can have side effects.\n\n'
                          'Tell your doctor right away if you have:\n\n'
                          '- Dizziness when sitting, standing or lying down.\n'
                          '- Less appetite\n- Stomach upset, nausea/vomiting\n- Pain in your lower chest or heartburn.\n- Flu-like symptoms with fever\n'
                          '- Severe tiredness or weakness.\n- Fevers or chills.\n- Severe diarrhea or light colored stools (poop).\n'
                          '- Brown, tea-colored, or cola-colored urine.\n\n'
                          'Read more about the side effects of TB treatment OR schedule a call with our staff. \n',
                      style: TextStyle(fontSize: 18),
                    )
                )
            )
          ],
        ),
      ),
    );
  }
}