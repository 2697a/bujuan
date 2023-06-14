// fix: INFO: Avoid using web-only libraries outside Flutter web plugin
// packages.

class HtmlHtmlElement {
  dynamic get style => null;

  dynamic setInnerHtml(String html, {NodeValidator? validator}) {}
}

class NodeValidatorBuilder extends NodeValidator {
  NodeValidatorBuilder.common();
  void add(NodeValidator validator) {}
  void allowCustomElement(String tagName,
      {UriPolicy? uriPolicy,
      Iterable<String>? attributes,
      Iterable<String>? uriAttributes}) {}
  void allowElement(String tagName,
      {UriPolicy? uriPolicy,
      Iterable<String>? attributes,
      Iterable<String>? uriAttributes}) {}
  void allowHtml5({UriPolicy? uriPolicy}) {}
  void allowImages([UriPolicy? uriPolicy]) {}
  void allowInlineStyles({String? tagName}) {}
  void allowNavigation([UriPolicy? uriPolicy]) {}
  @override
  bool allowsAttribute(Element element, String attributeName, String value) {
    return true;
  }

  @override
  bool allowsElement(Element element) {
    return true;
  }

  void allowSvg() {}
  void allowTagExtension(String tagName, String baseName,
      {UriPolicy? uriPolicy,
      Iterable<String>? attributes,
      Iterable<String>? uriAttributes}) {}
  void allowTemplating() {}
  void allowTextElements() {}
}

abstract class Element {}

abstract class NodeValidator {
  bool allowsAttribute(Element element, String attributeName, String value);
  bool allowsElement(Element element);
}

abstract class UriPolicy {
  bool allowsUri(String uri);
}
