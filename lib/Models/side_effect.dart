import 'package:cloud_firestore/cloud_firestore.dart';

class SideEffect {
  String userId, other, startDate;
  bool eyesight,
      yellowEye,
      ringing,
      tingling,
      bruises,
      bleeding,
      jointPains,
      rashes,
      mood,
      weightLoass,
      tiredness,
      seizures,
      itchiness,
      darkUrine,
      orangeUrine,
      stomachPain;

  SideEffect(
      this.userId,
      this.other,
      this.startDate,
      this.eyesight,
      this.yellowEye,
      this.ringing,
      this.tingling,
      this.bleeding,
      this.bruises,
      this.darkUrine,
      this.itchiness,
      this.jointPains,
      this.mood,
      this.orangeUrine,
      this.rashes,
      this.seizures,
      this.stomachPain,
      this.tiredness,
      this.weightLoass);

  Map<String, dynamic> toJson() => _sideEffectToJson(this);

  SideEffect.fromSnapshot(DocumentSnapshot snapshot)
      : userId = snapshot['UserId'],
        other = snapshot['Other'],
        startDate = snapshot['UserSideEffectStartDate'],
        eyesight = snapshot['Eyesight Worsening (EYE)'],
        yellowEye = snapshot['Yellowing of Eyes (EYE)'],
        ringing = snapshot['Ringing Sound (EARS)'],
        tingling = snapshot['Tingling Sensation (ARMS/LEGS)'],
        bleeding = snapshot['Bleeding (ARMS/LEGS)'],
        bruises = snapshot['Bruises (ARMS/LEGS)'],
        jointPains = snapshot['Joint Pains (ARMS/LEGS)'],
        rashes = snapshot['Rashes (ARMS/LEGS)'],
        mood = snapshot['Mood Worsening/Changes (GENERAL)'],
        orangeUrine = snapshot['Orange urine (URINE)'],
        seizures = snapshot['Seizures (GENERAL)'],
        stomachPain =
            snapshot['Stomach pain (particularly right upper area) (GENERAL)'],
        tiredness = snapshot['Tiredness (GENERAL)'],
        weightLoass = snapshot['Weight Loss (GENERAL)'],
        darkUrine = snapshot['Dark urine (URINE)'],
        itchiness = snapshot['Itchiness (GENERAL)'];
}

//? Converts map of values from Firestore into SideEffect object.
SideEffect sideEffectFromJson(Map<dynamic, dynamic> json) {
  return SideEffect(
      json['UserId'] as String,
      json['Other'] as String,
      json['UserSideEffectStartDate'] as String,
      json['Eyesight Worsening (EYE)'] as bool,
      json['Yellowing of Eyes (EYE)'] as bool,
      json['Ringing Sound (EARS)'] as bool,
      json['Tingling Sensation (ARMS/LEGS)'] as bool,
      json['Bleeding (ARMS/LEGS)'] as bool,
      json['Bruises (ARMS/LEGS)'] as bool,
      json['Joint Pains (ARMS/LEGS)'] as bool,
      json['Rashes (ARMS/LEGS)'] as bool,
      json['Mood Worsening/Changes (GENERAL)'] as bool,
      json['Orange urine (URINE)'] as bool,
      json['Seizures (GENERAL)'] as bool,
      json['Stomach pain (particularly right upper area) (GENERAL)'] as bool,
      json['Tiredness (GENERAL)'] as bool,
      json['Weight Loss (GENERAL)'] as bool,
      json['Dark urine (URINE)'] as bool,
      json['Itchiness (GENERAL)'] as bool);
}

//? Converts the SideEffect class into key/value pairs
Map<String, dynamic> _sideEffectToJson(SideEffect instance) =>
    <String, dynamic>{
      'UserId': instance.userId,
      'Other': instance.other,
      'UserSideEffectStartDate': instance.startDate,
      'Eyesight Worsening (EYE)': instance.eyesight,
      'Yellowing of Eyes (EYE)': instance.yellowEye,
      'Ringing Sound (EARS)': instance.ringing,
      'Tingling Sensation (ARMS/LEGS)': instance.tingling,
      'Bleeding (ARMS/LEGS)': instance.bleeding,
      'Bruises (ARMS/LEGS)': instance.bruises,
      'Joint Pains (ARMS/LEGS)': instance.jointPains,
      'Rashes (ARMS/LEGS)': instance.rashes,
      'Mood Worsening/Changes (GENERAL)': instance.mood,
      'Orange urine (URINE)': instance.orangeUrine,
      'Seizures (GENERAL)': instance.seizures,
      'Stomach pain (particularly right upper area) (GENERAL)':
          instance.stomachPain,
      'Tiredness (GENERAL)': instance.tiredness,
      'Weight Loss (GENERAL)': instance.weightLoass,
      'Dark urine (URINE)': instance.darkUrine,
      'Itchiness (GENERAL)': instance.itchiness,
    };
