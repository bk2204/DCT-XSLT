# Set this to the location of the DocBook XSL-NS stylesheets.
XSL_NS			:= http://docbook.sourceforge.net/release/xsl-ns/current
# Set this to one of xalan, saxon, or xsltproc
PROCESSOR		?= xsltproc
# Set this to the java executable if using xalan or saxon.
JAVA			?= java
# Set this to the location of your jar files.
JAVA_DIR		?= /usr/share/java
# Set this to a the location of the CatalogManager.properties file.
CAT_MGR			?= /etc/xml/resolver

# You shouldn't need to edit anything below here.
COVER_GEN_SHEET	:= $(XSL_NS)/template/titlepage.xsl

COVERPAGES		:= $(wildcard docbook/fo/lib/*-coverpage.xml)
COVERPAGES_XSL	:= $(COVERPAGES:.xml=.xsl)

XERCES			:= xercesImpl xmlParserAPIs
RESOLVER_JARS	:= xml-commons-resolver-1.1
RESOLVER_RDR	:= org.apache.xml.resolver.tools.ResolvingXMLReader
RESOLVER		:= org.apache.xml.resolver.tools.CatalogResolver
XALAN			:= org.apache.xalan.xslt.Process
SAXON			:= com.icl.saxon.StyleSheet
XALAN_JARS		:= xalan2 $(XERCES) $(RESOLVER_JARS)
SAXON_JARS		:= saxon $(XERCES) $(RESOLVER_JARS)

classpath		= $(subst : ,:,$(strip $(1:%=$(JAVA_DIR)/%.jar:)))$(CAT_MGR)

java		= $(JAVA) -cp $(call classpath,$1) $2
xalan_args	= -entityresolver $(RESOLVER) -uriresolver $(RESOLVER) -out $1 -in $2 -xsl $3
saxon_args	= -x $(RESOLVER_RDR) -y $(RESOLVER_RDR) -r $(RESOLVER) -u -o $1 $2 $3
xalan		= $(call java,$(XALAN_JARS),$(XALAN)) $(call xalan_args,$1,$2,$3)
saxon		= $(call java,$(SAXON_JARS),$(SAXON)) $(call saxon_args,$1,$2,$3)
xsltproc	= xsltproc -o $1 $3 $2

all: $(COVERPAGES_XSL)

%.xsl: %.xml
	$(call $(PROCESSOR),$@,$<,$(COVER_GEN_SHEET))

clean:
	$(RM) $(COVERPAGES_XSL)
