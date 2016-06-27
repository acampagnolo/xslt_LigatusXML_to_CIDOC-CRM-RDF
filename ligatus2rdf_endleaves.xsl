<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="book/endleaves">
        <xsl:for-each select="child::element()">
            <xsl:choose>
                <xsl:when test="yes">
                    <xsl:call-template name="endleaves">
                        <xsl:with-param name="side" select="name()"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="other">
                        <xsl:variable name="side" select="name()"/>
                        <xsl:variable name="param-filename_fragment"
                            select="
                                concat($filename_fragment_endleaves, (if ($side eq 'left') then
                                    'Lft'
                                else
                                    'Rgt'))
                                "/>
                        <xsl:variable name="param-filename"
                            select="concat($fileref, '_', $param-filename_fragment, '.rdf')"/>
                        <xsl:variable name="param-filepath"
                            select="concat('../RDF/', $fileref, '/', $param-filename)"/>
                        <xsl:result-document href="{$param-filepath}" method="xml" indent="yes"
                            encoding="utf-8">
                            <rdf:RDF>
                                <xsl:call-template name="namespaceDeclaration"/>
                                <crm:E22_Man-Made_Object>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($param-filename, '#', $param-filename_fragment)"/>
                                    <crm:P2_has_type>
                                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1317">
                                            <rdfs:label xml:lang="en">endleaves</rdfs:label>
                                        </crm:E55_Type>
                                    </crm:P2_has_type>
                                    <xsl:call-template name="other">
                                        <xsl:with-param name="value" select="other"/>
                                    </xsl:call-template>
                                    <crm:P55_has_current_location>
                                        <crm:E53_place>
                                            <xsl:attribute name="rdf:about"
                                                select="concat($filename_main, '#', $side, 'Place')"/>
                                        </crm:E53_place>
                                    </crm:P55_has_current_location>
                                    <crm:P46i_forms_part_of>
                                        <crm:E22_Man-Made_Object>
                                            <xsl:attribute name="rdf:about"
                                                select="concat($filename_main, '#bookblock')"/>
                                        </crm:E22_Man-Made_Object>
                                    </crm:P46i_forms_part_of>
                                </crm:E22_Man-Made_Object>
                            </rdf:RDF>
                        </xsl:result-document>                    
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="endleaves">
        <xsl:param name="side"/>
        <xsl:variable name="param-filename_fragment"
            select="
                concat($filename_fragment_endleaves, (if ($side eq 'left') then
                    'Lft'
                else
                    'Rgt'))
                "/>
        <xsl:variable name="param-filename"
            select="concat($fileref, '_', $param-filename_fragment, '.rdf')"/>
        <xsl:variable name="param-filepath"
            select="concat('../RDF/', $fileref, '/', $param-filename)"/>
        <xsl:result-document href="{$param-filepath}" method="xml" indent="yes" encoding="utf-8">
            <rdf:RDF>
                <xsl:call-template name="namespaceDeclaration"/>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about"
                        select="concat($param-filename, '#', $param-filename_fragment)"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1317">
                            <rdfs:label xml:lang="en">endleaves</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <xsl:apply-templates mode="type"/>
                    <crm:P55_has_current_location>
                        <crm:E53_place>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_main, '#', $side, 'Place')"/>
                        </crm:E53_place>
                    </crm:P55_has_current_location>
                    <xsl:apply-templates mode="endleaves">
                        <xsl:with-param name="side" select="$side"/>
                        <xsl:with-param name="filepath" select="$param-filepath"/>
                        <xsl:with-param name="filename" select="$param-filename"/>
                        <xsl:with-param name="filename_fragment" select="$param-filename_fragment"/>
                    </xsl:apply-templates>
                    <crm:P46i_forms_part_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_main, '#bookblock')"/>
                        </crm:E22_Man-Made_Object>
                    </crm:P46i_forms_part_of>
                </crm:E22_Man-Made_Object>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>

    <xsl:template
        match=".//drawingDone[parent::drawing/parent::yes/parent::element()/parent::endleaves]"
        name="lineDrawings">
        <xsl:param name="counter" select="1"/>
        <xsl:param name="side"/>
        <xsl:param name="filepath"/>
        <xsl:param name="filename"/>
        <xsl:param name="filename_fragment"/>
        <xsl:variable name="side_frg"
            select="
                if ($side eq 'left') then
                    'Lft'
                else
                    'Rgt'"/>
        <xsl:variable name="type"
            select="
                if ($counter eq 1) then
                    'structure'
                else
                    'use'"/>
        <xsl:choose>
            <xsl:when test="$SVG eq 'yes'">
                <crm:P138i_has_representation>
                    <crm:E36_Visual_Item>
                        <xsl:attribute name="rdf:about"
                            select="concat('../SVG/', $fileref, '/', $fileref, '_', $filename_fragment, $side_frg, '_', $type, '.svg')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300100194">
                                <rdfs:label xml:lang="en">line drawing</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E36_Visual_Item>
                </crm:P138i_has_representation>
                <!-- Calls the template twice for the two kinds of drawings: use and structure -->
                <xsl:choose>
                    <xsl:when test="$counter lt 2">
                        <xsl:call-template name="lineDrawings">
                            <xsl:with-param name="counter" select="$counter + 1"/>
                            <xsl:with-param name="side" select="$side"/>
                            <xsl:with-param name="filepath" select="$filepath"/>
                            <xsl:with-param name="filename_fragment" select="$filename_fragment"/>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match=".//type/separate" mode="type">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1573">
                <rdfs:label xml:lang="en">separate endleaves</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match=".//type/integral" mode="type">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1398">
                <rdfs:label xml:lang="en">integral endleaves</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="units" mode="endleaves">
        <xsl:param name="side"/>
        <xsl:param name="filepath"/>
        <xsl:param name="filename"/>
        <xsl:param name="filename_fragment"/>
        <xsl:for-each select="unit">
            <xsl:variable name="unitNo" select="number"/>
            <crm:P46_is_composed_of>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about" select="concat($filename, '#u', $unitNo)"/>
                    <crm:P48_has_preferred_identifier>
                        <xsl:comment>NB: blank node</xsl:comment>
                        <crm:E42_identifier>
                            <crm:P3_has_note
                                rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger">
                                <xsl:value-of select="$unitNo"/>
                            </crm:P3_has_note>
                        </crm:E42_identifier>
                    </crm:P48_has_preferred_identifier>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2887">
                            <rdfs:label xml:lang="en">endleaf units</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <xsl:apply-templates mode="endleaves">
                        <xsl:with-param name="side" select="$side"/>
                        <xsl:with-param name="filepath" select="$filepath"/>
                        <xsl:with-param name="filename" select="$filename"/>
                        <xsl:with-param name="filename_fragment" select="$filename_fragment"/>
                        <xsl:with-param name="unitNo" select="$unitNo"/>
                    </xsl:apply-templates>
                </crm:E22_Man-Made_Object>
            </crm:P46_is_composed_of>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="components" mode="endleaves">
        <xsl:param name="side"/>
        <xsl:param name="filepath"/>
        <xsl:param name="filename"/>
        <xsl:param name="filename_fragment"/>
        <xsl:param name="unitNo"/>
        <xsl:for-each select=".//component">
            <xsl:variable name="compNo" select="number"/>
            <crm:P46_is_composed_of>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about"
                        select="concat($filename, '#u', $unitNo, 'c', $compNo)"/>
                    <crm:P48_has_preferred_identifier>
                        <xsl:comment>NB: blank node</xsl:comment>
                        <crm:E42_identifier>
                            <crm:P3_has_note
                                rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger">
                                <xsl:value-of select="$compNo"/>
                            </crm:P3_has_note>
                        </crm:E42_identifier>
                    </crm:P48_has_preferred_identifier>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2886">
                            <rdfs:label xml:lang="en">endleaf components</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <xsl:apply-templates mode="compType">
                        <xsl:with-param name="side" select="$side"/>
                        <xsl:with-param name="filepath" select="$filepath"/>
                        <xsl:with-param name="filename" select="$filename"/>
                        <xsl:with-param name="filename_fragment" select="$filename_fragment"/>
                        <xsl:with-param name="unitNo" select="$unitNo"/>
                        <xsl:with-param name="compNo" select="$compNo"/>
                    </xsl:apply-templates>
                </crm:E22_Man-Made_Object>
            </crm:P46_is_composed_of>
            <xsl:apply-templates mode="endleaves">
                <xsl:with-param name="side" select="$side"/>
                <xsl:with-param name="filepath" select="$filepath"/>
                <xsl:with-param name="filename" select="$filename"/>
                <xsl:with-param name="filename_fragment" select="$filename_fragment"/>
                <xsl:with-param name="unitNo" select="$unitNo"/>
                <xsl:with-param name="compNo" select="$compNo"/>
            </xsl:apply-templates>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="type" mode="compType">
        <xsl:choose>
            <xsl:when test=".[hook | outsideHook]">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1393">
                        <rdfs:label xml:lang="en">hook-type endleaves</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:choose>
                    <xsl:when test=".//endleafHook">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1316">
                                <rdfs:label xml:lang="en">endleaf-hook endleaves</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//outsideHook">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1467">
                                <rdfs:label xml:lang="en">outside-hook endleaves</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//textHook">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1662">
                                <rdfs:label xml:lang="en">text-hook endleaves</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//other">
                        <xsl:call-template name="other">
                            <xsl:with-param name="value" select=".//other"/>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="singleLeaf">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1601">
                        <rdfs:label xml:lang="en">single leaves (components)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:choose>
                    <xsl:when test="ancestor::component/pastedown/yes">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1575">
                                <rdfs:label xml:lang="en">separate pastedowns</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="guard">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1313">
                        <rdfs:label xml:lang="en">endleaf guards</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="fold">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1338">
                        <rdfs:label xml:lang="en">fold endleaves</rdfs:label>
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

    <xsl:template match="pastedown[yes]" mode="endleaves">
        <xsl:param name="side"/>
        <xsl:param name="filepath"/>
        <xsl:param name="filename"/>
        <xsl:param name="filename_fragment"/>
        <xsl:param name="unitNo"/>
        <xsl:param name="compNo"/>
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about"
                    select="concat($filename, '#u', $unitNo, 'c', $compNo, 'pastedown')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1493">
                        <rdfs:label xml:lang="en">pastedowns (features)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
        <xsl:choose>
            <xsl:when test=".//deckles/yes">
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename, '#u', $unitNo, 'c', $compNo, 'deckles')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1284">
                                <rdfs:label xml:lang="en">deckle edges</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E25_Man-Made_Feature>
                </crm:P56_bears_feature>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="pastedown[no]" mode="endleaves">
        <xsl:param name="side"/>
        <xsl:param name="filepath"/>
        <xsl:param name="filename"/>
        <xsl:param name="filename_fragment"/>
        <xsl:param name="unitNo"/>
        <xsl:param name="compNo"/>
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about"
                    select="concat($filename, '#u', $unitNo, 'c', $compNo, 'freeEndleaves')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3407">
                        <rdfs:label xml:lang="en">free endleaves</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
    </xsl:template>

    <xsl:template match="attachment" mode="endleaves">
        <xsl:param name="side"/>
        <xsl:param name="filepath"/>
        <xsl:param name="filename"/>
        <xsl:param name="filename_fragment"/>
        <xsl:param name="unitNo"/>
        <xsl:param name="compNo"/>
        <crm:P108i_was_produced_by>
            <crm:E12_Production>
                <xsl:attribute name="rdf:about"
                    select="concat($filename, '#endleafAttachmentEvent')"/>
                <crm:P33_used_specific_technique>
                    <crm:E29_Design_or_Procedure>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename, '#endleafAttachmentProcess')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4039">
                                <rdfs:label xml:lang="en">attaching endleaves</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E29_Design_or_Procedure>
                </crm:P33_used_specific_technique>
                <xsl:choose>
                    <xsl:when test="sewn">
                        <xsl:call-template name="attachmentMethod-sewn">
                            <xsl:with-param name="component" select="$filename"/>
                            <xsl:with-param name="ID" select="generate-id()"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="glued">
                        <xsl:call-template name="attachmentMethod-adhered">
                            <xsl:with-param name="component" select="$filename"/>
                            <xsl:with-param name="ID" select="generate-id()"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test=".//other">
                        <xsl:call-template name="other">
                            <xsl:with-param name="value" select=".//other"/>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </crm:E12_Production>
        </crm:P108i_was_produced_by>
    </xsl:template>

    <xsl:template match="material" mode="endleaves">
        <xsl:param name="side"/>
        <xsl:param name="filepath"/>
        <xsl:param name="filename"/>
        <xsl:param name="filename_fragment"/>
        <xsl:param name="unitNo"/>
        <xsl:param name="compNo"/>
        <xsl:choose>
            <xsl:when test=".//paper">
                <xsl:call-template name="materialPaper">
                    <xsl:with-param name="component" select="$filename"/>
                    <xsl:with-param name="ID"
                        select="concat('u', $unitNo, 'c', $compNo, '-', generate-id())"/>

                </xsl:call-template>
            </xsl:when>
            <xsl:when test=".//parchment">
                <xsl:call-template name="materialParchment">
                    <xsl:with-param name="component" select="$filename"/>
                    <xsl:with-param name="ID"
                        select="concat('u', $unitNo, 'c', $compNo, '-', generate-id())"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
