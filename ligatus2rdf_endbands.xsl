<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="book/endbands">
        <xsl:choose>
            <xsl:when test="yes/endband">
                <xsl:for-each select="yes/endband">
                    <xsl:call-template name="endbands">
                        <xsl:with-param name="location" select="location/element()/name()"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="other">
                <xsl:variable name="param-filename_fragment" select="concat($filename_fragment_endbands, 's')"/>
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
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2370">
                                    <rdfs:label xml:lang="en">endbands</rdfs:label>
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

    <xsl:template name="endbands">
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
        <xsl:result-document href="{$param-filepath}" method="xml" indent="yes" encoding="utf-8">
            <rdf:RDF>
                <xsl:call-template name="namespaceDeclaration"/>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about"
                        select="concat($param-filename, '#', $param-filename_fragment)"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2370">
                            <rdfs:label xml:lang="en">endbands</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <xsl:call-template name="endbandTypes"/>
                    <!-- Places occupied -->
                    <xsl:call-template name="endbandPlacesOccupied">
                        <xsl:with-param name="filename_main" select="$filename_main"/>
                        <xsl:with-param name="location" select="$location"/>
                    </xsl:call-template>
                    <!-- StuckOn Endband materials -->
                    <xsl:apply-templates mode="stuckOnEndbands">
                        <xsl:with-param name="location" select="$location"/>
                        <xsl:with-param name="filepath" select="$param-filepath"/>
                        <xsl:with-param name="filename" select="$param-filename"/>
                        <xsl:with-param name="filename_fragment" select="$param-filename_fragment"/>
                    </xsl:apply-templates>
                    <!-- Cores -->
                    <xsl:call-template name="endbandCores">
                        <xsl:with-param name="param-filename" select="$param-filename"/>
                        <xsl:with-param name="param-filepath" select="$param-filepath"/>
                        <xsl:with-param name="param-filename_fragment"
                            select="$param-filename_fragment"/>
                        <xsl:with-param name="location" select="$location"/>
                    </xsl:call-template>
                    <!-- Primary sewing -->
                    <xsl:call-template name="endbandPrimarySewing">
                        <xsl:with-param name="filename_sewing" select="$filename_sewing"/>
                        <xsl:with-param name="filename_main" select="$filename_main"/>
                        <xsl:with-param name="fileref" select="$fileref"/>
                        <xsl:with-param name="param-filename" select="$param-filename"/>
                    </xsl:call-template>
                    <!-- Secondary sewing -->
                    <xsl:call-template name="endbandSecondarySewing">
                        <xsl:with-param name="param-filename" select="$param-filename"/>
                        <xsl:with-param name="filename_main" select="$filename_main"/>
                        <xsl:with-param name="fileref" select="$fileref"/>
                    </xsl:call-template>
                    <!-- Extra stuckOn folded endband -->
                    <xsl:call-template name="ExtraStuckOnFoldedEndband">
                        <xsl:with-param name="param-filename" select="$param-filename"/>
                    </xsl:call-template>
                    <crm:P46i_forms_part_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_main, '#', $fileref)"/>
                        </crm:E22_Man-Made_Object>
                    </crm:P46i_forms_part_of>
                </crm:E22_Man-Made_Object>
                <!-- Specify that the threads were used for the sewing -->
                <xsl:call-template name="threadUsage">
                    <xsl:with-param name="filename_sewing" select="$filename_sewing"/>
                    <xsl:with-param name="param-filename" select="$param-filename"/>
                </xsl:call-template>
                <!-- The presence of enbands creates the endband places on the bookblock spine; this is useful,
                    for example, to specify that some tackets are located in correspondance of the endbands -->
                <xsl:call-template name="endbandPlaces">
                    <xsl:with-param name="filename_main" select="$filename_main"/>
                    <xsl:with-param name="param-filename" select="$param-filename"/>
                    <xsl:with-param name="location" select="$location"/>
                </xsl:call-template>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="endbandPlaces">
        <xsl:param name="filename_main"/>
        <xsl:param name="param-filename"/>
        <xsl:param name="location"/>
        <xsl:comment>The presence of enbands creates the endband places on the bookblock spine; this is useful, for example, to specify that some tackets are located in correspondance of the endbands</xsl:comment>
        <crm:E22_Man-Made_Object>
            <xsl:attribute name="rdf:about" select="concat($filename_main, '#bookblock')"/>
            <crm:P2_has_type>
                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1227">
                    <rdfs:label xml:lang="en">bookblocks</rdfs:label>
                </crm:E55_Type>
            </crm:P2_has_type>
            <crm:P58_has_section_definition>
                <crm:E46_Section_Definition>
                    <xsl:attribute name="rdf:about"
                        select="concat($param-filename, '#endband', $location, 'SectDef')"/>
                    <crm:P87i_identifies>
                        <crm:E53_Place>
                            <xsl:attribute name="rdf:about"
                                select="concat($param-filename, '#endband', $location, 'Place')"/>
                        </crm:E53_Place>
                    </crm:P87i_identifies>
                </crm:E46_Section_Definition>
            </crm:P58_has_section_definition>
        </crm:E22_Man-Made_Object>
    </xsl:template>

    <xsl:template name="threadUsage">
        <xsl:param name="filename_sewing"/>
        <xsl:param name="param-filename"/>
        <xsl:for-each select="primary/yes/threads/thread">
            <xsl:variable name="about">
                <xsl:choose>
                    <xsl:when test="sameAsText/yes">
                        <xsl:value-of select="concat($filename_sewing, '#thread-sewingMaterial1')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($param-filename, '#thread-endbandMaterial1')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <crm:E57_Material>
                <xsl:attribute name="rdf:about" select="$about"/>
                <crm:P16i_was-used-for>
                    <crm:E12_Production>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#primarySewingEvent')"/>
                        <crm:P33_used_specific_technique>
                            <crm:E29_Design_or_Procedure>
                                <xsl:attribute name="rdf:about"
                                    select="concat($param-filename, '#primarySewing')"/>
                            </crm:E29_Design_or_Procedure>
                        </crm:P33_used_specific_technique>
                    </crm:E12_Production>
                </crm:P16i_was-used-for>
            </crm:E57_Material>
        </xsl:for-each>
        <xsl:for-each select="secondary/yes/threads/thread">
            <crm:E57_Material>
                <xsl:attribute name="rdf:about"
                    select="concat($param-filename, '#secondaryEndbandMaterial', position())"/>
                <crm:P16i_was-used-for>
                    <crm:E12_Production>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#secondarySewingEvent')"/>
                        <crm:P33_used_specific_technique>
                            <crm:E29_Design_or_Procedure>
                                <xsl:attribute name="rdf:about"
                                    select="concat($param-filename, '#secondarySewing')"/>
                            </crm:E29_Design_or_Procedure>
                        </crm:P33_used_specific_technique>
                    </crm:E12_Production>
                </crm:P16i_was-used-for>
            </crm:E57_Material>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="ExtraStuckOnFoldedEndband">
        <xsl:param name="param-filename"/>
        <xsl:choose>
            <xsl:when test="extraStuckOnFoldedEndband/yes">
                <crm:P46_is_composed_of>
                    <crm:E22_Man-Made_Object>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#extraStuckOnFoldedEndband')"/>
                        <xsl:comment>A number of bindings have an extra ‘endband’ created by folding a piece of leather,
                                        usually over some sort of core material such as a length of cord, and glueing it across the
                                        spine outside the worked endband but inside the cap formed by the covering material, creating
                                        an extra ‘band’ at head and tail. However, this concept has not yet been specified in Ligatus LoB.</xsl:comment>
                    </crm:E22_Man-Made_Object>
                </crm:P46_is_composed_of>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="endbandSecondarySewing">
        <xsl:param name="param-filename"/>
        <xsl:param name="filename_main"/>
        <xsl:param name="fileref"/>
        <xsl:choose>
            <xsl:when test="secondary/yes">
                <!-- thread material -->
                <xsl:for-each select="secondary/yes/threads/thread">
                    <xsl:call-template name="materialThread">
                        <xsl:with-param name="component" select="$param-filename"/>
                        <xsl:with-param name="ID"
                            select="concat('secondaryEndbandMaterial', position())"/>
                    </xsl:call-template>
                    <crm:P46_is_composed_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="concat($param-filename, '#secondaryEndbandThread', position())"/>
                            <rdfs:comment xml:lang="en">In the CIDOC-CRM materials (E57) cannot bear
                                features or have parts</rdfs:comment>
                            <crm:P56_bears_feature>
                                <crm:E26_Physical_Feature>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($param-filename, '#secondaryEndbandThreadColour')"/>
                                    <crm:P2_has_type>
                                        <crm:E55_Type
                                            rdf:about="http://vocab.getty.edu/aat/300056130">
                                            <rdfs:label xml:lang="en-GB">colour (perceived
                                                attribute)</rdfs:label>
                                        </crm:E55_Type>
                                    </crm:P2_has_type>
                                    <crm:P3_has_note xml:lang="en">
                                        <xsl:value-of select="colour"/>
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
                <crm:P108i_was_produced_by>
                    <crm:E12_Production>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#secondarySewingEvent')"/>
                        <crm:P33_used_specific_technique>
                            <crm:E29_Design_or_Procedure>
                                <xsl:attribute name="rdf:about"
                                    select="concat($param-filename, '#secondarySewing')"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2536">
                                        <rdfs:label xml:lang="en">secondary sewing (endband
                                            techniques)</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </crm:E29_Design_or_Procedure>
                        </crm:P33_used_specific_technique>
                    </crm:E12_Production>
                </crm:P108i_was_produced_by>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="endbandPrimarySewing">
        <xsl:param name="filename_sewing"/>
        <xsl:param name="filename_main"/>
        <xsl:param name="fileref"/>
        <xsl:param name="param-filename"/>
        <xsl:choose>
            <xsl:when test="primary/yes">
                <!-- thread materials -->
                <xsl:call-template name="endbandThreadMaterial">
                    <xsl:with-param name="param-filename" select="$param-filename"/>
                    <xsl:with-param name="filename_sewing" select="$filename_sewing"/>
                    <xsl:with-param name="filename_main" select="$filename_main"/>
                    <xsl:with-param name="fileref" select="$fileref"/>
                </xsl:call-template>
                <crm:P108i_was_produced_by>
                    <crm:E12_Production>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#primarySewingEvent')"/>
                        <crm:P33_used_specific_technique>
                            <crm:E29_Design_or_Procedure>
                                <xsl:attribute name="rdf:about"
                                    select="concat($param-filename, '#primarySewing')"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4122">
                                        <rdfs:label xml:lang="en">primary sewing (endband
                                            techniques)</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </crm:E29_Design_or_Procedure>
                        </crm:P33_used_specific_technique>
                    </crm:E12_Production>
                </crm:P108i_was_produced_by>
                <!-- Construction type: Ligatus LoB does not provide types for endband sewing yet -->
                <xsl:choose>
                    <xsl:when test="primary/yes/construction/type/not(frontBead | reversingTwist)">
                        <xsl:comment>Construction type: Ligatus LoB does not provide types for endband sewing yet</xsl:comment>
                        <crm:P3_has_note>
                            <xsl:attribute name="xml:lang" select="'en'"/>
                            <xsl:value-of
                                select="concat('construction type: ', primary/yes/construction/type/element()/name())"
                            />
                        </crm:P3_has_note>
                    </xsl:when>
                    <xsl:when test="primary/yes/construction/type/frontBead">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3639">
                                <rdfs:label xml:lang="en">front beads</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test="primary/yes/construction/type/reversingTwist">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3325">
                                <rdfs:label xml:lang="en">back beads</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                </xsl:choose>
                <!-- tiedowns -->
                <crm:P46_is_composed_of>
                    <crm:E22_Man-Made_Object>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#tiedowns')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1668">
                                <rdfs:label xml:lang="en">tiedowns</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <crm:P108i_was_produced_by>
                            <crm:E12_Production>
                                <xsl:attribute name="rdf:about"
                                    select="concat($param-filename, '#primarySewingEvent')"/>
                                <crm:P33_used_specific_technique>
                                    <crm:E29_Design_or_Procedure>
                                        <xsl:attribute name="rdf:about"
                                            select="concat($param-filename, '#primarySewing')"/>
                                    </crm:E29_Design_or_Procedure>
                                </crm:P33_used_specific_technique>
                            </crm:E12_Production>
                        </crm:P108i_was_produced_by>
                        <crm:P3_has_note xml:lang="en">
                            <xsl:value-of select="primary/yes/numberOfTiedowns/element()/name()"/>
                        </crm:P3_has_note>
                    </crm:E22_Man-Made_Object>
                </crm:P46_is_composed_of>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="endbandThreadMaterial">
        <xsl:param name="param-filename"/>
        <xsl:param name="filename_sewing"/>
        <xsl:param name="filename_main"/>
        <xsl:param name="fileref"/>
        <xsl:for-each select="primary/yes/threads/thread">
            <!-- If the thread is marked as 'same as text':
                                    use text thread URI, otherwise create new material;
                                    however, if more than one thread was recorded for the sewing,
                                    then it would be impossible to assign the precise thread that was reused:
                                    we assign the first here -->
            <xsl:choose>
                <xsl:when test="sameAsText/yes">
                    <crm:P45_consists_of>
                        <crm:E57_Material>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_sewing, '#thread-sewingMaterial1')"/>
                        </crm:E57_Material>
                    </crm:P45_consists_of>
                    <crm:P46_is_composed_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_sewing, '#sewingThread1')"/>
                        </crm:E22_Man-Made_Object>
                    </crm:P46_is_composed_of>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="materialThread">
                        <xsl:with-param name="component" select="$param-filename"/>
                        <xsl:with-param name="ID" select="concat('endbandMaterial', position())"/>
                    </xsl:call-template>
                    <crm:P46_is_composed_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="concat($param-filename, '#endbandThread', position())"/>
                            <rdfs:comment xml:lang="en">In the CIDOC-CRM materials (E57) cannot bear
                                features or have parts</rdfs:comment>
                            <xsl:choose>
                                <xsl:when
                                    test="threadMaterial/multiplicity[single | double | other]">
                                    <xsl:choose>
                                        <xsl:when test="threadMaterial/multiplicity/single">
                                            <crm:P57_has_number_of_parts
                                                rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger"
                                                >1</crm:P57_has_number_of_parts>
                                        </xsl:when>
                                        <xsl:when test="threadMaterial/multiplicity/double">
                                            <crm:P57_has_number_of_parts
                                                rdf:datatype="http://www.w3.org/2001/XMLSchema#positiveInteger"
                                                >2</crm:P57_has_number_of_parts>
                                        </xsl:when>
                                        <xsl:when test="threadMaterial/multiplicity/other">
                                            <xsl:call-template name="other">
                                                <xsl:with-param name="value"
                                                  select="threadMaterial/multiplicity/other/text()"
                                                />
                                            </xsl:call-template>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:when>
                            </xsl:choose>
                            <crm:P56_bears_feature>
                                <crm:E26_Physical_Feature>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($param-filename, '#endbandThreadColour')"/>
                                    <crm:P2_has_type>
                                        <crm:E55_Type
                                            rdf:about="http://vocab.getty.edu/aat/300056130">
                                            <rdfs:label xml:lang="en-GB">colour (perceived
                                                attribute)</rdfs:label>
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
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="endbandPlacesOccupied">
        <xsl:param name="filename_main"/>
        <xsl:param name="location"/>
        <xsl:choose>
            <xsl:when test="stuckOn/yes/pastedOnBoards/yes">
                <xsl:call-template name="inside-outsideboards-endbands">
                    <xsl:with-param name="faces">
                        <xsl:choose>
                            <xsl:when test="stuckOn/yes/pastedOnBoards/yes/insideBoards">
                                <xsl:value-of select="'#internalSection'"/>
                            </xsl:when>
                            <xsl:when test="stuckOn/yes/pastedOnBoards/yes/outsideBoards">
                                <xsl:value-of select="'#externalSection'"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
        <crm:P55_has_current_location>
            <crm:E53_place>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_main, '#', $location, 'Place')"/>
            </crm:E53_place>
        </crm:P55_has_current_location>
    </xsl:template>

    <xsl:template name="endbandTypes">
        <xsl:choose>
            <xsl:when test="stuckOn/no and primary/yes">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2538">
                        <rdfs:label xml:lang="en">sewn endbands</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="stuckOn/yes">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2540">
                        <rdfs:label xml:lang="en">stuck-on endbands</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="stuckOn/yes/folded/yes">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3143">
                        <rdfs:label xml:lang="en">folded stuck-on endbands</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="endbandCores">
        <xsl:param name="param-filename"/>
        <xsl:param name="param-filepath"/>
        <xsl:param name="param-filename_fragment"/>
        <xsl:param name="location"/>
        <xsl:for-each select="cores/yes/cores/type/element()">
            <crm:P46_is_composed_of>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about"
                        select="concat($param-filename, '#', name(), position())"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1309">
                            <rdfs:label xml:lang="en">endband cores</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <xsl:choose>
                        <xsl:when test="name() eq 'core'">
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2967">
                                    <rdfs:label xml:lang="en">main cores (endband
                                        components)</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <xsl:call-template name="endbandCoreAttachment">
                                <xsl:with-param name="param-filename" select="$param-filename"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="name() eq 'crowningCore'">
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3329">
                                    <rdfs:label xml:lang="en">subsidiary cores</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:apply-templates mode="endbandCores">
                        <xsl:with-param name="crowningCore" select="false()"/>
                        <xsl:with-param name="filepath" select="$param-filepath"/>
                        <xsl:with-param name="filename" select="$param-filename"/>
                        <xsl:with-param name="filename_fragment" select="$param-filename_fragment"/>
                        <xsl:with-param name="coreID" select="concat(name(), position(), $location)"
                        />
                    </xsl:apply-templates>
                    <xsl:choose>
                        <xsl:when test="material/sameAsCore">
                            <xsl:apply-templates mode="endbandCores">
                                <xsl:with-param name="crowningCore" select="true()"/>
                                <xsl:with-param name="filepath" select="$param-filepath"/>
                                <xsl:with-param name="filename" select="$param-filename"/>
                                <xsl:with-param name="filename_fragment"
                                    select="$param-filename_fragment"/>
                                <xsl:with-param name="coreID"
                                    select="concat(name(), position(), $location)"/>
                            </xsl:apply-templates>
                        </xsl:when>
                        <xsl:when test="material/other">
                            <xsl:call-template name="other">
                                <xsl:with-param name="value" select="material/other"/>
                            </xsl:call-template>
                        </xsl:when>
                    </xsl:choose>
                    <!-- Crowning cores can be sewn with the primary or secondary sewing -->
                    <xsl:choose>
                        <xsl:when test="sewnType/sewnWithPrimary">
                            <crm:P16i_was_used_by>
                                <crm:E12_Production>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($param-filename, '#primarySewingEvent')"/>
                                </crm:E12_Production>
                            </crm:P16i_was_used_by>
                        </xsl:when>
                        <xsl:when test="sewnType/sewnWithSecondary">
                            <crm:P16i_was_used_by>
                                <crm:E12_Production>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($param-filename, '#SecondarySewingEvent')"/>
                                </crm:E12_Production>
                            </crm:P16i_was_used_by>
                        </xsl:when>
                    </xsl:choose>
                </crm:E22_Man-Made_Object>
            </crm:P46_is_composed_of>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="endbandCoreAttachment">
        <xsl:param name="param-filename"/>
        <xsl:choose>
            <xsl:when test="boardAttachment/yes">
                <!-- endbands cores usually have slips, even if these are cut -->
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#', name(), position(), 'slips')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1606">
                                <rdfs:label xml:lang="en">slips</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <xsl:choose>
                            <xsl:when test="boardAttachemnt/yes/attachment/sewn">
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3500">
                                        <rdfs:label xml:lang="en">sewn slips</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </xsl:when>
                            <xsl:when test="boardAttachemnt/yes/attachment/adhered">
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3695">
                                        <rdfs:label xml:lang="en">surface-adhered slips</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </xsl:when>
                            <xsl:when test="boardAttachemnt/yes/attachment/cutAtJoint">
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3490">
                                        <rdfs:label xml:lang="en">slips cut at the
                                            joints</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </xsl:when>
                            <xsl:when test="boardAttachemnt/yes/attachment/laced">
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1416">
                                        <rdfs:label xml:lang="en">laced-in slips</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </xsl:when>
                            <xsl:when test="boardAttachemnt/yes/attachment/other">
                                <xsl:call-template name="other">
                                    <xsl:with-param name="value"
                                        select="boardAttachemnt/yes/attachment/other"/>
                                </xsl:call-template>
                            </xsl:when>
                        </xsl:choose>
                    </crm:E25_Man-Made_Feature>
                </crm:P56_bears_feature>
                <xsl:choose>
                    <xsl:when test="boardAttachemnt/yes/attachment[sewn | sewnAndRecessed]">
                        <xsl:call-template name="attachmentMethod-sewn">
                            <xsl:with-param name="component" select="$param-filename"/>
                            <xsl:with-param name="ID" select="concat(name(), position(), 'slips')"/>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
        <!-- Slips can be laced through the cover:
                            this information is recorded in the covering session, but is redirected here -->
        <xsl:choose>
            <xsl:when
                test="../../../../../../../../../book/coverings/yes/cover/type/case[(//endbandSlip | endbandSupportSlips) | (coverLining)]">
                <!-- endbands cores usually have slips, even if these are cut -->
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($param-filename, '#', name(), position(), 'slips')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1606">
                                <rdfs:label xml:lang="en">slips</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1416">
                                <rdfs:label xml:lang="en">laced-in slips</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E25_Man-Made_Feature>
                </crm:P56_bears_feature>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="inside-outsideboards-endbands">
        <xsl:param name="faces"/>
        <xsl:for-each select="../../../../../book/boards/yes/boards">
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

    <xsl:template match="material" mode="endbandCores">
        <xsl:param name="crowningCore"/>
        <xsl:param name="filepath"/>
        <xsl:param name="filename"/>
        <xsl:param name="filename_fragment"/>
        <xsl:param name="coreID"/>
        <xsl:choose>
            <xsl:when
                test="
                    if ($crowningCore eq true()) then
                        ../../../type/core/material/parchment
                    else
                        parchment">
                <xsl:call-template name="materialParchment">
                    <xsl:with-param name="component" select="$filename"/>
                    <xsl:with-param name="ID" select="$coreID"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when
                test="
                    if ($crowningCore eq true()) then
                        ../../../type/core/material/tannedSkin
                    else
                        tannedSkin">
                <xsl:call-template name="materialtannedSkin">
                    <xsl:with-param name="component" select="$filename"/>
                    <xsl:with-param name="ID" select="$coreID"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when
                test="
                    if ($crowningCore eq true()) then
                        ../../../type/core/material/tawedSkin
                    else
                        tawedSkin">
                <xsl:call-template name="materialtawedSkin">
                    <xsl:with-param name="component" select="$filename"/>
                    <xsl:with-param name="ID" select="$coreID"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when
                test="
                    if ($crowningCore eq true()) then
                        ../../../type/core/material/cord
                    else
                        cord">
                <xsl:call-template name="materialCord">
                    <xsl:with-param name="component" select="$filename"/>
                    <xsl:with-param name="ID" select="$coreID"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="stuckOn/yes/material" mode="stuckOnEndbands">
        <xsl:param name="location"/>
        <xsl:param name="filepath"/>
        <xsl:param name="filename"/>
        <xsl:param name="filename_fragment"/>
        <xsl:choose>
            <xsl:when test="parchment">
                <xsl:call-template name="materialParchment">
                    <xsl:with-param name="component" select="$filename"/>
                    <xsl:with-param name="ID" select="concat('endband', $location)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="tannedSkin">
                <xsl:call-template name="materialtannedSkin">
                    <xsl:with-param name="component" select="$filename"/>
                    <xsl:with-param name="ID" select="concat('endband', $location)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="tawedSkin">
                <xsl:call-template name="materialtawedSkin">
                    <xsl:with-param name="component" select="$filename"/>
                    <xsl:with-param name="ID" select="concat('endband', $location)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="textile">
                <xsl:call-template name="materialtextile">
                    <xsl:with-param name="component" select="$filename"/>
                    <xsl:with-param name="ID" select="concat('endband', $location)"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
