class ModelParam {
  final Uri apiEndpoint;
  final String tag;
  final String cacheFileName;
  final Function setSharedReference;
  final Function getSharedReference;

  ModelParam(
      {required this.apiEndpoint,
      required this.tag,
      required this.cacheFileName,
      required this.setSharedReference,
      required this.getSharedReference});
}
