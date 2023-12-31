// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';

class Lecon {
  int? lecon_id;
  String lecon_title;
  String lecon_unique_code;
  String lecon_voice;
  String? lecon_image;
  String? lecon_description;
  int module_id;
  File? image_lecon;
  File? voice_lecon;

  Lecon({
    required this.module_id,
    required this.lecon_title,
    required this.lecon_unique_code,
    required this.lecon_voice,
    this.lecon_description,
    this.lecon_id,
    this.voice_lecon,
    this.lecon_image,
    this.image_lecon,
  });

  factory Lecon.fromMap(data) => Lecon(
        lecon_unique_code: data['lecon_unique_code'],
        module_id: data['module_id'],
        lecon_title: data['lecon_title'],
        lecon_voice: data['lecon_voice'],
        lecon_description: data['lecon_description'],
        lecon_image: data['lecon_image'],
        lecon_id: data['lecon_id'],
      );

  Map<String, dynamic> toMap() => {
        'lecon_unique_code': lecon_unique_code,
        'module_id': module_id,
        'lecon_title': lecon_title,
        'lecon_voice': lecon_voice,
        'lecon_description': lecon_description,
        if (image_lecon != null) 'lecon_image': image_lecon,
        'lecon_id': lecon_id,
      };

  Future<FormData> toAPI() async => FormData.fromMap({
        'lecon_unique_code': lecon_unique_code,
        'module_id': module_id,
        'lecon_title': lecon_title,
        'lecon_voice': await MultipartFile.fromFile(voice_lecon!.path),
        'lecon_description': lecon_description,
        if (image_lecon != null)
          'lecon_image': await MultipartFile.fromFile(image_lecon!.path),
        'lecon_id': lecon_id,
      });
}
