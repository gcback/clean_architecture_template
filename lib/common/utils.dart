import 'package:intl/intl.dart';

String getStringBeforeFirstDigit(String input) {
  // 결과를 저장할 빈 문자열을 초기화합니다.
  String result = '';

  // 주어진 문자열의 각 문자를 순회합니다.
  for (var i = 0; i < input.length; i++) {
    // 현재 문자가 숫자인지 확인합니다.
    if (input[i].contains(RegExp(r'\d'))) {
      // 숫자를 발견하면 반복을 중단하고 지금까지의 결과를 반환합니다.
      break;
    } else {
      // 숫자가 아닌 경우, 결과 문자열에 현재 문자를 추가합니다.
      result += input[i];
    }
  }

  // 숫자가 나타나기 전까지의 문자열을 반환합니다.
  return result;
}

String convertDateTimeToMonthDayString(DateTime dateTime) {
  // 원하는 포맷을 설정합니다. 예: "MM월 dd일"
  DateFormat formatter = DateFormat('MM월dd일');
  return formatter.format(dateTime);
}
