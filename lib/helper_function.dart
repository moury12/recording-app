import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String get generateAudioId =>
    '<${getFormattedDate(DateTime.now(), pattern: 'yyyyMMdd_HH:mm:ss')}>.mp3';
String get generateVideoId =>
    'VID${getFormattedDate(DateTime.now(), pattern: 'yyyyMMdd_HH:mm:ss')}.mp4';
String get generateUserId =>
    'diu_${getFormattedDate(DateTime.now(), pattern: 'yyyyMMdd_HH:mm:ss')}';
String get generateNoteId =>
    '<${getFormattedDate(DateTime.now(), pattern: 'yyyyMMdd_HH:mm:ss')}>.txt';
getFormattedDate(DateTime dt, {String pattern = 'dd/MM/yyyy'}) =>
    DateFormat(pattern).format(dt);
showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),backgroundColor: Colors.lime.shade700,
      behavior: SnackBarBehavior.floating,));