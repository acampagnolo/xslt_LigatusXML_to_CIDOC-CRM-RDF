<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="book/spine/lining/yes">
        <xsl:variable name="count" select="count(lining)" as="xs:integer"/>
        <xsl:result-document href="{$filepath_lining}" method="xml" indent="yes" encoding="utf-8">
            <rdf:RDF>
                <xsl:call-template name="namespaceDeclaration"/>
                <xsl:for-each select="lining">
                    <xsl:call-template name="spineLining">
                        <xsl:with-param name="count" select="$count" as="xs:integer"/>
                    </xsl:call-template>
                </xsl:for-each>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="spineLining">
        <xsl:param name="count" as="xs:integer"/>
        <xsl:param name="itemNo" select="position()"/>
        <crm:E22_Man-Made_Object>
            <xsl:attribute name="rdf:about"
                select="
                    concat($filename_lining, '#', $filename_fragment_lining, (if ($count gt 1) then
                        position()
                    else
                        ''))"/>
            <crm:P2_has_type>
                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1619">
                    <rdfs:label xml:lang="en">spine linings</rdfs:label>
                </crm:E55_Type>
            </crm:P2_has_type>
            <xsl:for-each select="types/type">
                <xsl:apply-templates/>
                <xsl:apply-templates mode="fullHeight"/>
                <xsl:apply-templates mode="liningExtensions">
                    <xsl:with-param name="count" select="$count" as="xs:integer"/>
                    <xsl:with-param name="itemNo" select="$itemNo"/>
                </xsl:apply-templates>
            </xsl:for-each>
            <crm:P156_occupies>
                <xsl:apply-templates mode="spineLiningLocation">
                    <xsl:with-param name="itemNo" select="$itemNo"/>
                </xsl:apply-templates>
            </crm:P156_occupies>
            <xsl:call-template name="spineLiningMaterial">
                <xsl:with-param name="count" select="$count"/>
                <xsl:with-param name="itemNo" select="$itemNo"/>
            </xsl:call-template>
            <crm:P46i_forms_part_of>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about" select="concat($filename_main, '#', $fileref)"/>
                </crm:E22_Man-Made_Object>
            </crm:P46i_forms_part_of>
        </crm:E22_Man-Made_Object>
    </xsl:template>

    <xsl:template match="overall | comb | continuous" mode="fullHeight">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4728">
                <rdfs:label xml:lang="en">full-height spine linings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template
        match="overall | transverse | comb | other[ancestor::lining[1]/liningJoints/other]"
        mode="liningExtensions">
        <xsl:param name="count" as="xs:integer"/>
        <xsl:param name="itemNo"/>
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about"
                    select="
                        concat($filename_lining, '#lining', (if ($count gt 1) then
                            $itemNo
                        else
                            ''), 'Extension')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1623">
                        <rdfs:label xml:lang="en">spine-lining extensions</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:for-each select="ancestor::lining[1]">
                    <xsl:choose>
                        <xsl:when test="liningJoints[insideBoards | outsideBoards]">
                            <xsl:call-template name="inside-outsideboards-linings">
                                <xsl:with-param name="faces">
                                    <xsl:choose>
                                        <xsl:when test="liningJoints/insideBoards">
                                            <xsl:value-of select="'#internalSection'"/>
                                        </xsl:when>
                                        <xsl:when test="liningJoints/outsideBoards">
                                            <xsl:value-of select="'#externalSection'"/>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="liningJoints/pastedToFlyleaf">
                            <xsl:for-each select="ancestor::lining/../../../book/endleaves[yes]">
                                <xsl:for-each select="self::endleaves/child::element()">
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
                                    <xsl:comment>Endleaves are counter from the board towards the text at each end:
                                    the outermost elements should therefore be the first to be described,
                                    and the lining is to be considered pasted on these.</xsl:comment>
                                    <crm:P156_occupies>
                                        <crm:E53_Place>
                                            <xsl:attribute name="rdf:about"
                                                select="concat($param-filename, '#u1c1freeEndleaves')"
                                            />
                                        </crm:E53_Place>
                                    </crm:P156_occupies>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:when test="liningJoints/other">
                            <crm:P156_occupies>
                                <crm:E53_Place>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($filename_lining, '#lining', $itemNo, 'Place')"/>
                                    <xsl:call-template name="other">
                                        <xsl:with-param name="value"
                                            select="concat('lining joints: ', liningJoints/other)"/>
                                    </xsl:call-template>
                                </crm:E53_Place>
                            </crm:P156_occupies>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
    </xsl:template>

    <xsl:template match="overall">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1468">
                <rdfs:label xml:lang="en">overall spine linings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="transverse">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1680">
                <rdfs:label xml:lang="en">transverse spine linings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="comb">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1255">
                <rdfs:label xml:lang="en">comb spine linings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="panel">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1479">
                <rdfs:label xml:lang="en">panel spine linings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="patch">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1494">
                <rdfs:label xml:lang="en">patch spine linings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="continuous">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1259">
                <rdfs:label xml:lang="en">continuous spine linings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="other">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="other"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="location" mode="spineLiningLocation">
        <xsl:apply-templates mode="spineLiningLocation"/>
    </xsl:template>

    <xsl:template match="all" mode="spineLiningLocation">
        <crm:E53_Place>
            <xsl:attribute name="rdf:about" select="concat($filename_spine, '#spinePlace')"/>
            <crm:P2_has_type>
                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3810">
                    <rdfs:label xml:lang="en">spine (place)</rdfs:label>
                </crm:E55_Type>
            </crm:P2_has_type>
            <crm:P59i_is_located_on_or_within>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about" select="concat($filename_spine, '#spine')"/>
                </crm:E22_Man-Made_Object>
            </crm:P59i_is_located_on_or_within>
        </crm:E53_Place>
    </xsl:template>

    <xsl:template match="selected" mode="spineLiningLocation">
        <crm:E53_Place>
            <xsl:attribute name="rdf:about" select="concat($filename_spine, '#panelsPlace')"/>
        </crm:E53_Place>
    </xsl:template>

    <xsl:template match="other[parent::location]" mode="spineLiningLocation">
        <xsl:param name="itemNo"/>
        <crm:E53_Place>
            <xsl:attribute name="rdf:about"
                select="concat($filename_spine, '#lining', $itemNo, 'Place')"/>
            <xsl:call-template name="other">
                <xsl:with-param name="value" select="other"/>
            </xsl:call-template>
        </crm:E53_Place>
    </xsl:template>

    <xsl:template name="inside-outsideboards-linings">
        <xsl:param name="faces"/>
        <xsl:for-each select="ancestor::lining/../../../book/boards/yes/boards">
            <xsl:variable name="boardsNo" select="count(board)"/>
            <xsl:for-each select="board">
                <xsl:variable name="location" select="location/element()/name()"/>
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
                <crm:P156_occupies>
                    <crm:E53_Place>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#', $faces)"/>
                    </crm:E53_Place>
                </crm:P156_occupies>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="spineLiningMaterial">
        <xsl:param name="count"/>
        <xsl:param name="itemNo"/>
        <xsl:variable name="ID"
            select="
                concat($filename_fragment_lining, if ($count gt 1) then
                    $itemNo
                else
                    '')"/>
        <xsl:choose>
            <xsl:when test="material/paper">
                <xsl:call-template name="materialPaper">
                    <xsl:with-param name="component" select="$filename_lining"/>
                    <xsl:with-param name="ID" select="$ID"/>

                </xsl:call-template>
            </xsl:when>
            <xsl:when test="material/parchment">
                <xsl:call-template name="materialParchment">
                    <xsl:with-param name="component" select="$filename_lining"/>
                    <xsl:with-param name="ID" select="$ID"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="material/textile">
                <xsl:call-template name="materialParchment">
                    <xsl:with-param name="component" select="$filename_lining"/>
                    <xsl:with-param name="ID" select="$ID"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="material/tannedSkin">
                <xsl:call-template name="materialtannedSkin">
                    <xsl:with-param name="component" select="$filename_lining"/>
                    <xsl:with-param name="ID" select="$ID"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="material/tawedSkin">
                <xsl:call-template name="materialtawedSkin">
                    <xsl:with-param name="component" select="$filename_lining"/>
                    <xsl:with-param name="ID" select="$ID"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="material/other">
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="material/other"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
