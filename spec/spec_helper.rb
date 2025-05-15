require 'nokogiri'

class XSLTTest
  DEFAULT_NAMESPACES = {
    'db' => 'http://docbook.org/ns/docbook',
    'fo' => 'http://www.w3.org/1999/XSL/Format',
  }.freeze

  def self.transform(xslt_path, doc, params)
    path = File.join(File.dirname(__FILE__), '..', xslt_path)
    uri = "file://#{path}"
    xslt = Nokogiri::XSLT::Stylesheet.parse_stylesheet_doc(Nokogiri::XML.parse(File.read(path), url: uri))
    xslt.transform(doc, params)
  end

  def self.process(input:, cvt:, pstp: nil, params: {}, xinclude: false)
    doc = Nokogiri::XML(input)
    doc.do_xinclude if xinclude
    doc = transform(cvt, doc, params)
    doc = transform(pstp, doc, params) if pstp
    doc
  end
end
