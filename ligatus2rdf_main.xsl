<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="/">
        <xsl:result-document href="{$filepath_main}" method="xml" indent="yes" encoding="utf-8">
            <rdf:RDF>
                <xsl:call-template name="namespaceDeclaration"/>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about" select="concat($filename_main, '#', $fileref)"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4886">
                            <rdfs:label xml:lang="en">codex-form books</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <xsl:for-each select="book/coverings/yes/cover">
                        <!-- These match templates for general types of bindings.
                            The templates are to be found in the coverings XSLT -->
                        <xsl:apply-templates mode="bindingTypes"/>
                    </xsl:for-each>
                    <crm:P1_is_identified_by>
                        <crm:E42_Identifier>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_main, '#', name(/book/bibliographical/shelfmark))"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3437">
                                    <rdfs:label xml:lang="en">shelfmarks</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <crm:P3_has_note>
                                <xsl:value-of select="book/bibliographical/shelfmark"/>
                            </crm:P3_has_note>
                        </crm:E42_Identifier>
                    </crm:P1_is_identified_by>
                    <crm:P55_has_current_location>
                        <crm:E53_Place rdf:about="http://dbpedia.org/resource/Wolfenb%C3%BCttel">
                            <crm:P1_is_identified_by>
                                <crm:E48_Place_Name rdf:about="http://sws.geonames.org/2806914">
                                    <rdfs:label xml:lang="en">Wolfenbüttel</rdfs:label>
                                    <rdfs:label xml:lang="de">Wolfenbüttel</rdfs:label>
                                    <rdfs:label xml:lang="la">Guelpherbytum</rdfs:label>
                                </crm:E48_Place_Name>
                            </crm:P1_is_identified_by>
                        </crm:E53_Place>
                    </crm:P55_has_current_location>
                    <crm:P50_has_current_keeper>
                        <crm:E40_Legal_Body rdf:about="/actors/hab.rdf#hab">
                            <!-- CREATE ACTOR RESOURCE -->
                            <rdfs:label xml:lang="en">Herzog August Library</rdfs:label>
                            <rdfs:label xml:lang="de">Herzog August Bibliothek</rdfs:label>
                            <rdfs:label xml:lang="la">Bibliotheca Augusta</rdfs:label>
                        </crm:E40_Legal_Body>
                    </crm:P50_has_current_keeper>
                    <crm:P108i_was_produced_by>
                        <crm:E12_Production>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_main, '#bookbindingEvent')"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300053592">
                                    <rdfs:label xml:lang="en">bookbinding (process)</rdfs:label>
                                    <rdfs:label xml:lang="de">Buchbinden</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                        </crm:E12_Production>
                    </crm:P108i_was_produced_by>
                    <!-- REVISE CODE TO INCLUDE REFERENCE TO THE BIBLIOGRAPHICAL RDF RECORD -->
                    <crm:P128_carries>
                        <crm:E33_Linguistic_Object>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_content, '#', $fileref, '-content')"/>
                        </crm:E33_Linguistic_Object>
                    </crm:P128_carries>
                    <crm:P46_is_composed_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_main, '#booktblock')"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1227">
                                    <rdfs:label xml:lang="en">bookblocks</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <xsl:apply-templates mode="bookblock"/>
                            <crm:P46i_forms_part_of>
                                <crm:E22_Man-Made_Object>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($filename_main, '#', $fileref)"/>
                                </crm:E22_Man-Made_Object>
                            </crm:P46i_forms_part_of>
                        </crm:E22_Man-Made_Object>
                    </crm:P46_is_composed_of>
                    <xsl:apply-templates mode="main"/>
                    <crm:P141i_was_assigned_by>
                        <crm:E13_Attribute_Assignment>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_main, '#', $fileref, '-descriptionActivity')"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300080091">
                                    <rdfs:label xml:lang="en">description</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <crm:P14_carried_out_by>
                                <crm:E39_Actor>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($collectionURI, '/', $collectionAcronym, 'bindings/actors/', $collectionAcronym, 'actors.rdf#', replace(book/surveyLog/pencilSurveyor, '[\s]', '_'))"/>
                                    <crm:P1_is_identified_by>
                                        <!-- Blank node -->
                                        <xsl:comment>NB: Blank node</xsl:comment>
                                        <crm:E82_Actor_Appellation>
                                            <rdfs:label>
                                                <xsl:value-of select="book/surveyLog/pencilSurveyor"
                                                />
                                            </rdfs:label>
                                        </crm:E82_Actor_Appellation>
                                    </crm:P1_is_identified_by>
                                    <crm:P2_has_type>
                                        <!-- Blank node -->
                                        <xsl:comment>NB: Blank node</xsl:comment>
                                        <crm:E55_Type>
                                            <rdfs:label xml:lang="en">pencil surveyor</rdfs:label>
                                        </crm:E55_Type>
                                    </crm:P2_has_type>
                                </crm:E39_Actor>
                            </crm:P14_carried_out_by>
                            <crm:P14_carried_out_by>
                                <crm:E39_Actor>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($collectionURI, '/', $collectionAcronym, 'bindings/actors/', $collectionAcronym, 'actors.rdf#', replace(book/surveyLog/observerSurveyor, '[\s]', '_'))"/>
                                    <crm:P1_is_identified_by>
                                        <!-- Blank node -->
                                        <xsl:comment>NB: Blank node</xsl:comment>
                                        <crm:E82_Actor_Appellation>
                                            <rdfs:label>
                                                <xsl:value-of
                                                  select="book/surveyLog/observerSurveyor"/>
                                            </rdfs:label>
                                        </crm:E82_Actor_Appellation>
                                    </crm:P1_is_identified_by>
                                    <crm:P2_has_type>
                                        <!-- Blank node -->
                                        <xsl:comment>NB: Blank node</xsl:comment>
                                        <crm:E55_Type>
                                            <rdfs:label xml:lang="en">observer surveyor</rdfs:label>
                                        </crm:E55_Type>
                                    </crm:P2_has_type>
                                </crm:E39_Actor>
                            </crm:P14_carried_out_by>
                            <crm:P4_has_time-span>
                                <crm:E52_Time-Span>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($filename_main, '#', $fileref, '-descriptionActivityTime')"/>
                                    <rdfs:label rdf:datatype="http://www.w3.org/2001/XMLSchema#date">
                                        <xsl:value-of select="book/surveyLog/surveyDate"/>
                                    </rdfs:label>
                                </crm:E52_Time-Span>
                            </crm:P4_has_time-span>
                        </crm:E13_Attribute_Assignment>
                    </crm:P141i_was_assigned_by>
                </crm:E22_Man-Made_Object>
                <crm:E53_place>
                    <xsl:attribute name="rdf:about" select="concat($filename_main, '#spinePlace')"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3810">
                            <rdfs:label xml:lang="en">spine (place)</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                </crm:E53_place>
                <crm:E53_place>
                    <xsl:attribute name="rdf:about" select="concat($filename_main, '#leftPlace')"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2947">
                            <rdfs:label xml:lang="en">left</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                </crm:E53_place>
                <crm:E53_place>
                    <xsl:attribute name="rdf:about" select="concat($filename_main, '#rightPlace')"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3004">
                            <rdfs:label xml:lang="en">right</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                </crm:E53_place>
                <crm:E53_place>
                    <xsl:attribute name="rdf:about" select="concat($filename_main, '#headPlace')"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3803">
                            <rdfs:label xml:lang="en">head</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                </crm:E53_place>
                <crm:E53_place>
                    <xsl:attribute name="rdf:about" select="concat($filename_main, '#tailPlace')"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3805">
                            <rdfs:label xml:lang="en">tail</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                </crm:E53_place>
                <crm:E53_place>
                    <xsl:attribute name="rdf:about"
                        select="concat($filename_main, '#fore-edgePlace')"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3808">
                            <rdfs:label xml:lang="en">fore-edge (place)</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                </crm:E53_place>
            </rdf:RDF>
        </xsl:result-document>
        <!-- Calls all other templates in the other modules -->
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="book/dimensions/height" mode="main">
        <crm:P43_has_dimensions>
            <crm:E54_Dimension>
                <xsl:attribute name="rdf:about" select="concat($filename_main, '#height')"/>
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
                <crm:P90_has_value rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger">
                    <xsl:value-of select="."/>
                </crm:P90_has_value>
            </crm:E54_Dimension>
        </crm:P43_has_dimensions>
    </xsl:template>

    <xsl:template match="book/dimensions/width" mode="main">
        <crm:P43_has_dimensions>
            <crm:E54_Dimension>
                <xsl:attribute name="rdf:about" select="concat($filename_main, '#width')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300055647">
                        <rdfs:label xml:lang="en">width</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P91_has_unit>
                    <crm:E58_Measuring_Unit rdf:about="http://vocab.getty.edu/aat/300379097">
                        <rdfs:label>mm</rdfs:label>
                    </crm:E58_Measuring_Unit>
                </crm:P91_has_unit>
                <crm:P90_has_value rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger">
                    <xsl:value-of select="."/>
                </crm:P90_has_value>
            </crm:E54_Dimension>
        </crm:P43_has_dimensions>
    </xsl:template>

    <xsl:template match="book/dimensions/thickness" mode="main">
        <crm:P43_has_dimensions>
            <crm:E54_Dimension>
                <xsl:attribute name="rdf:about" select="concat($filename_main, '#thicknessMax')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300055646">
                        <rdfs:label xml:lang="en">thickness</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://wiktionary.dbpedia.org/resource/maximum">
                        <rdfs:label xml:lang="en">maximum value</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P91_has_unit>
                    <crm:E58_Measuring_Unit rdf:about="http://vocab.getty.edu/aat/300379097">
                        <rdfs:label>mm</rdfs:label>
                    </crm:E58_Measuring_Unit>
                </crm:P91_has_unit>
                <crm:P90_has_value rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger">
                    <xsl:value-of select="./max"/>
                </crm:P90_has_value>
            </crm:E54_Dimension>
        </crm:P43_has_dimensions>
        <crm:P43_has_dimensions>
            <crm:E54_Dimension>
                <xsl:attribute name="rdf:about" select="concat($filename_main, '#thicknessMin')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300055646">
                        <rdfs:label xml:lang="en">thickness</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://wiktionary.dbpedia.org/resource/minimum">
                        <rdfs:label xml:lang="en">minimum value</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P91_has_unit>
                    <crm:E58_Measuring_Unit rdf:about="http://vocab.getty.edu/aat/300379097">
                        <rdfs:label>mm</rdfs:label>
                    </crm:E58_Measuring_Unit>
                </crm:P91_has_unit>
                <crm:P90_has_value rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger">
                    <xsl:value-of
                        select="
                            if (./min = 'Same') then
                                ./max
                            else
                                ./min"
                    />
                </crm:P90_has_value>
            </crm:E54_Dimension>
        </crm:P43_has_dimensions>
    </xsl:template>

    <xsl:template match="book/openingCharacteristics" mode="main">
        <xsl:choose>
            <xsl:when test="./hollowBack/yes">
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_main, '#openingCharacteristic')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1391">
                                <rdfs:label xml:lang="en">hollow backs</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <crm:P55_has_current_location>
                            <crm:E53_place>
                                <xsl:attribute name="rdf:about"
                                    select="concat($filename_main, '#spinePlace')"/>
                            </crm:E53_place>
                        </crm:P55_has_current_location>
                    </crm:E25_Man-Made_Feature>
                </crm:P56_bears_feature>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="book/textleaves" mode="bookblock">
        <xsl:for-each select=".//editionMaterial">
            <crm:P46_is_composed_of>
                <crm:E22_Man-Made_Object>
                    <xsl:variable name="editionNo">
                        <xsl:value-of select="editionNo"/>
                    </xsl:variable>
                    <xsl:attribute name="rdf:about"
                        select="
                            concat($filename_textblock, '#', $filename_fragment_textblock, (if ($editionNo eq '1') then
                                ''
                            else
                                $editionNo))"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1663">
                            <rdfs:label xml:lang="en">textblocks</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                </crm:E22_Man-Made_Object>
            </crm:P46_is_composed_of>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="book/endleaves" mode="bookblock">
        <xsl:for-each select="child::element()">
            <xsl:variable name="side" select="name()"/>
            <xsl:choose>
                <xsl:when test="yes">
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
                    <crm:P46_is_composed_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="concat($param-filename, '#', $param-filename_fragment)"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1317">
                                    <rdfs:label xml:lang="en">endleaves</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <crm:P55_has_current_location>
                                <crm:E53_place>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($filename_main, '#', $side, 'Place')"/>
                                </crm:E53_place>
                            </crm:P55_has_current_location>
                        </crm:E22_Man-Made_Object>
                    </crm:P46_is_composed_of>
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
                    <crm:P46_is_composed_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="concat($param-filename, '#', $param-filename_fragment)"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1317">
                                    <rdfs:label xml:lang="en">endleaves</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <crm:P55_has_current_location>
                                <crm:E53_place>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($filename_main, '#', $side, 'Place')"/>
                                </crm:E53_place>
                            </crm:P55_has_current_location>
                            <xsl:call-template name="other">
                                <xsl:with-param name="value" select="."/>
                            </xsl:call-template>
                        </crm:E22_Man-Made_Object>
                    </crm:P46_is_composed_of>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="book/edges" mode="bookblock">
        <crm:P56_bears_feature>
            <crm:E22_Man-Made_Object>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_edges, '#', $filename_fragment_edges)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1226">
                        <rdfs:label xml:lang="en">bookblock edges</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E22_Man-Made_Object>
        </crm:P56_bears_feature>
    </xsl:template>

    <xsl:template match="book/spine" mode="bookblock">
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_feature>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_spine, '#', $filename_fragment_spine)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2352">
                        <rdfs:label xml:lang="en">spine (bookblocks)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E25_Man-Made_feature>
        </crm:P56_bears_feature>
        <xsl:choose>
            <xsl:when test="book/spine/profile/joints/not(flat | none)">
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_spine, '#backingJoints')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1205">
                                <rdfs:label xml:lang="en">backing joints</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E25_Man-Made_feature>
                </crm:P56_bears_feature>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="book/markers/yes" mode="main">
        <xsl:variable name="count" select="count(marker)"/>
        <xsl:for-each select="marker">
            <crm:P46_is_composed_of>
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
                </crm:E22_Man-Made_Object>
            </crm:P46_is_composed_of>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="book/boards" mode="main">
        <xsl:choose>
            <xsl:when test="yes/boards">
                <xsl:variable name="boardsNo" select="count(board)"/>
                <xsl:for-each select="yes/boards/board">
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
                    <xsl:variable name="namespaceFragment">
                        <xsl:choose>
                            <xsl:when test="$location eq 'left'">
                                <xsl:value-of
                                    select="
                                        concat((if ($boardsNo gt 2) then
                                            concat(position(), '-')
                                        else
                                            ''), 'blt')"
                                />
                            </xsl:when>
                            <xsl:when test="$location eq 'right'">
                                <xsl:value-of
                                    select="
                                        concat((if ($boardsNo gt 2) then
                                            concat(position(), '-')
                                        else
                                            ''), 'brt')"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="position()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <crm:P46_is_composed_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="
                                    concat($param-filename, '#', $param-filename_fragment)"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1222">
                                    <rdfs:label xml:lang="en">boards</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                        </crm:E22_Man-Made_Object>
                    </crm:P46_is_composed_of>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="other">
                <xsl:variable name="param-filename_fragment"
                    select="concat($filename_fragment_boards, 's')"/>
                <xsl:variable name="param-filename"
                    select="concat($fileref, '_', $param-filename_fragment, '.rdf')"/>
                <xsl:variable name="param-filepath"
                    select="concat('../RDF/', $fileref, '/', $param-filename)"/>
                <crm:P46_is_composed_of>
                    <crm:E22_Man-Made_Object>
                        <xsl:attribute name="rdf:about"
                            select="
                                concat($param-filename, '#', $param-filename_fragment)"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1222">
                                <rdfs:label xml:lang="en">boards</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E22_Man-Made_Object>
                </crm:P46_is_composed_of>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="book/sewing" mode="main">
        <crm:P46_is_composed_of>
            <crm:E22_Man-Made_Object>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_sewing, '#', $filename_fragment_sewing)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3014">
                        <rdfs:label xml:lang="en">sewn structures</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E22_Man-Made_Object>
        </crm:P46_is_composed_of>
    </xsl:template>

    <xsl:template match="book/spine/lining/yes" mode="main">
        <xsl:variable name="count" select="count(lining)"/>
        <xsl:for-each select="lining">
            <crm:P46_is_composed_of>
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
                </crm:E22_Man-Made_Object>
            </crm:P46_is_composed_of>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="book/endbands" mode="main">
        <xsl:choose>
            <xsl:when test="yes/endband">
                <xsl:for-each select="yes/endband">
                    <xsl:call-template name="endbands_main">
                        <xsl:with-param name="location" select="location/element()/name()"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="other">
                <xsl:variable name="param-filename_fragment"
                    select="concat($filename_fragment_endbands, 's')"/>
                <xsl:variable name="param-filename"
                    select="concat($fileref, '_', $param-filename_fragment, '.rdf')"/>
                <xsl:variable name="param-filepath"
                    select="concat('../RDF/', $fileref, '/', $param-filename)"/>
                <crm:P46_is_composed_of>
                    <crm:E22_Man-Made_Object>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#', $param-filename_fragment)"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2370">
                                <rdfs:label xml:lang="en">endbands</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <xsl:call-template name="other">
                            <xsl:with-param name="value" select="."/>
                        </xsl:call-template>
                    </crm:E22_Man-Made_Object>
                </crm:P46_is_composed_of>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="endbands_main">
        <xsl:param name="location"/>
        <xsl:variable name="param-filename_fragment"
            select="
                concat($filename_fragment_endbands, (if ($location eq 'head') then
                    'Hd'
                else
                    'Tl'))
                "/>
        <xsl:variable name="param-filename"
            select="concat($fileref, '_', $param-filename_fragment, '.rdf')"/>
        <xsl:variable name="param-filepath"
            select="concat('../RDF/', $fileref, '/', $param-filename)"/>
        <crm:P46_is_composed_of>
            <crm:E22_Man-Made_Object>
                <xsl:attribute name="rdf:about"
                    select="concat($param-filename, '#', $param-filename_fragment)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2370">
                        <rdfs:label xml:lang="en">endbands</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P55_has_current_location>
                    <crm:E53_place>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_main, '#', $location, 'Place')"/>
                    </crm:E53_place>
                </crm:P55_has_current_location>
            </crm:E22_Man-Made_Object>
        </crm:P46_is_composed_of>
    </xsl:template>

    <xsl:template match="book/coverings" mode="main">
        <xsl:choose>
            <xsl:when test="yes">
                <xsl:variable name="count" select="count(cover)"/>
                <xsl:for-each select="cover">
                    <crm:P46_is_composed_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="
                                    concat($filename_covering, '#', $filename_fragment_covering, (if ($count eq 1) then
                                        ''
                                    else
                                        position()))"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1268">
                                    <rdfs:label xml:lang="en">covers</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <xsl:choose>
                                <xsl:when test="use/primary">
                                    <crm:P2_has_type>
                                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1515">
                                            <rdfs:label xml:lang="en">primary covers</rdfs:label>
                                        </crm:E55_Type>
                                    </crm:P2_has_type>
                                </xsl:when>
                                <xsl:when test="use/secondary">
                                    <crm:P2_has_type>
                                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1562">
                                            <rdfs:label xml:lang="en">secondary covers</rdfs:label>
                                        </crm:E55_Type>
                                    </crm:P2_has_type>
                                </xsl:when>
                            </xsl:choose>
                        </crm:E22_Man-Made_Object>
                    </crm:P46_is_composed_of>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="other">
                <xsl:variable name="count" select="count(cover)"/>
                <crm:P46_is_composed_of>
                    <crm:E22_Man-Made_Object>
                        <xsl:attribute name="rdf:about"
                            select="
                                concat($filename_covering, '#', $filename_fragment_covering, (if ($count eq 1) then
                                    ''
                                else
                                    position()))"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1268">
                                <rdfs:label xml:lang="en">covers</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <xsl:call-template name="other">
                            <xsl:with-param name="value" select="."/>
                        </xsl:call-template>
                    </crm:E22_Man-Made_Object>
                </crm:P46_is_composed_of>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


    <xsl:template
        match="book/furniture/yes/furniture[type[clasp | catchplate | pin | straps | strapPlates | strapCollars | ties]]"
        mode="main">
        <xsl:for-each
            select="furniture/type[clasp | catchplate | pin | straps | strapPlates | strapCollars | ties]">
            <crm:P46_is_composed_of>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about"
                        select="
                            concat($filename_furniture, '#fasteningComp', position())"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2893">
                            <rdfs:label xml:lang="en">fastenings</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                </crm:E22_Man-Made_Object>
            </crm:P46_is_composed_of>
        </xsl:for-each>
    </xsl:template>

    <xsl:template
        match="book/furniture/yes/furniture[type[bosses | corners | plates | fullCover | articulatedMetalSpines]]"
        mode="main">
        <xsl:for-each
            select="furniture/type[bosses | corners | plates | fullCover | articulatedMetalSpines]">
            <crm:P46_is_composed_of>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about"
                        select="
                            concat($filename_furniture, '#furnitureComp', position())"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1353">
                            <rdfs:label xml:lang="en">furniture (components)</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                </crm:E22_Man-Made_Object>
            </crm:P46_is_composed_of>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
