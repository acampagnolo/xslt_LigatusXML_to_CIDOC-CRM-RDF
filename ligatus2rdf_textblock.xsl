<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="book/textLeaves">
        <xsl:result-document href="{$filepath_textblock}" method="xml" indent="yes" encoding="utf-8">
            <rdf:RDF>                
                <xsl:call-template name="namespaceDeclaration"/>
                <xsl:for-each select=".//editionMaterial">
                    <crm:E22_Man-Made_Object>
                        <xsl:variable name="editionNo">
                            <xsl:value-of select="editionNo"/>
                        </xsl:variable>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_textblock, '#', $filename_fragment_textblock, (if ($editionNo eq '1') then '' else $editionNo))"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1663">
                                <rdfs:label xml:lang="en">textblocks</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <xsl:apply-templates mode="material"/>
                        <crm:P43_has_dimensions>
                            <crm:E54_Dimension>
                                <xsl:attribute name="rdf:about"
                                    select="concat($filename_textblock, '#height')"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300055644">
                                        <rdfs:label xml:lang="en">height</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                                <crm:P91_has_unit>
                                    <crm:E58_Measuring_Unit
                                        rdf:about="http://vocab.getty.edu/aat/300379097">
                                        <rdfs:label>mm</rdfs:label>
                                    </crm:E58_Measuring_Unit>
                                </crm:P91_has_unit>
                                <crm:P90_has_value
                                    rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger">
                                    <xsl:value-of select=".//height"/>
                                </crm:P90_has_value>
                            </crm:E54_Dimension>
                        </crm:P43_has_dimensions>
                        <crm:P43_has_dimensions>
                            <crm:E54_Dimension>
                                <xsl:attribute name="rdf:about"
                                    select="concat($filename_textblock, '#width')"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300055644">
                                        <rdfs:label xml:lang="en">height</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                                <crm:P91_has_unit>
                                    <crm:E58_Measuring_Unit
                                        rdf:about="http://vocab.getty.edu/aat/300379097">
                                        <rdfs:label>mm</rdfs:label>
                                    </crm:E58_Measuring_Unit>
                                </crm:P91_has_unit>
                                <crm:P90_has_value
                                    rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger">
                                    <xsl:value-of select=".//width"/>
                                </crm:P90_has_value>
                            </crm:E54_Dimension>
                        </crm:P43_has_dimensions>
                        <crm:P46i_forms_part_of>
                            <crm:E22_Man-Made_Object>
                                <xsl:attribute name="rdf:about"
                                    select="concat($filename_main, '#bookblock')"/>
                            </crm:E22_Man-Made_Object>
                        </crm:P46i_forms_part_of>
                    </crm:E22_Man-Made_Object>
                </xsl:for-each>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="material" mode="material">
            <xsl:choose>
                <xsl:when test=".//paper">
                    <xsl:call-template name="materialPaper">
                        <xsl:with-param name="component" select="$filename_textblock"/>
                        <xsl:with-param name="ID" select="generate-id()"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test=".//parchment">
                    <xsl:call-template name="materialParchment">
                        <xsl:with-param name="component" select="$filename_textblock"/>
                        <xsl:with-param name="ID" select="generate-id()"/>
                    </xsl:call-template>
                </xsl:when>
            </xsl:choose>        
    </xsl:template>

</xsl:stylesheet>
