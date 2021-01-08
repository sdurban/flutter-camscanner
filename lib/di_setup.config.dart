// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service/generate_pdf_service.dart';
import 'service/io_scanned_document_repository.dart';
import 'service/ocr_space_pdf_to_text_service.dart';
import 'service/pdf_to_text_service.dart';
import 'service/scanned_document_repository.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<PdfToTextService>(() => OcrSpacePdfToTextService());
  gh.lazySingleton<ScannedDocumentRepository>(
      () => IoScannedDocumentRepository());
  gh.lazySingleton<GeneratePdfService>(
      () => GeneratePdfService(get<ScannedDocumentRepository>()));
  return get;
}
