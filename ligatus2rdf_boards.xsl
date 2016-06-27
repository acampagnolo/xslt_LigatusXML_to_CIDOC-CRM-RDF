<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="book/boards">
        <xsl:choose>
            <xsl:when test="yes/boards">
                <xsl:variable name="count" select="count(board)"/>
                <xsl:for-each select="yes/boards/board">
                    <xsl:call-template name="boards">
                        <xsl:with-param name="location" select="location/element()/name()"/>
                        <xsl:with-param name="boardsNo" select="$count"/>
                    </xsl:call-template>
                </xsl:for-each>        
            </xsl:when>
            <xsl:when test="other">
                <xsl:variable name="param-filename_fragment" select="concat($filename_fragment_boards, 's')"/>
                <xsl:variable name="param-filename"
                      select="concat($fileref, '_', $param-filename_fragment, '.rdf')"/>
                <xsl:variable name="param-filepath"
                    select="concat('../RDF/', $fileref, '/', $param-filename)"/>
                <xsl:result-document href="{$param-filepath}" method="xml" indent="yes" encoding="utf-8">
                    <rdf:RDF>
                        <xsl:call-template name="namespaceDeclaration"/>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="
                                concat($param-filename, '#', $param-filename_fragment)"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1222">
                                    <rdfs:label xml:lang="en">boards</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <xsl:call-template name="other">
                                <xsl:with-param name="value" select="."/>
                            </xsl:call-template>
                        </crm:E22_Man-Made_Object>
                    </rdf:RDF>
                </xsl:result-document>        
            </xsl:when>
        </xsl:choose>        
    </xsl:template>

    <xsl:template name="boards">
        <xsl:param name="location"/>
        <xsl:param name="boardsNo"/>
        <xsl:variable name="boardsItem">
            <xsl:choose>
                <xsl:when test="$location eq 'left'">
                    <xsl:value-of
                        select="
                            concat((if ($boardsNo gt 2) then
                                concat(position(), '-')
                            else
                                ''), 'Lft')"
                    />
                </xsl:when>
                <xsl:when test="$location eq 'right'">
                    <xsl:value-of
                        select="
                            concat((if ($boardsNo gt 2) then
                                concat(position(), '-')
                            else
                                ''), 'Rgt')"
                    />
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
        <xsl:result-document href="{$param-filepath}" method="xml" indent="yes" encoding="utf-8">
            <rdf:RDF>
                <xsl:call-template name="namespaceDeclaration"/>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about"
                        select="
                            concat($param-filename, '#', $param-filename_fragment)"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1222">
                            <rdfs:label xml:lang="en">boards</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <xsl:call-template name="mechanicalAttachmentMain">
                        <xsl:with-param name="param-filename" select="$param-filename"/>
                        <xsl:with-param name="boardsItem" select="$boardsItem"/>
                        <xsl:with-param name="param-filename_fragment"
                            select="$param-filename_fragment"/>
                        <xsl:with-param name="param-filepath" select="$param-filepath"/>
                    </xsl:call-template>
                    <xsl:call-template name="bridling">
                        <xsl:with-param name="param-filename" select="$param-filename"/>
                    </xsl:call-template>
                    <xsl:choose>
                        <xsl:when test="linings/yes">
                            <xsl:variable name="liningsNo">
                                <xsl:value-of select="count(lining)"/>
                            </xsl:variable>
                            <xsl:for-each select="lining">
                                <xsl:call-template name="lining">
                                    <xsl:with-param name="boardsItem" select="$boardsItem"/>
                                    <xsl:with-param name="param-filename_fragment"
                                        select="$param-filename_fragment"/>
                                    <xsl:with-param name="param-filename" select="$param-filename"/>
                                    <xsl:with-param name="param-filepath" select="$param-filepath"/>
                                    <xsl:with-param name="liningsNo" select="$liningsNo"/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:call-template name="boardsmaterial">
                        <xsl:with-param name="boardsItem" select="$boardsItem"/>
                        <xsl:with-param name="param-filename_fragment"
                            select="$param-filename_fragment"/>
                        <xsl:with-param name="param-filename" select="$param-filename"/>
                        <xsl:with-param name="param-filepath" select="$param-filepath"/>
                        <xsl:with-param name="ID" select="generate-id(.)"/>
                    </xsl:call-template>
                    <xsl:call-template name="grainDirection">
                        <xsl:with-param name="param-filename" select="$param-filename"/>
                    </xsl:call-template>
                    <xsl:call-template name="size">
                        <xsl:with-param name="param-filename" select="$param-filename"/>
                    </xsl:call-template>
                    <xsl:choose>
                        <xsl:when test="formation/reused/yes">
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1535">
                                    <rdfs:label xml:lang="en">re-used (materials)</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:call-template name="boardThickness">
                        <xsl:with-param name="param-filename" select="$param-filename"/>
                    </xsl:call-template>
                    <xsl:call-template name="edgeTreatment">
                        <xsl:with-param name="param-filename" select="$param-filename"/>
                    </xsl:call-template>
                    <xsl:call-template name="bevels">
                        <xsl:with-param name="param-filemane" select="$param-filename"/>
                    </xsl:call-template>
                    <xsl:call-template name="edge-recesses">
                        <xsl:with-param name="param-filename" select="$param-filename"/>
                    </xsl:call-template>
                    <xsl:call-template name="tunnel-endbands">
                        <xsl:with-param name="param-filename" select="$param-filename"/>
                    </xsl:call-template>
                    <xsl:choose>
                        <xsl:when test="formation/corners/spine/backCorner">
                            <crm:P56_bears_feature>
                                <crm:E25_Man-Made_Feature>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($param-filename, '#backcorners')"/>
                                    <crm:P2_has_type>
                                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1203">
                                            <rdfs:label xml:lang="en">back-corners (board
                                                feature)</rdfs:label>
                                        </crm:E55_Type>
                                    </crm:P2_has_type>
                                    <xsl:call-template name="bevels2"/>
                                </crm:E25_Man-Made_Feature>
                            </crm:P56_bears_feature>
                        </xsl:when>
                    </xsl:choose>
                    <crm:P46i_forms_part_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_main, '#', $fileref)"/>
                        </crm:E22_Man-Made_Object>
                    </crm:P46i_forms_part_of>
                </crm:E22_Man-Made_Object>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="edge-recesses">
        <xsl:param name="param-filename"/>
        <xsl:for-each select="../../../../../book/endbands/yes/endband">
            <xsl:variable name="location" select="location/element()/name()"/>
            <xsl:choose>
                <xsl:when
                    test="cores/yes/cores/type/core/boardAttachment/yes/attachment/sewnAndRecessed">
                    <crm:P56_bears_feature>
                        <crm:E25_Man-Made_Feature>
                            <xsl:attribute name="rdf:about"
                                select="concat($param-filename, '#edgeRecesses', $location)"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2834">
                                    <rdfs:label xml:lang="en">board-edge recesses</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <crm:P156_occupies>
                                <crm:E53_Place>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($param-filename, '#', $location, 'Place')"/>
                                    <xsl:choose>
                                        <xsl:when test="$location eq 'head'">
                                            <crm:P2_has_type>
                                                <crm:E55_Type
                                                  rdf:about="http://w3id.org/lob/concept/3803">
                                                  <rdfs:label xml:lang="en">head</rdfs:label>
                                                </crm:E55_Type>
                                            </crm:P2_has_type>
                                        </xsl:when>
                                        <xsl:when test="$location eq 'tail'">
                                            <crm:P2_has_type>
                                                <crm:E55_Type
                                                  rdf:about="http://w3id.org/lob/concept/3805">
                                                  <rdfs:label xml:lang="en">tail</rdfs:label>
                                                </crm:E55_Type>
                                            </crm:P2_has_type>
                                        </xsl:when>
                                    </xsl:choose>
                                </crm:E53_Place>
                            </crm:P156_occupies>
                        </crm:E25_Man-Made_Feature>
                    </crm:P56_bears_feature>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="tunnel-endbands">
        <xsl:param name="param-filename"/>
        <xsl:for-each select="../../../../../book/endbands/yes/endband">
            <xsl:variable name="location" select="location/element()/name()"/>
            <xsl:choose>
                <xsl:when
                    test="cores/yes/cores/type/core/boardAttachment/yes/attachment/laced/tunnel/yes">
                    <crm:P56_bears_feature>
                        <crm:E25_Man-Made_Feature>
                            <xsl:attribute name="rdf:about"
                                select="concat($param-filename, '#endbandTunnel', $location)"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1690">
                                    <rdfs:label xml:lang="en">tunnels (board features)</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <crm:P156_occupies>
                                <crm:E53_Place>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($param-filename, '#', $location, 'Place')"/>
                                    <xsl:choose>
                                        <xsl:when test="$location eq 'head'">
                                            <crm:P2_has_type>
                                                <crm:E55_Type
                                                  rdf:about="http://w3id.org/lob/concept/3803">
                                                  <rdfs:label xml:lang="en">head</rdfs:label>
                                                </crm:E55_Type>
                                            </crm:P2_has_type>
                                        </xsl:when>
                                        <xsl:when test="$location eq 'tail'">
                                            <crm:P2_has_type>
                                                <crm:E55_Type
                                                  rdf:about="http://w3id.org/lob/concept/3805">
                                                  <rdfs:label xml:lang="en">tail</rdfs:label>
                                                </crm:E55_Type>
                                            </crm:P2_has_type>
                                        </xsl:when>
                                    </xsl:choose>
                                </crm:E53_Place>
                            </crm:P156_occupies>
                        </crm:E25_Man-Made_Feature>
                    </crm:P56_bears_feature>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="bevels">
        <xsl:param name="param-filemane"/>
        <xsl:for-each select="formation/bevels/node()">
            <xsl:choose>
                <xsl:when
                    test="self::centreBevels | self::claspBevels | self::internalBevels | self::cushion | self::peripheralCushion | self::other">
                    <crm:P56_bears_feature>
                        <crm:E25_Man-Made_Feature>
                            <xsl:attribute name="rdf:about"
                                select="concat($param-filemane, '#bevel', position())"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3475">
                                    <rdfs:label xml:lang="en">bevels</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <xsl:call-template name="bevels2"/>
                        </crm:E25_Man-Made_Feature>
                    </crm:P56_bears_feature>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="bevels2">
        <xsl:choose>
            <xsl:when test="self::centreBevels">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1245">
                        <rdfs:label xml:lang="en">centre bevels</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="self::claspBevels">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1253">
                        <rdfs:label xml:lang="en">clasp bevels</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="self::internalBevels">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4415">
                        <rdfs:label xml:lang="en">internal bevels</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="self::cushion | self::peripheralCushion">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1271">
                        <rdfs:label xml:lang="en">cushion (board features)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:choose>
                    <xsl:when test="self::cushion">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1349">
                                <rdfs:label xml:lang="en">full cushions (board
                                    features)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test="self::peripheralCushion">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1498">
                                <rdfs:label xml:lang="en">peripheral cushions (board
                                    features)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="self::other">
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="text()"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="edgeTreatment">
        <xsl:param name="param-filename"/>
        <xsl:choose>
            <xsl:when test="edgeTreatment[type1 | type2 | unknownGrooved]">
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#edgeGroove')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1303">
                                <rdfs:label xml:lang="en">edge grooves</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E25_Man-Made_Feature>
                </crm:P56_bears_feature>
            </xsl:when>
            <xsl:when test="edgeTreatment/other">
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="edgeTreatment/other/text()"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="boardThickness">
        <xsl:param name="param-filename"/>
        <crm:P43_has_dimensions>
            <crm:E54_Dimension>
                <xsl:attribute name="rdf:about" select="concat($param-filename, '#thickness')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300055646">
                        <rdfs:label xml:lang="en">thickness</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P91_has_unit>
                    <crm:E58_Measuring_Unit rdf:about="http://vocab.getty.edu/aat/300379097">
                        <rdfs:label>mm</rdfs:label>
                    </crm:E58_Measuring_Unit>
                </crm:P91_has_unit>
                <crm:P90_has_value rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger">
                    <xsl:value-of select="formation/boardThickness"/>
                </crm:P90_has_value>
            </crm:E54_Dimension>
        </crm:P43_has_dimensions>
    </xsl:template>

    <xsl:template name="size">
        <xsl:param name="param-filename"/>
        <xsl:choose>
            <xsl:when test="formation/size/sameSize">
                <crm:P43_has_dimensions>
                    <crm:E54_Dimension>
                        <xsl:attribute name="rdf:about" select="concat($param-filename, '#height')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300055644">
                                <rdfs:label xml:lang="en">height</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <crm:P91_has_unit>
                            <crm:E58_Measuring_Unit rdf:about="http://vocab.getty.edu/aat/300379097">
                                <rdfs:label>mm</rdfs:label>
                            </crm:E58_Measuring_Unit>
                        </crm:P91_has_unit>
                        <crm:P90_has_value
                            rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger">
                            <xsl:value-of select="ancestor::book/textLeaves//leafDimension/height"/>
                        </crm:P90_has_value>
                    </crm:E54_Dimension>
                </crm:P43_has_dimensions>
                <crm:P43_has_dimensions>
                    <crm:E54_Dimension>
                        <xsl:attribute name="rdf:about" select="concat($param-filename, '#width')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300055644">
                                <rdfs:label xml:lang="en">height</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <crm:P91_has_unit>
                            <crm:E58_Measuring_Unit rdf:about="http://vocab.getty.edu/aat/300379097">
                                <rdfs:label>mm</rdfs:label>
                            </crm:E58_Measuring_Unit>
                        </crm:P91_has_unit>
                        <crm:P90_has_value
                            rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger">
                            <xsl:value-of select="ancestor::book/textLeaves//leafDimension/width"/>
                        </crm:P90_has_value>
                    </crm:E54_Dimension>
                </crm:P43_has_dimensions>
            </xsl:when>
            <xsl:when test="formation/size/squares">
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about" select="concat($param-filename, '#squares')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1631">
                                <rdfs:label xml:lang="en">squares (boards)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E25_Man-Made_Feature>
                </crm:P56_bears_feature>
            </xsl:when>
            <xsl:when test="formation/size/undersize">
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#undersize')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4091">
                                <rdfs:label xml:lang="en">undersize</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E25_Man-Made_Feature>
                </crm:P56_bears_feature>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="bridling">
        <xsl:param name="param-filename"/>
        <xsl:choose>
            <xsl:when test="mechanicalAttachment//bridling">
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#bridling')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1231">
                                <rdfs:label xml:lang="en">bridling (board features)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E25_Man-Made_Feature>
                </crm:P56_bears_feature>
                <crm:P46_is_composed_of>
                    <crm:E22_Man-Made_Object>
                        <xsl:attribute name="rdf:about" select="concat($param-filename, '#bridles')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4420">
                                <rdfs:label xml:lang="en">bridles</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E22_Man-Made_Object>
                </crm:P46_is_composed_of>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="mechanicalAttachmentMain">
        <xsl:param name="param-filename"/>
        <xsl:param name="boardsItem"/>
        <xsl:param name="param-filename_fragment"/>
        <xsl:param name="param-filepath"/>
        <xsl:choose>
            <xsl:when test="mechanicalAttachment/yesNoNK/yes">
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#boardAttachmentFeature')"/>
                        <crm:P3_has_note xml:lang="en">board attachment</crm:P3_has_note>
                        <xsl:for-each select="mechanicalAttachment/yesNoNK/yes/types/type">
                            <crm:P108i_was_produced_by>
                                <crm:E12_Production>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($param-filename, '#boardAttachmentEvent')"/>
                                    <crm:P33_used_specific_technique>
                                        <crm:E29_Design_or_Procedure>
                                            <xsl:attribute name="rdf:about"
                                                select="concat($param-filename, '#boardAttachmentTechnique')"/>
                                            <crm:P2_has_type>
                                                <crm:E55_Type
                                                  rdf:about="http://w3id.org/lob/concept/3501">
                                                  <rdfs:label xml:lang="en">board
                                                  attachment</rdfs:label>
                                                </crm:E55_Type>
                                            </crm:P2_has_type>
                                            <xsl:call-template name="boardAttachment">
                                                <xsl:with-param name="boardsItem"
                                                  select="$boardsItem"/>
                                                <xsl:with-param name="param-filename_fragment"
                                                  select="$param-filename_fragment"/>
                                                <xsl:with-param name="param-filename"
                                                  select="$param-filename"/>
                                                <xsl:with-param name="param-filepath"
                                                  select="$param-filepath"/>
                                            </xsl:call-template>
                                        </crm:E29_Design_or_Procedure>
                                    </crm:P33_used_specific_technique>
                                </crm:E12_Production>
                            </crm:P108i_was_produced_by>
                        </xsl:for-each>
                    </crm:E25_Man-Made_Feature>
                </crm:P56_bears_feature>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="grainDirection">
        <xsl:param name="param-filename"/>
        <xsl:choose>
            <xsl:when test="formation/wood/grain/vertical">
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#verticalGrain')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3789">
                                <rdfs:label xml:lang="en">vertical grain</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E25_Man-Made_Feature>/ </crm:P56_bears_feature>
            </xsl:when>
            <xsl:when test="formation/wood/grain/horizontal">
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#horizontalGrain')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3787">
                                <rdfs:label xml:lang="en">horizontal grain</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E25_Man-Made_Feature>/ </crm:P56_bears_feature>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="boardAttachment">
        <xsl:param name="boardsItem"/>
        <xsl:param name="param-filename_fragment"/>
        <xsl:param name="param-filename"/>
        <xsl:param name="param-filepath"/>
        <xsl:choose>
            <xsl:when test="bridling | integral">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3511">
                        <rdfs:label xml:lang="en">sewn board attachment</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:choose>
                    <xsl:when test="bridling">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1232">
                                <rdfs:label xml:lang="en">bridling (techniques)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="lacedEndabandSlips | lacedSupportSlips | pastedSlips | sewnSlips">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3515">
                        <rdfs:label xml:lang="en">slip attachment</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:choose>
                    <xsl:when test="lacedEndabandSlips | lacedSupportSlips">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3849">
                                <rdfs:label xml:lang="en">board lacing</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test="pastedSlips">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4011">
                                <rdfs:label xml:lang="en">surface-adhering (slips)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="other">
                    <xsl:with-param name="value"
                        select="
                            concat('board attachment type: ', element()/name(), (if (node()/text()) then
                                concat(' ', node()/text())
                            else
                                ''))"
                    />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="lining">
        <xsl:param name="boardsItem"/>
        <xsl:param name="param-filename_fragment"/>
        <xsl:param name="param-filename"/>
        <xsl:param name="param-filepath"/>
        <xsl:param name="liningsNo"/>
        <xsl:variable name="liningID"
            select="
                if ($liningsNo gt 1) then
                    position()
                else
                    ''"/>
        <crm:P46_is_composed_of>
            <crm:E22_Man-Made_Object>
                <xsl:attribute name="rdf:about"
                    select="concat($param-filename, '#', $param-filename_fragment, $liningID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1219">
                        <rdfs:label xml:lang="en">board linings</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:choose>
                    <xsl:when test="type[internal | internalAndExternal]">
                        <crm:P55_has_current_location>
                            <crm:E53_Place>
                                <xsl:attribute name="rdf:about"
                                    select="concat($param-filename, '#internalSection')"/>
                            </crm:E53_Place>
                        </crm:P55_has_current_location>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="type[external | internalAndExternal]">
                        <crm:P55_has_current_location>
                            <crm:E53_Place>
                                <xsl:attribute name="rdf:about"
                                    select="concat($param-filename, '#externalSection')"/>
                            </crm:E53_Place>
                        </crm:P55_has_current_location>
                    </xsl:when>
                </xsl:choose>
                <xsl:call-template name="boardsmaterial">
                    <xsl:with-param name="boardsItem" select="$boardsItem"/>
                    <xsl:with-param name="param-filename_fragment" select="$param-filename_fragment"/>
                    <xsl:with-param name="param-filename" select="$param-filename"/>
                    <xsl:with-param name="param-filepath" select="$param-filepath"/>
                    <xsl:with-param name="ID" select="$liningID"/>
                </xsl:call-template>
            </crm:E22_Man-Made_Object>
        </crm:P46_is_composed_of>
        <xsl:choose>
            <xsl:when test="type[internal | internalAndExternal]">
                <crm:P58_has_section_definition>
                    <crm:E46_Section_Definition>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#internalSectionDef')"/>
                        <crm:P87i_identifies>
                            <crm:E53_Place>
                                <xsl:attribute name="rdf:about"
                                    select="concat($param-filename, '#internalSection')"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3812">
                                        <rdfs:label xml:lang="en">inner (place)</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </crm:E53_Place>
                        </crm:P87i_identifies>
                    </crm:E46_Section_Definition>
                </crm:P58_has_section_definition>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="type[external | internalAndExternal]">
                <crm:P58_has_section_definition>
                    <crm:E46_Section_Definition>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#externalSectionDef')"/>
                        <crm:P87i_identifies>
                            <crm:E53_Place>
                                <xsl:attribute name="rdf:about"
                                    select="concat($param-filename, '#externalSection')"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3814">
                                        <rdfs:label xml:lang="en">external (place)</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </crm:E53_Place>
                        </crm:P87i_identifies>
                    </crm:E46_Section_Definition>
                </crm:P58_has_section_definition>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="boardsmaterial">
        <xsl:param name="boardsItem"/>
        <xsl:param name="param-filename_fragment"/>
        <xsl:param name="param-filename"/>
        <xsl:param name="param-filepath"/>
        <xsl:param name="ID"/>
        <xsl:choose>
            <xsl:when test=".//material/paper">
                <xsl:call-template name="materialPaper">
                    <xsl:with-param name="component" select="$param-filename"/>
                    <xsl:with-param name="ID" select="$ID"/>

                </xsl:call-template>
            </xsl:when>
            <xsl:when test=".//material/parchment">
                <xsl:call-template name="materialParchment">
                    <xsl:with-param name="component" select="$param-filename"/>
                    <xsl:with-param name="ID" select="$ID"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test=".//material/textile">
                <xsl:call-template name="materialParchment">
                    <xsl:with-param name="component" select="$param-filename"/>
                    <xsl:with-param name="ID" select="$ID"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test=".//material/wood">
                <xsl:call-template name="materialWood">
                    <xsl:with-param name="component" select="$param-filename"/>
                    <xsl:with-param name="ID" select="$ID"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test=".//material/other">
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="material/other/text()"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>



</xsl:stylesheet>
