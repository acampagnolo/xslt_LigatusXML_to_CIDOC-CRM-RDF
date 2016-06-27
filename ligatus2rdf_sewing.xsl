<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="book/sewing">
        <xsl:result-document href="{$filepath_sewing}" method="xml" indent="yes" encoding="utf-8">
            <rdf:RDF>
                <xsl:call-template name="namespaceDeclaration"/>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about"
                        select="concat($filename_sewing, '#', $filename_fragment_sewing)"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3014">
                            <rdfs:label xml:lang="en">sewn structures</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <xsl:call-template name="sewingType"/>
                    <xsl:for-each select="stations/station">
                        <xsl:choose>
                            <xsl:when test="type/supported">
                                <crm:P46_is_composed_of>
                                    <crm:E22_Man-Made_Object>
                                        <xsl:attribute name="rdf:about"
                                            select="concat($filename_sewing, '#supportStn', position())"/>
                                        <xsl:call-template name="sewingSupport"/>
                                    </crm:E22_Man-Made_Object>
                                </crm:P46_is_composed_of>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                    <!-- Threads -->
                    <xsl:for-each select="threads/thread">
                        <xsl:call-template name="materialThread">
                            <xsl:with-param name="component" select="$filename_sewing"/>
                            <xsl:with-param name="ID" select="concat('sewingMaterial', position())"/>
                        </xsl:call-template>                    
                    <crm:P46_is_composed_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_sewing, '#sewingThread', position())"/>
                                <rdfs:comment xml:lang="en">In the CIDOC-CRM materials (E57) cannot bear features or have
                                    parts</rdfs:comment>                                
                                    <xsl:choose>
                                        <xsl:when test=".//thread/multiplicity[single | double | other]">                                            
                                                <xsl:choose>
                                                    <xsl:when test=".//thread/multiplicity/single">
                                                        <crm:P57_has_number_of_parts rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger"
                                                            >1</crm:P57_has_number_of_parts>
                                                    </xsl:when>
                                                    <xsl:when test=".//thread/multiplicity/double">
                                                        <crm:P57_has_number_of_parts rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger"
                                                            >2</crm:P57_has_number_of_parts>
                                                    </xsl:when>
                                                    <xsl:when test=".//thread/multiplicity/other">
                                                        <xsl:call-template name="other">
                                                            <xsl:with-param name="value" select=".//thread/multiplicity/other/text()"/>
                                                        </xsl:call-template>
                                                    </xsl:when>
                                                </xsl:choose>                                            
                                        </xsl:when>
                                    </xsl:choose>                                
                                <crm:P56_bears_feature>
                                    <crm:E26_Physical_Feature>
                                        <xsl:attribute name="rdf:about"
                                            select="concat($filename_sewing, '#sewingThreadColour')"/>
                                        <crm:P2_has_type>
                                            <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300056130">
                                                <rdfs:label xml:lang="en-GB">colour (perceived attribute)</rdfs:label>
                                            </crm:E55_Type>
                                        </crm:P2_has_type>
                                        <crm:P3_has_note xml:lang="en">
                                            <xsl:value-of select=".//thread/colour/text()"/>
                                        </crm:P3_has_note>
                                    </crm:E26_Physical_Feature>
                                </crm:P56_bears_feature>        
                                <crm:P46i_forms_part_of>
                                    <crm:E22_Man-Made_Object>
                                        <xsl:attribute name="rdf:about"
                                            select="concat($filename_main, '#', $fileref)"/>
                                    </crm:E22_Man-Made_Object>
                                </crm:P46i_forms_part_of>
                        </crm:E22_Man-Made_Object>
                    </crm:P46_is_composed_of>
                    </xsl:for-each>
                    <crm:P46i_forms_part_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_main, '#', $fileref)"/>
                        </crm:E22_Man-Made_Object>
                    </crm:P46i_forms_part_of>
                </crm:E22_Man-Made_Object>
                <xsl:comment>
                    Sewing stations are features of the bookblock
                </xsl:comment>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about" select="concat($filename_main, '#bookblock')"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1227">
                            <rdfs:label xml:lang="en">bookblocks</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <xsl:call-template name="stationFeature"/>
                </crm:E22_Man-Made_Object>
                <xsl:choose>
                    <xsl:when test="sewingGuards/yes">
                        <xsl:call-template name="sewingGuards"/>
                    </xsl:when>
                </xsl:choose>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="sewingType">
        <crm:P108i_was_produced_by>
            <crm:E12_Production>
                <xsl:attribute name="rdf:about" select="concat($filename_sewing, '#sewingEvent')"/>
                <crm:P33_used_specific_technique>
                    <crm:E29_Design_or_Procedure>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_sewing, '#sewingTechnique')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2362">
                                <rdfs:label xml:lang="en">sewing (techniques)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E29_Design_or_Procedure>
                </crm:P33_used_specific_technique>
                <xsl:choose>
                    <xsl:when test="type/allAlong">
                        <crm:P33_used_specific_technique>
                            <crm:E29_Design_or_Procedure>
                                <xsl:attribute name="rdf:about"
                                    select="concat($filename_sewing, '#sewingType')"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1196">
                                        <rdfs:label xml:lang="en">all-along sewing</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </crm:E29_Design_or_Procedure>
                        </crm:P33_used_specific_technique>
                    </xsl:when>
                    <xsl:when test="type[bypass | multipleSectionSewing]">
                        <crm:P33_used_specific_technique>
                            <crm:E29_Design_or_Procedure>
                                <xsl:attribute name="rdf:about"
                                    select="concat($filename_sewing, '#sewingType')"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3744">
                                        <rdfs:label xml:lang="en">abbreviated sewing
                                            (techniques)</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                                <xsl:choose>
                                    <xsl:when test="type/bypass">
                                        <crm:P2_has_type>
                                            <crm:E55_Type
                                                rdf:about="http://w3id.org/lob/concept/1237">
                                                <rdfs:label xml:lang="en">bypass sewing</rdfs:label>
                                            </crm:E55_Type>
                                        </crm:P2_has_type>
                                    </xsl:when>
                                    <xsl:when test="type/multipleSectionSewing">
                                        <crm:P2_has_type>
                                            <crm:E55_Type
                                                rdf:about="http://w3id.org/lob/concept/1449">
                                                <rdfs:label xml:lang="en">multi-section
                                                  sewing</rdfs:label>
                                            </crm:E55_Type>
                                        </crm:P2_has_type>
                                    </xsl:when>
                                </xsl:choose>
                            </crm:E29_Design_or_Procedure>
                        </crm:P33_used_specific_technique>
                    </xsl:when>
                    <xsl:when
                        test="stations/station[1]/type/unsupported[doubleSequence | singleSequence | twoNeedle | other]">
                        <crm:P33_used_specific_technique>
                            <crm:E29_design_or_Procedure>
                                <xsl:attribute name="rdf:about"
                                    select="concat($filename_sewing, '#unsupported')"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3748">
                                        <rdfs:label xml:lang="en">unsupported sewing
                                            (techniques)</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </crm:E29_design_or_Procedure>
                        </crm:P33_used_specific_technique>
                        <xsl:choose>
                            <xsl:when test="stations/station[1]/type/unsupported/doubleSequence">
                                <crm:P33_used_specific_technique>
                                    <crm:E29_design_or_Procedure>
                                        <xsl:attribute name="rdf:about"
                                            select="concat($filename_sewing, '#doubleSequence')"/>
                                        <crm:P2_has_type>
                                            <crm:E55_Type
                                                rdf:about="http://w3id.org/lob/concept/3402">
                                                <rdfs:label xml:lang="en">double-sequence
                                                  sewing</rdfs:label>
                                            </crm:E55_Type>
                                        </crm:P2_has_type>
                                    </crm:E29_design_or_Procedure>
                                </crm:P33_used_specific_technique>
                            </xsl:when>
                            <xsl:when test="stations/station[1]/type/unsupported/other">
                                <xsl:call-template name="other">
                                    <xsl:with-param name="value"
                                        select="stations/station[1]/type/unsupported/other/text()"/>
                                </xsl:call-template>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="type/other">
                        <xsl:call-template name="other">
                            <xsl:with-param name="value" select="type/other/text()"/>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </crm:E12_Production>
        </crm:P108i_was_produced_by>
    </xsl:template>

    <xsl:template name="stationFeature">
        <xsl:for-each select="stations/station">
            <crm:P58_has_section_definition>
                <crm:E46_Section_Definition>
                    <xsl:attribute name="rdf:about"
                        select="concat($filename_sewing, '#stn', position(), 'SectDef')"/>
                    <crm:P87i_identifies>
                        <crm:E53_Place>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_sewing, '#stn', position(), 'Place')"/>
                        </crm:E53_Place>
                    </crm:P87i_identifies>
                </crm:E46_Section_Definition>
            </crm:P58_has_section_definition>
            <xsl:call-template name="stationPreparation"/>
            <crm:P56_bears_feature>
                <crm:E25_Man-Made_Feature>
                    <xsl:attribute name="rdf:about"
                        select="concat($filename_sewing, '#stn', position())"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1579">
                            <rdfs:label xml:lang="en">sewing stations</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <xsl:call-template name="stationTypes"/>
                    <crm:P55_has_current_location>
                        <crm:E53_Place>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_sewing, '#stn', position(), 'Place')"/>
                        </crm:E53_Place>
                    </crm:P55_has_current_location>
                    <crm:P43_has_dimension>
                        <crm:E54_Dimension>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_sewing, '#stn', position(), 'Measurement')"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300055645">
                                    <rdfs:label xml:lang="en">length</rdfs:label>
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
                                <xsl:value-of select="measurement"/>
                            </crm:P90_has_value>
                        </crm:E54_Dimension>
                    </crm:P43_has_dimension>
                    <xsl:choose>
                        <xsl:when test="group[not(NC | NK | other)]">
                            <!-- Current sewing station - begin -->
                            <crm:P108i_was_produced_by>
                                <crm:E12_Production>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($filename_sewing, '#stn', position(), 'production')"/>
                                    <xsl:element
                                        name="{if (group/current) then 'crm:P114_is_equal_in_time_to' else 'crm:P120_occurs_before'}">
                                        <crm:E12_Production>
                                            <xsl:attribute name="rdf:about"
                                                select="concat($filename_sewing, '#sewingEvent')"/>
                                        </crm:E12_Production>
                                    </xsl:element>
                                </crm:E12_Production>
                            </crm:P108i_was_produced_by>
                            <crm:P3_has_note xml:lang="en">
                                <xsl:value-of select="concat(group/element()/name(), ' ', name())"/>
                            </crm:P3_has_note>
                            <!-- Current sewing station - end -->
                        </xsl:when>
                    </xsl:choose>
                </crm:E25_Man-Made_Feature>
            </crm:P56_bears_feature>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="stationPreparation">
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_sewing, '#stn', position(), 'Preparation')"/>
                <crm:P2_has_type>
                    <xsl:choose>
                        <xsl:when test="preparation/piercedHole">
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2519">
                                <rdfs:label xml:lang="en">pierced sewing holes</rdfs:label>
                            </crm:E55_Type>
                        </xsl:when>
                        <xsl:when test="preparation/singleKnifeCut">
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2521">
                                <rdfs:label xml:lang="en">knife-cut sewing holes</rdfs:label>
                            </crm:E55_Type>
                        </xsl:when>
                        <xsl:when test="preparation/vNick">
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2516">
                                <rdfs:label xml:lang="en">sewing recesses</rdfs:label>
                            </crm:E55_Type>
                        </xsl:when>
                    </xsl:choose>
                </crm:P2_has_type>
                <xsl:choose>                    
                    <xsl:when test="preparation/other">
                        <xsl:call-template name="other">
                            <xsl:with-param name="value" select="preparation/other/text()"/>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
    </xsl:template>

    <xsl:template name="stationTypes">
        <xsl:choose>
            <xsl:when test="numberOfHoles eq '1'">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2512">
                        <rdfs:label xml:lang="en">one-hole sewing stations</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="numberOfHoles eq '2'">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1697">
                        <rdfs:label xml:lang="en">two-hole sewing stations</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="type/unsupported">
                <crm:P108i_was_produced_by>
                    <crm:E12_Production>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_sewing, '#sewingEvent')"/>
                        <crm:P33_used_specific_technique>
                            <crm:E29_design_or_Procedure>
                                <xsl:attribute name="rdf:about"
                                    select="concat($filename_sewing, '#unsupported')"/>
                            </crm:E29_design_or_Procedure>
                        </crm:P33_used_specific_technique>
                    </crm:E12_Production>
                </crm:P108i_was_produced_by>
                <xsl:choose>
                    <xsl:when test="type/unsupported/kettleStitch">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1250">
                                <rdfs:label xml:lang="en">change-over stations</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <crm:P108i_was_produced_by>
                            <crm:E12_Production>
                                <xsl:attribute name="rdf:about"
                                    select="concat($filename_sewing, '#sewingEvent')"/>
                                <crm:P33_used_specific_technique>
                                    <crm:E29_design_or_Procedure>
                                        <xsl:attribute name="rdf:about"
                                            select="concat($filename_sewing, '#kettlestitch')"/>
                                        <crm:P2_has_type>
                                            <crm:E55_Type
                                                rdf:about="http://w3id.org/lob/concept/1408">
                                                <rdfs:label xml:lang="en"
                                                  >kettlestitches</rdfs:label>
                                            </crm:E55_Type>
                                        </crm:P2_has_type>
                                    </crm:E29_design_or_Procedure>
                                </crm:P33_used_specific_technique>
                            </crm:E12_Production>
                        </crm:P108i_was_produced_by>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="supported">
                <crm:P108i_was_produced_by>
                    <crm:E12_Production>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_sewing, '#sewingEvent')"/>
                        <crm:P33_used_specific_technique>
                            <crm:E29_design_or_Procedure>
                                <xsl:attribute name="rdf:about"
                                    select="concat($filename_sewing, '#supportedSewing')"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3746">
                                        <rdfs:label xml:lang="en">supported sewing
                                            (techniques)</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </crm:E29_design_or_Procedure>
                        </crm:P33_used_specific_technique>
                    </crm:E12_Production>
                </crm:P108i_was_produced_by>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="sewingSupport">
        <xsl:call-template name="sewingSupportType"/>
        <crm:P55_has_current_location>
            <crm:E53_Place>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_sewing, '#stn', position(), 'Place')"/>
            </crm:E53_Place>
        </crm:P55_has_current_location>        
        <xsl:apply-templates mode="material"/>
    </xsl:template>

    <xsl:template name="sewingSupportType">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1585">
                <rdfs:label xml:lang="en">sewing supports</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:choose>
            <xsl:when test="type/supported/type/single/flat">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1659">
                        <rdfs:label xml:lang="en">flat sewing supports</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="type/supported/components/component/formation/folded">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1339">
                        <rdfs:label xml:lang="en">folded sewing supports</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="type/supported/components/component/formation/laminated">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1420">
                        <rdfs:label xml:lang="en">laminated sewing supports</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="type/supported/components/component/formation/rolled">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1547">
                        <rdfs:label xml:lang="en">rolled sewing supports</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="type/supported/components/component/formation/splitStrap">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1626">
                        <rdfs:label xml:lang="en">split-strap sewing supports</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="type/supported/components/component/formation/twisted">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1695">
                        <rdfs:label xml:lang="en">twisted sewing supports</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="type/supported/components/component/formation/other">
                <xsl:call-template name="other">
                    <xsl:with-param name="value"
                        select="concat('sewing support formation:', type/supported/components/component/formation/other)"
                    />
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="type/supported/type/single">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1602">
                        <rdfs:label xml:lang="en">single sewing supports</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="type/supported/type/double">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1292">
                        <rdfs:label xml:lang="en">double sewing supports</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>            
            <xsl:when test="type/supported/type/other">
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="type/supported/type/other"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="sewingSupportSlips">
        <!-- sewing supports usually have slips -->
        <crm:P56_bears_feature>
        <crm:E25_Man-Made_Feature>
            <xsl:attribute name="rdf:about"
                select="concat($filename_sewing, '#stn', position(), 'slips')"/>
            <crm:P2_has_type>
                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1606">
                    <rdfs:label xml:lang="en">slips</rdfs:label>
                </crm:E55_Type>
            </crm:P2_has_type>
        <xsl:choose>
            <xsl:when test="../../../../book/coverings/yes/cover/type/case[(//supportSlips | endbandSupportSlips) | (coverLining)]">
                                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1416">
                                <rdfs:label xml:lang="en">laced-in slips</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
            </xsl:when>
        </xsl:choose>
        </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
    </xsl:template>
    
    <xsl:template name="sewingGuards">
        <crm:E22_Man-Made_Object>
            <xsl:attribute name="rdf:about"
                select="concat($filename_sewing, '#sewingGuards')"/>
            <crm:P2_has_type>
                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3282">
                    <rdfs:label xml:lang="en">sewing guards</rdfs:label>
                </crm:E55_Type>
            </crm:P2_has_type>
            <xsl:choose>
                <xsl:when test="sewingGuards/yes/material/paper">                    
                    <xsl:call-template name="materialPaper">
                        <xsl:with-param name="component" select="$filename_sewing"/>
                        <xsl:with-param name="ID" select="'sewingGuardsMaterial'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="sewingGuards/yes/material/parchment">
                    <xsl:call-template name="materialtannedSkin">
                        <xsl:with-param name="component" select="$filename_sewing"/>
                        <xsl:with-param name="ID" select="'sewingGuardsMaterial'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="sewingGuards/yes/material/other">
                    <xsl:call-template name="other">
                        <xsl:with-param name="value" select="sewingGuards/yes/material/other"/>
                    </xsl:call-template>
                </xsl:when>
            </xsl:choose>
            <crm:P46i_forms_part_of>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about"
                        select="concat($filename_main, '#bookblock')"/>
                </crm:E22_Man-Made_Object>
            </crm:P46i_forms_part_of>
        </crm:E22_Man-Made_Object>
    </xsl:template>
    
    <xsl:template name="material">
        <xsl:choose>
            <xsl:when test=".//paper">
                <xsl:call-template name="materialPaper">
                    <xsl:with-param name="component" select="$filename_sewing"/>
                    <xsl:with-param name="ID" select="generate-id()"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test=".//material/tannedSkin">
                <xsl:call-template name="materialtannedSkin">
                    <xsl:with-param name="component" select="$filename_sewing"/>
                    <xsl:with-param name="ID" select="concat('SupportStn', position())"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test=".//material/tawedSkin">
                <xsl:call-template name="materialtawedSkin">
                    <xsl:with-param name="component" select="$filename_sewing"/>
                    <xsl:with-param name="ID" select="concat('SupportStn', position())"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test=".//material/parchment">
                <xsl:call-template name="materialtannedSkin">
                    <xsl:with-param name="component" select="$filename_sewing"/>
                    <xsl:with-param name="ID" select="concat('SupportStn', position())"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test=".//material/cord">
                <xsl:call-template name="materialCord">
                    <xsl:with-param name="component" select="$filename_sewing"/>
                    <xsl:with-param name="ID" select="concat('SupportStn', position())"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test=".//material/other">
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select=".//material/other"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>        
    </xsl:template>
    
</xsl:stylesheet>
