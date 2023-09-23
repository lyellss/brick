/// Regex of emoji
const String REGEX_EMOJI =
    "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";

/// Regex of email
const String REGEX_EMAIL =
    r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?";

/// Regex of lowercase letter
const String REGEX_LETTER_LOWERCASE = r"^.*[a-z]+.*$";

/// Regex of web address
const String REGEX_WEB_ADDRESS =
    r"^(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$";

/// Regex of capital letter
const String REGEX_LETTER_CAPITAL = r"^.*[A-Z]+.*$";

/// Regex of same numbers limit six
const String REGEX_SAME_NUMBERS_LIMIT_SIX = r"^([0-9])\1{5}$";

/// Regex of consecutive numbers limit six
/// eg:123456
const String REGEX_CONSECUTIVE_NUMBERS =
    r"^((?:0(?=1)|1(?=2)|2(?=3)|3(?=4)|4(?=5)|5(?=6)|6(?=7)|7(?=8)|8(?=9)|9(?=0)){5}\d)$";
