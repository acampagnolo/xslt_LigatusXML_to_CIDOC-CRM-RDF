<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="book/markers/yes">
        <xsl:variable name="count" select="count(marker)"/>
        <xsl:result-document href="{$filepath_markers}" method="xml" indent="yes" encoding="utf-8">
            <rdf:RDF>
                <xsl:call-template name="namespaceDeclaration"/>
                <xsl:for-each select="marker">
                    <crm:E22_Man-Made_Object>
                        <xsl:attribute name="rdf:about"
                            select="
                                concat($filename_markers, '#', $filename_fragment_markers, (if ($count eq 1) then
                                    ''
                                else
                                    position()))"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2837">
                                <rdfs:label xml:lang="en">bookmarks</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <xsl:apply-templates>
                            <xsl:with-param name="markerSetNo" select="position()"/>
                        </xsl:apply-templates>
                        <crm:P46i_forms_part_of>
                            <crm:E22_Man-Made_Object>
                                <xsl:attribute name="rdf:about"
                                    select="concat($filename_main, '#', $fileref)"/>
                            </crm:E22_Man-Made_Object>
                        </crm:P46i_forms_part_of>
                    </crm:E22_Man-Made_Object>
                </xsl:for-each>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="pageMarker">
        <xsl:param name="markerSetNo"/>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2945">
                <rdfs:label xml:lang="en">leaf tab markers</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <!-- Types of pagemarkers are only assigned to a P3_has_note -->
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="type/element()/name()"/>
        </xsl:call-template>
        <xsl:choose>
            <xsl:when test="attachment/adhesive">
                <xsl:call-template name="attachmentMethod-adhered">
                    <xsl:with-param name="component" select="$filename_markers"/>
                    <xsl:with-param name="ID" select="$markerSetNo"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="attachment/sewn">
                <xsl:call-template name="attachmentMethod-sewn">
                    <xsl:with-param name="component" select="$filename_markers"/>
                    <xsl:with-param name="ID" select="$markerSetNo"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="attachment/other">
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="text()"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="material/tawedSkin">
                <xsl:call-template name="materialtawedSkin">
                    <xsl:with-param name="component" select="$filename_markers"/>
                    <xsl:with-param name="ID" select="$markerSetNo"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="material/tannedSkin">
                <xsl:call-template name="materialtannedSkin">
                    <xsl:with-param name="component" select="$filename_markers"/>
                    <xsl:with-param name="ID" select="$markerSetNo"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="material/parchment">
                <xsl:call-template name="materialParchment">
                    <xsl:with-param name="component" select="$filename_markers"/>
                    <xsl:with-param name="ID" select="$markerSetNo"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="material/textile">
                <xsl:call-template name="materialtextile">
                    <xsl:with-param name="component" select="$filename_markers"/>
                    <xsl:with-param name="ID" select="$markerSetNo"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="material/silk">
                <xsl:call-template name="materialsilk">
                    <xsl:with-param name="component" select="$filename_markers"/>
                    <xsl:with-param name="ID" select="$markerSetNo"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="material/other">
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="text()"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="location//head">
                <crm:P55_has_current_location>
                    <crm:E53_place>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_main, '#headPlace')"/>
                    </crm:E53_place>
                </crm:P55_has_current_location>
            </xsl:when>
            <xsl:when test="location//tail">
                <crm:P55_has_current_location>
                    <crm:E53_place>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_main, '#tailPlace')"/>
                    </crm:E53_place>
                </crm:P55_has_current_location>
            </xsl:when>
            <xsl:when test="location//foredge">
                <crm:P55_has_current_location>
                    <crm:E53_place>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_main, '#fore-edgePlace')"/>
                    </crm:E53_place>
                </crm:P55_has_current_location>
            </xsl:when>
            <xsl:when test="location/other">
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="text()"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="boardMarker">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="name(.)"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="bookmark">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="name(element())"/>
        </xsl:call-template>
    </xsl:template>

</xsl:stylesheet>
