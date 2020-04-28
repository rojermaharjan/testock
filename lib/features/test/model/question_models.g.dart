// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    questionId: json['questionId'] as String,
    question: json['question'] as String,
    options: (json['options'] as List)
        ?.map((e) =>
            e == null ? null : Options.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isOpinion: json['isOpinion'] as bool,
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'questionId': instance.questionId,
      'question': instance.question,
      'options': instance.options,
      'isOpinion': instance.isOpinion,
    };

Options _$OptionsFromJson(Map<String, dynamic> json) {
  return Options(
    option: json['option'] as String,
    optionId: json['optionId'] as num,
    isCorrect: json['isCorrect'] as bool,
    isSelectedByUser: json['isSelectedByUser'] as bool,
  );
}

Map<String, dynamic> _$OptionsToJson(Options instance) => <String, dynamic>{
      'option': instance.option,
      'optionId': instance.optionId,
      'isCorrect': instance.isCorrect,
      'isSelectedByUser': instance.isSelectedByUser,
    };
