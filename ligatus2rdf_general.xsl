<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <!-- GENERAL  TEMPLATES TO BE CALLED WHERE NEEDED -->
    <xsl:template name="other">
        <xsl:param name="value"/>
        <xsl:param name="lang" select="'en'"/>
        <crm:P3_has_note>
            <xsl:attribute name="xml:lang" select="$lang"/>
            <xsl:value-of select="$value"/>
        </crm:P3_has_note>
    </xsl:template>
    
    <xsl:template name="namespaceDeclaration">
        <xsl:choose>
            <xsl:when test="$toTurtle eq 'yes'">
                <xsl:namespace name="{concat('hab_', $fileref)}"
                    select="concat($xmlbase, $filename_main, '#')"/>
                <xsl:namespace name="{concat('hab_', $fileref, '_mkr')}"
                    select="concat($xmlbase, $filename_markers, '#')"/>
                <xsl:namespace name="{concat('hab_', $fileref, '_txb')}"
                    select="concat($xmlbase, $filepath_textblock, '#')"/>
                <xsl:for-each select="/book/endleaves[node()/yes]/child::element()">
                    <xsl:variable name="side" select="name()"/>
                    <xsl:variable name="param-filename_fragment"
                        select="concat($filename_fragment_endleaves, (if ($side eq 'left') then
                        'Lft'
                        else
                        'Rgt'))
                        "/>
                    <xsl:variable name="param-filename"
                        select="concat($fileref, '_', $param-filename_fragment, '.rdf')"/>
                    <xsl:namespace name="{concat('hab_', $fileref, '_', (if ($side eq 'left') then
                        'elt'
                        else
                        'ert'))}"
                        select="concat($xmlbase, $param-filename, '#')"/>
                </xsl:for-each>
                <xsl:namespace name="{concat('hab_', $fileref, '_swg')}"
                    select="concat($xmlbase, $filename_sewing, '#')"/>
                <xsl:namespace name="{concat('hab_', $fileref, '_edg')}"
                    select="concat($xmlbase, $filename_edges, '#')"/>
                <xsl:variable name="boardsNo" select="count(/book/boards/yes/boards/board)"/>
                <xsl:for-each select="/book/boards/yes/boards/board">
                    <xsl:variable name="location" select="location/element()/name()"/>
                    <xsl:variable name="boardsItem">
                        <xsl:choose>
                            <xsl:when test="$location eq 'left'">
                                <xsl:value-of select="concat((if ($boardsNo gt 2) then concat(position(), '-') else ''), 'Lft')"/>
                            </xsl:when>
                            <xsl:when test="$location eq 'right'">
                                <xsl:value-of select="concat((if ($boardsNo gt 2) then concat(position(), '-') else ''), 'Rgt')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="position()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="param-filename_fragment"
                        select="concat($filename_fragment_boards, $boardsItem)"/>
                    <xsl:variable name="param-filename" 
                        select="concat($fileref, '_', $param-filename_fragment, '.rdf')"/>
                    <xsl:variable name="param-filepath"
                        select="concat('../RDF/', $fileref, '/', $param-filename)"/>
                    <xsl:variable name="namespaceFragment">
                        <xsl:choose>
                            <xsl:when test="$location eq 'left'">
                                <xsl:value-of select="concat((if ($boardsNo gt 2) then concat(position(), '-') else ''), 'blt')"/>
                            </xsl:when>
                            <xsl:when test="$location eq 'right'">
                                <xsl:value-of select="concat((if ($boardsNo gt 2) then concat(position(), '-') else ''), 'brt')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="position()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:namespace name="{concat('hab_', $fileref, '_', $namespaceFragment)}"
                        select="concat($xmlbase, $param-filename, '#')"/>                        
                </xsl:for-each>
                <xsl:namespace name="{concat('hab_', $fileref, '_spn')}"
                    select="concat($xmlbase, $filename_spine, '#')"/>
                <xsl:namespace name="{concat('hab_', $fileref, '_lin')}"
                    select="concat($xmlbase, $filename_lining, '#')"/>
                <xsl:for-each select="/book/endbands/yes/endband">
                    <xsl:variable name="location" select="location/element()/name()"/>
                    <xsl:variable name="param-filename_fragment"
                        select="concat($filename_fragment_endbands, (if ($location eq 'head') then
                        'Hd'
                        else
                        'Tl'))
                        "/>
                    <xsl:variable name="param-filename"
                        select="concat($fileref, '_', $param-filename_fragment, '.rdf')"/>
                    <xsl:namespace name="{concat('hab_', $fileref, '_', (if ($location eq 'head') then
                        'ehd'
                        else
                        'etl'))}"
                        select="concat($xmlbase, $param-filename, '#')"/>
                </xsl:for-each>
                <xsl:namespace name="{concat('hab_', $fileref, '_cov')}"
                    select="concat($xmlbase, $filename_covering, '#')"/>
                <xsl:namespace name="{concat('hab_', $fileref, '_frn')}"
                    select="concat($xmlbase, $filename_furniture, '#')"/>
                <xsl:namespace name="hab_act"
                    select="concat($collectionURI,'/', $collectionAcronym,'bindings/actors/', $collectionAcronym,'actors.rdf#')"/>
            </xsl:when>
        </xsl:choose>
        <xsl:attribute name="xml:base" select="$xmlbase"/>
    </xsl:template>

</xsl:stylesheet>
