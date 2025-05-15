require_relative 'spec_helper'

describe :fo do
  context 'footnote' do
    it 'should number footnotes with literallayouts' do
      input = <<~XML
      <?xml version="1.0"?>
      <article xmlns="http://docbook.org/ns/docbook">
        <title/>
        <para>
          ABC<footnote><literallayout xml:space="preserve" class="normal">This is some verse
      and some more verse.</literallayout></footnote>
        </para>
      </article>
      XML
      doc = XSLTTest.process(input: input, cvt: 'docbook/fo/style/base/cvt.xsl')
      expect(doc.xpath('//fo:block/fo:footnote/fo:footnote-body/fo:block/fo:inline/text()', XSLTTest::DEFAULT_NAMESPACES).to_s).to eq '1'
    end
  end
end
