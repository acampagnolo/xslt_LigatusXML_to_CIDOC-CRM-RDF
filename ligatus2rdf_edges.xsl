<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="book/edges">
        <xsl:result-document href="{$filepath_edges}" method="xml" indent="yes" encoding="utf-8">
            <rdf:RDF>                
                <xsl:call-template name="namespaceDeclaration"/>
                <crm:E25_Man-Made_feature>
                    <xsl:attribute name="rdf:about"
                        select="concat($filename_edges, '#', $filename_fragment_edges)"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1226">
                            <rdfs:label xml:lang="en">bookblock edges</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <xsl:call-template name="formation"/>
                    <crm:P46i_forms_part_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_main, '#bookblock')"/>
                        </crm:E22_Man-Made_Object>
                    </crm:P46i_forms_part_of>
                </crm:E25_Man-Made_feature>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="formation">
        <xsl:choose>
            <xsl:when test="formation/cut">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1273">
                        <rdfs:label xml:lang="en">cut edges</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:apply-templates select="formation/cut"/>
            </xsl:when>
            <xsl:when test="formation/uncut">                
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3840">
                        <rdfs:label xml:lang="en">uncut edges</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                </xsl:when>
            <xsl:when test=".//other">
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select=".//other"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="cutBeforeSewing/yes">
        <crm:P108i_was_produced_by>
            <crm:E12_Production>
                <xsl:attribute name="rdf:about" select="concat($filename_edges, '#trimmingEvent')"/>
                <crm:P33_used_specific_technique>
                    <crm:E29_Design_or_Procedure>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_edges, '#trimmingTechnique')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1272">
                                <rdfs:label xml:lang="en">cut before sewing</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E29_Design_or_Procedure>
                </crm:P33_used_specific_technique>
            </crm:E12_Production>
        </crm:P108i_was_produced_by>
    </xsl:template>

    <xsl:template match="retrimmed/yes">
        <crm:P108i_was_produced_by>
            <crm:E12_Production>
                <xsl:attribute name="rdf:about" select="concat($filename_edges, '#trimmingEvent2')"/>
                <crm:P33_used_specific_technique>
                    <crm:E29_Design_or_Procedure>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_edges, '#trimming')"/>
                    </crm:E29_Design_or_Procedure>
                </crm:P33_used_specific_technique>
                <crm:P120i_occurs_after>
                    <crm:E12_Production>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_edges, '#trimmingEvent1')"/>
                        <crm:P33_used_specific_technique>
                            <crm:E29_Design_or_Procedure>
                                <xsl:attribute name="rdf:about"
                                    select="concat($filename_edges, '#trimming')"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1301">
                                        <rdfs:label xml:lang="en">edge cutting</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </crm:E29_Design_or_Procedure>
                        </crm:P33_used_specific_technique>
                    </crm:E12_Production>
                </crm:P120i_occurs_after>
            </crm:E12_Production>
        </crm:P108i_was_produced_by>
    </xsl:template>

    <xsl:template match="decoration/yes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4087">
                <rdfs:label xml:lang="en">decorated edges</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates select="types"/>
        <xsl:call-template name="colourMat">
            <xsl:with-param name="component" select="$filename_edges"/>
            <xsl:with-param name="ID" select="generate-id()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="type/coloured">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1201">
                <rdfs:label xml:lang="en-GB">coloured decoration</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type[gauffered | gilt | painted | sprinkled]">        
        <crm:P108i_was_produced_by>
            <crm:E12_Production>
                <xsl:attribute name="rdf:about" select="concat($filename_edges, '#edgeDecoration')"/>
                <crm:P33_used_specific_technique>
                    <crm:E29_Design_or_Procedure>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_edges, '#decorationTechnique')"/>
                        <crm:P2_has_type>
                            <xsl:choose>
                                <xsl:when test="gauffered">
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1355">
                                        <rdfs:label xml:lang="en">gauffering</rdfs:label>
                                    </crm:E55_Type>
                                </xsl:when>
                                <xsl:when test="gilt">
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1363">
                                        <rdfs:label xml:lang="en">gilding</rdfs:label>
                                    </crm:E55_Type>
                                </xsl:when>
                                <xsl:when test="painted">
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1476">
                                        <rdfs:label xml:lang="en">painting (techniques)</rdfs:label>
                                    </crm:E55_Type>
                                </xsl:when>
                                <xsl:when test="sprinkled">
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1628">
                                        <rdfs:label xml:lang="en">sprinkling (techniques)</rdfs:label>
                                    </crm:E55_Type>
                                </xsl:when>
                            </xsl:choose>                            
                        </crm:P2_has_type>
                    </crm:E29_Design_or_Procedure>
                </crm:P33_used_specific_technique>
            </crm:E12_Production>
        </crm:P108i_was_produced_by>
    </xsl:template>

    <xsl:template match="type/other">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="other"/>
        </xsl:call-template>
    </xsl:template>

</xsl:stylesheet>
