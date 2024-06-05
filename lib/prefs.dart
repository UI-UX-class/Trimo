import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SetPrefs {
  // 싱글톤 인스턴스를 생성
  static final SetPrefs _instance = SetPrefs._internal();

  // SharedPreferences 인스턴스를 저장할 변수
  late SharedPreferences prefs;

  // factory 키워드를 사용하여 싱글톤 인스턴스를 반환합니다.
  factory SetPrefs() {
    return _instance;
  }

  // private constructor
  SetPrefs._internal();

  // SharedPreferences를 초기화하는 비동기 함수입니다.
  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  // JWT 토큰을 SharedPreferences에 저장하는 함수입니다.
  Future<void> setJwtToken(String token) async {
    await prefs.setString('jwt_token', token);
  }

  // SharedPreferences에서 JWT 토큰을 읽어오는 함수입니다.
  String? getJwtToken() {
    return prefs.getString('jwt_token');
  }

  // SharedPreferences에서 JWT 토큰을 삭제하는 함수입니다.
  Future<void> removeJwtToken() async {
    await prefs.remove('jwt_token');
  }
}