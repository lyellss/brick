/// bool 扩展
extension ExtensionBool on bool {
  /// 取相反值
  bool get not => !this;
}

extension ExtensionBoolNullAble on bool? {
  bool get value {
    if (this == null) {
      return false;
    }
    return this!;
  }

  /// 取相反值
  bool get not {
    if (this == null) {
      return false;
    }
    return this!.not;
  }
}
