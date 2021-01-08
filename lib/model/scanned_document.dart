class ScannedDocument {
  String _uuid;
  String _previewImageUri;
  String _documentUri;

  ScannedDocument(this._uuid, this._previewImageUri, this._documentUri);

  String get uuid => _uuid;

  String get documentUri => _documentUri;

  String get previewImageUri => _previewImageUri;
}