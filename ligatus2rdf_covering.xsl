<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="book/coverings">
        <xsl:choose>
            <xsl:when test="yes">
                <xsl:variable name="count" select="count(cover)"/>
                <xsl:result-document href="{$filepath_covering}" method="xml" indent="yes"
                    encoding="utf-8">
                    <rdf:RDF>
                        <xsl:call-template name="namespaceDeclaration"/>
                        <xsl:for-each select="yes/cover">
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
                                <!-- Types of cover are matched element by element -->
                                <xsl:apply-templates mode="coveringTypes">
                                    <xsl:with-param name="coverNo"
                                        select="
                                            (if ($count eq 1) then
                                                ''
                                            else
                                                position())"
                                    />
                                </xsl:apply-templates>
                                <xsl:apply-templates mode="coverMaterials">
                                    <xsl:with-param name="coverNo"
                                        select="
                                            (if ($count eq 1) then
                                                ''
                                            else
                                                position())"
                                    />
                                </xsl:apply-templates>
                                <xsl:apply-templates mode="coverLaminations"/>
                                <xsl:apply-templates mode="coverFeatures">
                                    <xsl:with-param name="coverNo"
                                        select="
                                            (if ($count eq 1) then
                                                ''
                                            else
                                                position())"
                                    />
                                </xsl:apply-templates>
                                <!-- Define spine and sides as cover features -->
                                <xsl:call-template name="spineSides">
                                    <xsl:with-param name="coverNo"
                                        select="
                                            (if ($count eq 1) then
                                                ''
                                            else
                                                position())"
                                    />
                                </xsl:call-template>
                                <xsl:call-template name="bands">
                                    <xsl:with-param name="coverNo"
                                        select="
                                            (if ($count eq 1) then
                                                ''
                                            else
                                                position())"
                                    />
                                </xsl:call-template>
                                <!-- Define places -->
                                <xsl:call-template name="placesDefinitions">
                                    <xsl:with-param name="count" select="$count"/>
                                    <xsl:with-param name="coverNo"
                                        select="
                                            (if ($count eq 1) then
                                                ''
                                            else
                                                position())"
                                    />
                                </xsl:call-template>
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
            </xsl:when>
            <xsl:when test="other">
                <xsl:variable name="count" select="count(cover)"/>
                <xsl:result-document href="{$filepath_covering}" method="xml" indent="yes"
                    encoding="utf-8">
                    <rdf:RDF>
                        <xsl:call-template name="namespaceDeclaration"/>
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
                    </rdf:RDF>
                </xsl:result-document>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="use/primary" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1515">
                <rdfs:label xml:lang="en">primary covers</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="use/secondary" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1562">
                <rdfs:label xml:lang="en">secondary covers</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type/case" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1242">
                <rdfs:label xml:lang="en">cases</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="coveringTypes"/>
        <xsl:apply-templates mode="caseFeatures"/>
    </xsl:template>

    <xsl:template match="type/case" mode="bindingTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4165">
                <rdfs:label xml:lang="en">case bindings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="bindingTypes"/>
    </xsl:template>

    <xsl:template match="type/overInboard" mode="coveringTypes">
        <xsl:param name="coverNo"/>
        <!-- Ligatus LoB defines inboard bindings but not 'overInboard covers' -->
        <!-- Add inboard binding as a type of the  -->
        <xsl:apply-templates mode="coveringTypes"/>
        <xsl:apply-templates mode="overInboardFeatures">
            <xsl:with-param name="coverNo" select="$coverNo"/>
        </xsl:apply-templates>
        <xsl:apply-templates mode="tips"/>
    </xsl:template>

    <xsl:template match="type/overInboard" mode="bindingTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1395">
                <rdfs:label xml:lang="en">inboard bindings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="joints" mode="overInboardFeatures">
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about" select="concat($filename_covering, '#joints')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2274">
                        <rdfs:label xml:lang="en">joints (features)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:apply-templates mode="overInboardFeatures"/>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
    </xsl:template>

    <xsl:template match="groovedJoints" mode="overInboardFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3246">
                <rdfs:label xml:lang="en">spaced joints</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="steppedJoints" mode="overInboardFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3248">
                <rdfs:label xml:lang="en">stepped joints</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="tightJoints" mode="overInboardFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3230">
                <rdfs:label xml:lang="en">tight joints</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="other[parent::joints]" mode="overInboardFeatures">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="."/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="corners" mode="overInboardFeatures">
        <xsl:for-each select="corner">
            <crm:P56_bears_feature>
                <crm:E25_Man-Made_Feature>
                    <xsl:attribute name="rdf:about" select="concat($filename_covering, '#corners')"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2344">
                            <rdfs:label xml:lang="en">mitres (cover features)</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <xsl:apply-templates mode="overInboardFeatures"/>
                </crm:E25_Man-Made_Feature>
            </crm:P56_bears_feature>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="lappedForedgeOver | lappedHeadAndTailOver | lappedMixed"
        mode="overInboardFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1421">
                <rdfs:label xml:lang="en">lapped mitres</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="name()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="tonguedMitre" mode="overInboardFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1674">
                <rdfs:label xml:lang="en">tongued mitres</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="clockwise | anticlockwise | other[parent::corner]"
        mode="overInboardFeatures">
        <xsl:call-template name="other">
            <xsl:with-param name="value"
                select="
                    if (other) then
                        .
                    else
                        name()"
            />
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="buttMitre" mode="overInboardFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1235">
                <rdfs:label xml:lang="en">butt mitres</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="openMitre" mode="overInboardFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1465">
                <rdfs:label xml:lang="en">open mitres</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type[half | quarter]" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1487">
                <rdfs:label xml:lang="en">part covers</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="coveringTypes"/>
    </xsl:template>

    <xsl:template match="half" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1382">
                <rdfs:label xml:lang="en">half covers</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="quarter" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1530">
                <rdfs:label xml:lang="en">quarter covers</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type/quarter/quarterWithParchmntTips[yes]" mode="tips">
        <crm:P46_is_composed_of>
            <crm:E22_Man-Made_Object>
                <xsl:attribute name="rdf:about" select="concat($filename_covering, '#tips')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4240">
                        <rdfs:label xml:lang="en">tips</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E22_Man-Made_Object>
        </crm:P46_is_composed_of>
    </xsl:template>

    <xsl:template match="caps" mode="overInboardFeatures" name="caps">
        <xsl:param name="coverNo"/>
        <xsl:param name="counter" select="1"/>
        <xsl:param name="location" select="'head'"/>
        <!-- Even if the schema does not distinguish between head and tail caps,
            this template will generate separate information for head and tail caps (each with its URI) -->
        <xsl:comment>Even if the schema does not distinguish between head and tail caps, separate triples are generated for head and tail caps (each with its URI)</xsl:comment>
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#cap', $location)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2374">
                        <rdfs:label xml:lang="en">caps</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:apply-templates mode="overInboardFeatures"/>
                <crm:P156_occupies>
                    <crm:E53_Place>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_covering, '#cover', $coverNo, '-', 'spine', 'Place')"
                        />
                    </crm:E53_Place>
                </crm:P156_occupies>
                <crm:P156_occupies>
                    <crm:E53_Place>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_covering, '#cover', $coverNo, '-', $location, 'Place')"
                        />
                    </crm:E53_Place>
                </crm:P156_occupies>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
        <xsl:choose>
            <xsl:when test="$counter lt 2">
                <xsl:call-template name="caps">
                    <xsl:with-param name="counter" select="$counter + 1"/>
                    <xsl:with-param name="location" select="'tail'"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="pulledOver" mode="overInboardFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1527">
                <rdfs:label xml:lang="en">pulled-over caps</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="straight" mode="overInboardFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1650">
                <rdfs:label xml:lang="en">straight caps</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="reversed" mode="overInboardFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1542">
                <rdfs:label xml:lang="en">reverse caps</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="covered" mode="overInboardFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3145">
                <rdfs:label xml:lang="en">covered endbands (caps)</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="other[parent::caps]" mode="overInboardFeatures">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="."/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="capCore[yes]" mode="overInboardFeatures">
        <crm:P46_is_composed_of>
            <crm:E22_Man-Made_Object>
                <xsl:attribute name="rdf:about" select="concat($filename_covering, '#capCore')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1240">
                        <rdfs:label xml:lang="en">cap cores</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E22_Man-Made_Object>
        </crm:P46_is_composed_of>
    </xsl:template>

    <xsl:template match="type/drawnOn" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1295">
                <rdfs:label xml:lang="en">drawn-on covers</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type/guard" mode="coveringTypes">
        <!-- Not in Ligatus LoB -->
    </xsl:template>

    <xsl:template match="type/adhesive" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1191">
                <rdfs:label xml:lang="en">adhesive cases</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="coveringTypes"/>
    </xsl:template>

    <xsl:template match="type/adhesive" mode="bindingTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1195">
                <rdfs:label xml:lang="en">adhesive-case bindings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="bindingTypes"/>
    </xsl:template>

    <xsl:template match="type/laceAttached" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1412">
                <rdfs:label xml:lang="en">lace-attached cases</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="coveringTypes"/>
    </xsl:template>

    <xsl:template match="type/laceAttached" mode="bindingTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3300">
                <rdfs:label xml:lang="en">lace-attached case bindings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="bindingTypes"/>
    </xsl:template>

    <xsl:template match="type/longstitch" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1350">
                <rdfs:label xml:lang="en">full-cover pierced sewing supports</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type/longstitch" mode="bindingTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3137">
                <rdfs:label xml:lang="en">longstitch bindings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="onePiece" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1460">
                <rdfs:label xml:lang="en">one-piece cases</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1459">
                <rdfs:label xml:lang="en">one-piece adhesive cases</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="threePiece" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1191">
                <rdfs:label xml:lang="en">adhesive cases</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="coveringTypes"/>
    </xsl:template>

    <xsl:template match="cutFlush" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1277">
                <rdfs:label xml:lang="en">cut flush covers</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="turnedIn" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2494">
                <rdfs:label xml:lang="en">turned-in covers</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="boardsCoverSpineInfill" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4395">
                <rdfs:label xml:lang="en">boards-and-cover cases</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="boardsCoverSpineInfill" mode="bindingTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1223">
                <rdfs:label xml:lang="en">boards-and-cover adhesive case-bindings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="bindingTypes"/>
    </xsl:template>

    <xsl:template match="limpLaced" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4392">
                <rdfs:label xml:lang="en">laced cases</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1423">
                <rdfs:label xml:lang="en">limp covers</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="coveringTypes"/>
    </xsl:template>

    <xsl:template match="limpLaced" mode="bindingTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4103">
                <rdfs:label xml:lang="en">laced-case bindings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1415">
                <rdfs:label xml:lang="en">laced-case limp bindings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="coveringTypes"/>
    </xsl:template>

    <xsl:template match="boards" mode="bindingTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4103">
                <rdfs:label xml:lang="en">laced-case bindings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1414">
                <rdfs:label xml:lang="en">laced-case bindings with boards</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="coveringTypes"/>
    </xsl:template>

    <!-- The slips that are laced are tagged as P55_Type: 'laced-in slips' (LoB: #1416) -->
    <xsl:template
        match="supportSlips | endbandSlips | endbandSupportSlips | other[parent::limplaced | parent::boards]"
        mode="coveringTypes">
        <xsl:comment>The slips that are laced are tagged as P55_Type: 'laced-in slips' (LoB: #1416)</xsl:comment>
        <crm:P3_has_note>
            <xsl:attribute name="xml:lang" select="'en'"/>
            <xsl:value-of
                select="
                    concat('lacing through: ', if (name() eq 'other') then
                        .
                    else
                        name())"
            />
        </crm:P3_has_note>
    </xsl:template>

    <xsl:template match="coverLining" mode="coveringTypes">
        <!-- cover lining cases are not typed in Ligatus LoB -->
        <crm:P46_is_composed_of>
            <crm:E22_Man-Made_Object>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#', 'coverLining', position())"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1266">
                        <rdfs:label xml:lang="en">cover linings</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E22_Man-Made_Object>
        </crm:P46_is_composed_of>
    </xsl:template>

    <xsl:template match="tacketed" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4393">
                <rdfs:label xml:lang="en">tacketed cases</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:call-template name="tackets"/>
    </xsl:template>

    <xsl:template match="tacketed" mode="bindingTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3061">
                <rdfs:label xml:lang="en">tacketed case bindings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template name="tackets">
        <!-- Variable to quickly signal that both endband and sewing station tackets are present -->
        <xsl:variable name="bothTackets"
            select="locations/location/endband and locations/location/sewing"/>
        <xsl:variable name="countSewStn"
            select="count(../../../../../../../../../book/sewing/stations/station[type/supported])"/>
        <xsl:choose>
            <xsl:when test="locations/location/endband">
                <xsl:for-each select="../../../../../../../../../book/endbands/yes/endband">
                    <xsl:variable name="endbandLoc" select="location/element()/name()"/>
                    <xsl:variable name="tacketNo"
                        select="
                            if (location/head) then
                                1
                            else
                                (if ($bothTackets) then
                                    ($countSewStn + 2)
                                else
                                    2)"/>
                    <crm:P46_is_composed_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="
                                    concat($filename_covering, '#endband-tacket', $tacketNo)"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1311">
                                    <rdfs:label xml:lang="en">endband secondary tackets</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <xsl:call-template name="tackets2">
                                <xsl:with-param name="tacketNo" select="$tacketNo"/>
                                <xsl:with-param name="tacketPlace"
                                    select="concat('endband', $endbandLoc, 'Place')"/>
                            </xsl:call-template>
                        </crm:E22_Man-Made_Object>
                    </crm:P46_is_composed_of>
                    <xsl:call-template name="tacketReinforcements">
                        <xsl:with-param name="tacketNo" select="$tacketNo"/>
                        <xsl:with-param name="tacketPlace"
                            select="concat('endband', $endbandLoc, 'Place')"/>
                        <xsl:with-param name="tacketLocation" select="'endband'"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="locations/location/sewing">
                <xsl:for-each
                    select="../../../../../../../../../book/sewing/stations/station[type/supported]">
                    <xsl:variable name="precUnsupStns"
                        select="count(preceding-sibling::station[type/unsupported])"/>
                    <xsl:variable name="tacketNo"
                        select="
                            (position() + (if ($bothTackets) then
                                1
                            else
                                0))"/>
                    <xsl:variable name="stnNo" select="$precUnsupStns + $tacketNo"/>
                    <crm:P46_is_composed_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="
                                    concat($filename_covering, '#sewing-tacket', $tacketNo)"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1583">
                                    <rdfs:label xml:lang="en">sewing support tackets</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <xsl:call-template name="tackets2">
                                <xsl:with-param name="tacketNo" select="$tacketNo"/>
                                <xsl:with-param name="tacketPlace"
                                    select="concat('stn', $stnNo, 'Place')"/>
                            </xsl:call-template>
                        </crm:E22_Man-Made_Object>
                    </crm:P46_is_composed_of>
                    <xsl:call-template name="tacketReinforcements">
                        <xsl:with-param name="tacketNo" select="$tacketNo"/>
                        <xsl:with-param name="tacketPlace" select="concat('stn', $stnNo, 'Place')"/>
                        <xsl:with-param name="tacketLocation" select="'sewing'"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="tackets2">
        <xsl:param name="tacketNo"/>
        <xsl:param name="tacketPlace"/>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1653">
                <rdfs:label xml:lang="en">tackets</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:comment>The schema describes only secondary tackets</xsl:comment>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1565">
                <rdfs:label xml:lang="en">secondary tackets</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates
            select="ancestor::book/coverings/yes/cover/type/case/type/laceAttached/tacketed"
            mode="tackets">
            <xsl:with-param name="tacketNo" select="$tacketNo"/>
        </xsl:apply-templates>
        <crm:P55_has_current_location>
            <crm:E53_Place>
                <xsl:attribute name="rdf:about" select="concat($filename_sewing, '#', $tacketPlace)"
                />
            </crm:E53_Place>
        </crm:P55_has_current_location>
    </xsl:template>

    <xsl:template match="type/loop" mode="tackets">
        <xsl:comment>The schema does not specify if the loops are twisted inside or outside, therefore 'loop' could match either LoB #1566 or #1567</xsl:comment>
        <crm:P3_has_note>
            <xsl:attribute name="xml:lang" select="'en'"/>
            <xsl:value-of select="concat('tacket type: ', name())"/>
        </crm:P3_has_note>
    </xsl:template>

    <xsl:template match="type/saltire" mode="tackets">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1568">
                <rdfs:label xml:lang="en">secondary tackets, saltire</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type/transverse" mode="tackets">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1569">
                <rdfs:label xml:lang="en">secondary tackets, transverse</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type/tranverseTwisted" mode="tackets">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1570">
                <rdfs:label xml:lang="en">secondary tackets, transverse twisted</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type[parent::tacketed]/other" mode="tackets">
        <crm:P3_has_note>
            <xsl:attribute name="xml:lang" select="'en'"/>
            <xsl:value-of select="concat('tacket type: ', .)"/>
        </crm:P3_has_note>
    </xsl:template>

    <xsl:template match="material" mode="tackets">
        <xsl:param name="tacketNo"/>
        <xsl:apply-templates mode="tackets">
            <xsl:with-param name="tacketNo" select="$tacketNo"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="tawedSkin" mode="tackets">
        <xsl:param name="tacketNo"/>
        <xsl:call-template name="materialtawedSkin">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('tacket', $tacketNo)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="cord" mode="tackets">
        <xsl:param name="tacketNo"/>
        <xsl:call-template name="materialCord">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('tacket', $tacketNo)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="parchment" mode="tackets">
        <xsl:param name="tacketNo"/>
        <xsl:call-template name="materialParchment">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('tacket', $tacketNo)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="tannedSkin" mode="tackets">
        <xsl:param name="tacketNo"/>
        <xsl:call-template name="materialtannedSkin">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('tacket', $tacketNo)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="other[parent::material/parent::tacketed]" mode="tackets">
        <xsl:param name="tacketNo"/>
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="concat('tacket material: ', .)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="tacketReinforcements">
        <xsl:param name="tacketNo"/>
        <xsl:param name="tacketPlace"/>
        <xsl:param name="tacketLocation"/>
        <xsl:choose>
            <!-- In the schema tacket reinforcements are compulsory: in my descriptions,
                when these are not present I have recorded these as 'type/other: NA' -->
            <xsl:when test="reinforcements/type/other eq 'NA'"/>
            <xsl:otherwise>
                <crm:P46_is_composed_of>
                    <crm:E22_Man-Made_Object>
                        <xsl:attribute name="rdf:about"
                            select="
                                concat($filename_covering, '#', $tacketLocation, '-tacketReinforcement', $tacketNo)"/>
                        <xsl:apply-templates mode="tacketReinforcement">
                            <xsl:with-param name="tacketNo" select="$tacketNo"/>
                            <xsl:with-param name="tacketPlace" select="$tacketPlace"/>
                            <xsl:with-param name="tacketLocation" select="$tacketLocation"/>
                        </xsl:apply-templates>
                    </crm:E22_Man-Made_Object>
                </crm:P46_is_composed_of>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="covering" mode="tacketReinforcement">
        <xsl:param name="tacketNo"/>
        <xsl:param name="tacketLocation"/>
        <xsl:variable name="tacketLocation" select="concat($tacketLocation, '-covering')"/>
        <crm:P46_is_composed_of>
            <crm:E22_Man-Made_Object>
                <xsl:attribute name="rdf:about"
                    select="
                        concat($filename_covering, '#', $tacketLocation, '-tacketReinforcement', $tacketNo, '-covering')"/>
                <xsl:apply-templates mode="tacketReinforcement">
                    <xsl:with-param name="tacketNo" select="$tacketNo"/>
                    <xsl:with-param name="tacketLocation" select="$tacketLocation"/>
                </xsl:apply-templates>
            </crm:E22_Man-Made_Object>
        </crm:P46_is_composed_of>
    </xsl:template>

    <xsl:template match="type[parent::reinforcements]" mode="tacketReinforcement">
        <xsl:comment>Ligatus LoB does not specify these in as much detail as the description schema</xsl:comment>
        <xsl:apply-templates mode="tacketReinforcement"/>
    </xsl:template>

    <xsl:template match="bands" mode="tacketReinforcement">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3293">
                <rdfs:label xml:lang="en">overboards</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template
        match="individual | singleStations | wholeSpines | other[parent::type/parent::reinforcements]"
        mode="tacketReinforcement">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1655">
                <rdfs:label xml:lang="en">tacket reinforcements</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:call-template name="other">
            <xsl:with-param name="value"
                select="
                    concat('reinforcement type: ', if (other) then
                        .
                    else
                        name())"
            />
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material" mode="tacketReinforcement">
        <xsl:param name="tacketNo"/>
        <xsl:param name="tacketLocation"/>
        <xsl:apply-templates mode="tacketReinforcement">
            <xsl:with-param name="tacketNo" select="$tacketNo"/>
            <xsl:with-param name="tacketLocation" select="$tacketLocation"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="tawedSkin" mode="tacketReinforcement">
        <xsl:param name="tacketNo"/>
        <xsl:param name="tacketLocation"/>
        <xsl:call-template name="materialtannedSkin">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID"
                select="concat($tacketLocation, '-tacketReinforcement', $tacketNo)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="hide" mode="tacketReinforcement">
        <xsl:param name="tacketNo"/>
        <xsl:param name="tacketLocation"/>
        <xsl:call-template name="materialHide">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID"
                select="concat($tacketLocation, '-tacketReinforcement', $tacketNo)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="parchment" mode="tacketReinforcement">
        <xsl:param name="tacketNo"/>
        <xsl:param name="tacketLocation"/>
        <xsl:call-template name="materialParchment">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID"
                select="concat($tacketLocation, '-tacketReinforcement', $tacketNo)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="tannedSkin" mode="tacketReinforcement">
        <xsl:param name="tacketNo"/>
        <xsl:param name="tacketLocation"/>
        <xsl:call-template name="materialtannedSkin">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID"
                select="concat($tacketLocation, '-tacketReinforcement', $tacketNo)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="wood" mode="tacketReinforcement">
        <xsl:param name="tacketNo"/>
        <xsl:param name="tacketLocation"/>
        <xsl:call-template name="materialWood">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID"
                select="concat($tacketLocation, '-tacketReinforcement', $tacketNo)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material[parent::reinforcement]/other" mode="tacketReinforcement">
        <xsl:param name="tacketNo"/>
        <xsl:param name="tacketLocation"/>
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="concat('tacket reinforcement material: ', .)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="other[parent::covering]" mode="tacketReinforcement">
        <xsl:param name="tacketNo"/>
        <xsl:param name="tacketLocation"/>
        <xsl:call-template name="other">
            <xsl:with-param name="value"
                select="concat('tacket reinforcement covering material: ', .)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="colour[parent::reinforcements]" mode="tacketReinforcement">
        <xsl:param name="tacketNo"/>
        <xsl:param name="tacketLocation"/>
        <crm:P56_bears_feature>
            <crm:E26_Physical_Feature>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#', 'tacketReinforcement', $tacketNo, '-colour')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300056130">
                        <rdfs:label xml:lang="en-GB">colour (perceived attribute)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="."/>
                </xsl:call-template>
            </crm:E26_Physical_Feature>
        </crm:P56_bears_feature>
    </xsl:template>

    <xsl:template match="flexibility" mode="tacketReinforcement">
        <xsl:param name="tacketNo"/>
        <xsl:param name="tacketLocation"/>
        <!-- NB: To be expressed in a more CIDOC-CRM compliant manner -->
        <xsl:comment>NB: To be expressed in a more CIDOC-CRM compliant manner</xsl:comment>
        <xsl:call-template name="other">
            <xsl:with-param name="value"
                select="concat('tacketReinforcement', $tacketNo, 'material flexibility: ', element()/name())"
            />
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="lacedAndTacketed" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3309">
                <rdfs:label xml:lang="en">laced-and-tacketed cases</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="lacedAndTacketed" mode="bindingTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1413">
                <rdfs:label xml:lang="en">laced-and-tacketed case bindings</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="preparation/edgeTreatment" mode="caseFeatures">
        <!-- LoB does not specify case edges and treatments -->
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about" select="concat($filename_covering, '#caseEdges')"/>
                <xsl:call-template name="other">
                    <xsl:with-param name="value"
                        select="
                            concat('edges: ', if (other) then
                                .
                            else
                                element()/name())"
                    />
                </xsl:call-template>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
    </xsl:template>

    <xsl:template match="corners" mode="caseFeatures">
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about" select="concat($filename_covering, '#corners')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2344">
                        <rdfs:label xml:lang="en">mitres (cover features)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:apply-templates mode="caseFeatures"/>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
    </xsl:template>

    <xsl:template match="lapped" mode="caseFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1421">
                <rdfs:label xml:lang="en">lapped mitres</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="locked | other[parent::corners]" mode="caseFeatures">
        <xsl:call-template name="other">
            <xsl:with-param name="value"
                select="
                    if (other) then
                        .
                    else
                        name()"
            />
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="joints" mode="caseFeatures">
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about" select="concat($filename_covering, '#joints')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2274">
                        <rdfs:label xml:lang="en">joints (features)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:apply-templates mode="caseFeatures"/>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
        <xsl:apply-templates mode="jointCrease"/>
    </xsl:template>

    <xsl:template match="groovedJoint" mode="caseFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1402">
                <rdfs:label xml:lang="en">joint grooves</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="spineCrease" mode="caseFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1617">
                <rdfs:label xml:lang="en">spine creases</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="spineCrease/jointCrease[yes]" mode="jointCrease">
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about" select="concat($filename_covering, '#', name())"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2274">
                        <rdfs:label xml:lang="en">joints (features)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1404">
                        <rdfs:label xml:lang="en">joint creases</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
    </xsl:template>

    <xsl:template match="type/full" mode="coveringTypes">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1348">
                <rdfs:label xml:lang="en">full covers</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="materials" mode="coverMaterials">
        <xsl:param name="coverNo"/>
        <xsl:for-each select="material">
            <xsl:apply-templates mode="coverMaterials">
                <xsl:with-param name="coverNo" select="$coverNo"/>
            </xsl:apply-templates>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="material/tannedSkin" mode="coverMaterials">
        <xsl:param name="coverNo"/>
        <xsl:call-template name="materialtannedSkin">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('cover', $coverNo)"/>
            <xsl:with-param name="covering" select="true()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/tawedSkin" mode="coverMaterials">
        <xsl:param name="coverNo"/>
        <xsl:call-template name="materialtawedSkin">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('cover', $coverNo)"/>
            <xsl:with-param name="covering" select="true()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/parchment" mode="coverMaterials">
        <xsl:param name="coverNo"/>
        <xsl:call-template name="materialParchment">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('cover', $coverNo)"/>
            <xsl:with-param name="covering" select="true()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/cartonnage" mode="coverMaterials">
        <xsl:param name="coverNo"/>
        <xsl:call-template name="materialCartonnage">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('cover', $coverNo)"/>
            <xsl:with-param name="covering" select="true()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/textile" mode="coverMaterials">
        <xsl:param name="coverNo"/>
        <xsl:call-template name="materialtextile">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('cover', $coverNo)"/>
            <xsl:with-param name="covering" select="true()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/paper" mode="coverMaterials">
        <xsl:param name="coverNo"/>
        <xsl:call-template name="materialPaper">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('cover', $coverNo)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/wood" mode="coverMaterials">
        <xsl:param name="coverNo"/>
        <xsl:call-template name="materialWood">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('cover', $coverNo)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/other" mode="coverMaterials">
        <xsl:param name="coverNo"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#', 'material-cover', $coverNo)"/>
                <xsl:call-template name="other">
                    <xsl:with-param name="value"
                        select="concat('cover', $coverNo, ' material: ', .)"/>
                </xsl:call-template>
                <xsl:apply-templates mode="coverFeatures" select="ancestor::cover/status"/>
            </crm:E57_Material>
        </crm:P45_consists_of>
    </xsl:template>

    <xsl:template match="laminations" mode="coverLaminations">
        <xsl:for-each select="lamination">
            <xsl:comment>Cover laminations are not well covered in the LoB</xsl:comment>
            <xsl:apply-templates mode="coverLinings"/>
            <xsl:call-template name="other">
                <xsl:with-param name="value" select="concat('lamination: ', element()/name())"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="inner | core" mode="coverLinings">
        <crm:P46_is_composed_of>
            <crm:E22_Man-Made_Object>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#', 'coverLining', position())"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1266">
                        <rdfs:label xml:lang="en">cover linings</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E22_Man-Made_Object>
        </crm:P46_is_composed_of>
    </xsl:template>

    <xsl:template match="stain[yes]" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <xsl:call-template name="stain">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('cover', $coverNo)"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Status templates are matched from within the material descriptions
        as these are essentially types of material -->
    <xsl:template match="status" mode="coverMaterialStatus">
        <xsl:param name="coverNo"/>
        <xsl:apply-templates mode="coverMaterialStatus"/>
    </xsl:template>

    <xsl:template match="use" mode="coverMaterialStatus">
        <xsl:param name="coverNo"/>
        <xsl:apply-templates mode="coverMaterialStatus"/>
    </xsl:template>

    <xsl:template match="firstUse | other[parent::use]" mode="coverMaterialStatus">
        <xsl:param name="coverNo"/>
        <xsl:call-template name="other">
            <xsl:with-param name="value"
                select="
                    concat('status: ', if (other) then
                        .
                    else
                        name())"
            />
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="reused" mode="coverMaterialStatus">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1535">
                <rdfs:label xml:lang="en">re-used (materials)</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="pieced[yes]" mode="coverMaterialStatus">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1535">
                <rdfs:label xml:lang="en">re-used (materials)</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="edges" mode="coverFeatures">
        <!-- LoB does not specify case edges and treatments -->
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about" select="concat($filename_covering, '#coverEdges')"/>
                <xsl:call-template name="other">
                    <xsl:with-param name="value"
                        select="
                            concat('edges: ', if (other) then
                                .
                            else
                                element()/name())"
                    />
                </xsl:call-template>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
    </xsl:template>

    <xsl:template match="yapp/yes" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#cover', $coverNo, 'Extensions')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1265">
                        <rdfs:label xml:lang="en">cover extensions</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
    </xsl:template>

    <xsl:template match="turnins" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <xsl:for-each select="turnin">
            <crm:P56_bears_feature>
                <crm:E25_Man-Made_Feature>
                    <xsl:attribute name="rdf:about"
                        select="concat($filename_covering, '#cover', $coverNo, '-', 'turnin', location/element()/name())"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1694">
                            <rdfs:label xml:lang="en">turn-ins</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <xsl:apply-templates mode="coverFeatures">
                        <xsl:with-param name="coverNo" select="$coverNo"/>
                    </xsl:apply-templates>
                </crm:E25_Man-Made_Feature>
            </crm:P56_bears_feature>
            <xsl:apply-templates mode="deckles">
                <xsl:with-param name="coverNo" select="$coverNo"/>
                <xsl:with-param name="location" select="location/element()/name()"/>
            </xsl:apply-templates>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="location" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <crm:P156_occupies>
            <crm:E53_Place>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#cover', $coverNo, '-', element()/name(), 'Place')"
                />
            </crm:E53_Place>
        </crm:P156_occupies>
    </xsl:template>

    <xsl:template match="trim/irregular" mode="caseFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3723">
                <rdfs:label xml:lang="en">irregular turn-ins</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="trim/neatTrim" mode="caseFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3719">
                <rdfs:label xml:lang="en">straight-trimmed turn-ins</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="trim/roughTrim" mode="caseFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3721">
                <rdfs:label xml:lang="en">rough-trimmed turn-ins</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="torn | other[parent::trim]" mode="caseFeatures">
        <xsl:call-template name="other">
            <xsl:with-param name="value"
                select="
                    if (other) then
                        .
                    else
                        name()"
            />
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="trim/deckles" mode="deckles">
        <xsl:param name="coverNo"/>
        <xsl:param name="location"/>
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#cover', $coverNo, '-', 'turnin', $location, 'deckles')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1284">
                        <rdfs:label xml:lang="en">deckle edges</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P156_occupies>
                    <crm:E53_Place>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_covering, '#cover', $coverNo, '-', 'turn-in', $location, 'Place')"
                        />
                    </crm:E53_Place>
                </crm:P156_occupies>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
    </xsl:template>

    <xsl:template match="coverExtentions/yes[type/foredgeFlap and material/attachment/integral]"
        mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <xsl:comment>Fore-edge flaps are classified as features in LoB: however this is only true if the flap is integral</xsl:comment>
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#cover', $coverNo, '-flap')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1343">
                        <rdfs:label xml:lang="en">envelope flaps (features)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:apply-templates mode="coverFeatures"/>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
    </xsl:template>

    <xsl:template
        match="coverExtentions/yes[type/edgeFlap | material/attachment/adhesive | sewn | nailed | other]"
        mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <xsl:comment>Fore-edge flaps are classified as features in LoB: however this is only true if the flap is integral</xsl:comment>
        <crm:P46_is_composed_of>
            <crm:E22_Man-Made_Object>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#cover', $coverNo, '-edgeFlaps')"/>
                <xsl:choose>
                    <xsl:when test="type/edgeFlap">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1302">
                                <rdfs:label xml:lang="en">edge flaps (components)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test="type/foredgeFlap">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1343">
                                <rdfs:label xml:lang="en">envelope flaps (features)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                </xsl:choose>
                <xsl:apply-templates mode="coverFeatures">
                    <xsl:with-param name="coverNo" select="$coverNo"/>
                </xsl:apply-templates>
            </crm:E22_Man-Made_Object>
        </crm:P46_is_composed_of>
    </xsl:template>

    <xsl:template match="material/matching/sameAsPrimary" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <xsl:variable name="primaryCovMat">
            <xsl:value-of
                select="ancestor::coverings/yes/cover[use/primary]/materials/material[1]/material/element()/name()"
            />
        </xsl:variable>
        <xsl:variable name="ID" select="concat('cover', $coverNo)"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#', $primaryCovMat, '-', $ID)"/>
            </crm:E57_Material>
        </crm:P45_consists_of>
    </xsl:template>

    <xsl:template match="material/matching/sameAsSecondary" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <xsl:variable name="secondaryCovMat">
            <xsl:value-of
                select="ancestor::coverings/yes/cover[use/secondary]/materials/material[1]/material/element()/name()"
            />
        </xsl:variable>
        <xsl:variable name="ID" select="concat('cover', $coverNo)"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#', $secondaryCovMat, '-', $ID)"/>
            </crm:E57_Material>
        </crm:P45_consists_of>
    </xsl:template>

    <xsl:template match="material/matching/different" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <xsl:apply-templates mode="coverMaterials">
            <xsl:with-param name="coverNo" select="$coverNo"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="material/status" mode="coverFeatures">
        <xsl:comment>NB: to be reworked</xsl:comment>
        <xsl:call-template name="other">
            <xsl:with-param name="value"
                select="
                    if (child::other) then
                        .
                    else
                        element()/name()"
            />
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/cutOff/yes" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <crm:P44_has_condition>
            <crm:E3_Condition_State>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#cover', $coverNo, '-flapCondition')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300265781">
                        <rdfs:label xml:lang="en">presence</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://wiktionary.dbpedia.org/resource/missing">
                        <rdfs:label xml:lang="en">missing</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P3_has_note xml:lang="en">cut off</crm:P3_has_note>
            </crm:E3_Condition_State>
        </crm:P44_has_condition>
    </xsl:template>

    <xsl:template match="material/attachment/adhesive" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <xsl:call-template name="attachmentMethod-adhered">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('cover', $coverNo, '-flap')"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/attachment/sewn" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <xsl:call-template name="attachmentMethod-sewn">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('cover', $coverNo, '-flap')"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/attachment/nailed" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <xsl:call-template name="attachmentMethod-nailed">
            <xsl:with-param name="component" select="$filename_covering"/>
            <xsl:with-param name="ID" select="concat('cover', $coverNo, '-flap')"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="former/yes" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <crm:P46_is_composed_of>
            <crm:E22_Man-Made_Object>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#cover', $coverNo, '-former')"/>
                <xsl:comment>Flap formers are not covered by LoB</xsl:comment>
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="'former'"/>
                </xsl:call-template>
                <xsl:apply-templates select="material" mode="coverMaterials">
                    <xsl:with-param name="coverNo" select="$coverNo"/>
                </xsl:apply-templates>
            </crm:E22_Man-Made_Object>
        </crm:P46_is_composed_of>
    </xsl:template>

    <xsl:template match="hingeLining/yes" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <crm:P46_is_composed_of>
            <crm:E22_Man-Made_Object>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#cover', $coverNo, '-hingeLining')"/>
                <xsl:comment>Hinge linings are not covered by LoB</xsl:comment>
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="'hinge lining'"/>
                </xsl:call-template>
                <xsl:apply-templates select="material" mode="coverMaterials">
                    <xsl:with-param name="coverNo" select="$coverNo"/>
                </xsl:apply-templates>
            </crm:E22_Man-Made_Object>
        </crm:P46_is_composed_of>
    </xsl:template>

    <xsl:template match="fastening/yes" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <crm:P16i_was_used_for>
            <crm:E7_Activity>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#cover', $coverNo, '-fasteningAttachmentEvent')"/>
                <crm:P33_used_specific_technique>
                    <crm:E29_Design_or_Procedure>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_covering, '#cover', $coverNo, '-fasteningAttachment')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2873">
                                <rdfs:label xml:lang="en">direct attachment (clasps
                                    attachment)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E29_Design_or_Procedure>
                </crm:P33_used_specific_technique>
            </crm:E7_Activity>
        </crm:P16i_was_used_for>
    </xsl:template>

    <xsl:template match="tooling/yes" mode="coverFeatures">
        <xsl:param name="coverNo"/>
        <crm:P56_bears_feature>
            <crm:E25_Man-Made_Feature>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#cover', $coverNo, '-tooling')"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1678">
                        <rdfs:label xml:lang="en">tooled decoration</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:for-each select="types/type">
                    <xsl:apply-templates mode="coverFeatures"/>
                </xsl:for-each>
                <xsl:for-each select="tools/tool">
                    <crm:P56_bears_feature>
                        <crm:E25_Man-Made_Feature>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_covering, '#cover', $coverNo, '-toolimpression', position())"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1675">
                                    <rdfs:label xml:lang="en">tool impressions</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <xsl:apply-templates mode="toolingImpression">
                                <xsl:with-param name="coverNo" select="$coverNo"/>
                                <xsl:with-param name="impressionNo" select="position()"/>
                            </xsl:apply-templates>
                        </crm:E25_Man-Made_Feature>
                    </crm:P56_bears_feature>
                </xsl:for-each>
            </crm:E25_Man-Made_Feature>
        </crm:P56_bears_feature>
    </xsl:template>

    <xsl:template match="type[parent::tool]/centrepiece" mode="toolingImpression">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1248">
                <rdfs:label xml:lang="en">centrepieces (decoration)</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type[parent::tool]/cornerPiece" mode="toolingImpression">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1262">
                <rdfs:label xml:lang="en">cornerpieces (decoration)</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type[fillets | rolls | smallTools]" mode="toolingImpression">
        <xsl:param name="coverNo"/>
        <xsl:param name="impressionNo"/>
        <crm:P108i_was_produced_by>
            <crm:E12_Production>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#tool', $impressionNo, 'ImpressionEvent')"/>
                <crm:P16_used_specific_object>
                    <crm:E22_Man-Made_Object>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_covering, '#tool', $impressionNo)"/>
                        <xsl:apply-templates mode="toolingImpression"/>
                    </crm:E22_Man-Made_Object>
                </crm:P16_used_specific_object>
            </crm:E12_Production>
        </crm:P108i_was_produced_by>
    </xsl:template>

    <xsl:template match="fillets" mode="toolingImpression">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3177">
                <rdfs:label xml:lang="en">fillets</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="rolls" mode="toolingImpression">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1548">
                <rdfs:label xml:lang="en">rolls (tools and equipment)</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="smallTolls" mode="toolingImpression">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1385">
                <rdfs:label xml:lang="en">small hand tools</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="rubbings" mode="toolingImpression">
        <xsl:param name="coverNo"/>
        <xsl:param name="impressionNo"/>
        <xsl:for-each select="rubbing">
            <crm:P44_has_condition>
                <crm:E3_Condition_State>
                    <xsl:attribute name="rdf:about"
                        select="concat($filename_covering, '#tool', $impressionNo, 'ImpressionQuality')"/>
                    <xsl:call-template name="other">
                        <xsl:with-param name="value"
                            select="concat('impression quality: ', impressionQuality/element()/name())"
                        />
                    </xsl:call-template>
                </crm:E3_Condition_State>
            </crm:P44_has_condition>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="blindTooling" mode="coverFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2288">
                <rdfs:label xml:lang="en">blind-tooled (decoration)</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <crm:P108i_was_produced_by>
            <crm:E12_Production>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#blindToolingEvent')"/>
                <crm:P33_used_specific_technique>
                    <crm:E29_Design_or_Procedure>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_covering, '#blindTooling')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1372">
                                <rdfs:label xml:lang="en">blind tooling (techniques)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E29_Design_or_Procedure>
                </crm:P33_used_specific_technique>
            </crm:E12_Production>
        </crm:P108i_was_produced_by>
    </xsl:template>

    <xsl:template match="goldTooling" mode="coverFeatures">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1371">
                <rdfs:label xml:lang="en">gold-tooled (decoration)</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <crm:P108i_was_produced_by>
            <crm:E12_Production>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#goldToolingEvent')"/>
                <crm:P33_used_specific_technique>
                    <crm:E29_Design_or_Procedure>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_covering, '#goldTooling')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1445">
                                <rdfs:label xml:lang="en">metal-leaf tooling
                                    (techniques)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1372">
                                <rdfs:label xml:lang="en">gold-tooling (techniques)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E29_Design_or_Procedure>
                </crm:P33_used_specific_technique>
            </crm:E12_Production>
        </crm:P108i_was_produced_by>
    </xsl:template>

    <xsl:template match="silverTooling" mode="coverFeatures">
        <crm:P108i_was_produced_by>
            <crm:E12_Production>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_covering, '#silverToolingEvent')"/>
                <crm:P33_used_specific_technique>
                    <crm:E29_Design_or_Procedure>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_covering, '#silverTooling')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1445">
                                <rdfs:label xml:lang="en">metal-leaf tooling
                                    (techniques)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3827">
                                <rdfs:label xml:lang="en">silver-tooling (techniques)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E29_Design_or_Procedure>
                </crm:P33_used_specific_technique>
            </crm:E12_Production>
        </crm:P108i_was_produced_by>
    </xsl:template>

    <xsl:template name="spineSides">
        <xsl:param name="coverNo"/>
        <xsl:variable name="portions">
            <spineCovering locatioin="spine">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1616">
                        <rdfs:label xml:lang="en">spine covering (cover features)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </spineCovering>
            <xsl:for-each select="'left', 'right'">
                <sideCovering>
                    <xsl:attribute name="location" select="."/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1596">
                            <rdfs:label xml:lang="en">sides covering (cover features)</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                </sideCovering>
            </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$portions/element()">
            <crm:P56_bears_feature>
                <crm:E25_Man-Made_Feature>
                    <xsl:attribute name="rdf:about"
                        select="
                            concat($filename_covering, '#cover', $coverNo, '-', name(), @location)"/>
                    <xsl:copy-of select="./child::node()"/>
                    <crm:P156_occupies>
                        <crm:E53_Place>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_covering, '#cover', $coverNo, '-', @location, 'Place')"
                            />
                        </crm:E53_Place>
                    </crm:P156_occupies>
                </crm:E25_Man-Made_Feature>
            </crm:P56_bears_feature>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="bands">
        <xsl:param name="coverNo"/>
        <!-- kettleband and band features are created only when they have been precisely recorded:
                i.e. when highlighted by tying-up -->
        <xsl:variable name="bands">
            <xsl:for-each select="tyingUp/yes/locations/location[kettleBand | bands]">
                <xsl:variable name="elementName" select="element()/name()"/>
                <xsl:choose>
                    <xsl:when test="$elementName eq 'kettleBand'">
                        <xsl:for-each
                            select="../../../../../../../../book/sewing/stations/station[type/unsupported/kettleStitch]">
                            <xsl:variable name="precUnsupStns"
                                select="count(preceding-sibling::station[type/unsupported])"/>
                            <xsl:variable name="precSupStns"
                                select="count(preceding-sibling::station[type/supported])"/>
                            <xsl:variable name="bandNo"
                                select="
                                    (1 + $precUnsupStns + $precSupStns)"/>
                            <kettleband>
                                <xsl:attribute name="location" select="concat('stn', $bandNo)"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2342">
                                        <rdfs:label xml:lang="en">bands (spine
                                            features)</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1407">
                                        <rdfs:label xml:lang="en">kettlebands</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </kettleband>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="$elementName eq 'bands'">
                        <xsl:for-each
                            select="../../../../../../../../book/sewing/stations/station[type/supported]">
                            <xsl:variable name="precUnsupStns"
                                select="count(preceding-sibling::station[type/unsupported])"/>
                            <xsl:variable name="precSupStns"
                                select="count(preceding-sibling::station[type/supported])"/>
                            <xsl:variable name="bandNo"
                                select="
                                    (1 + $precUnsupStns + $precSupStns)"/>
                            <band>
                                <xsl:attribute name="location" select="concat('stn', $bandNo)"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2342">
                                        <rdfs:label xml:lang="en">
                                            <xsl:text xml:space="default">bands (spine
                                                features)</xsl:text>
                                        </rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1533">
                                        <rdfs:label xml:lang="en">raised bands</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </band>
                        </xsl:for-each>
                    </xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$bands/element()">
            <crm:P56_bears_feature>
                <crm:E25_Man-Made_Feature>
                    <xsl:attribute name="rdf:about"
                        select="
                            concat($filename_covering, '#cover', $coverNo, '-', name(), @location)"/>
                    <xsl:copy-of select="./child::node()"/>
                    <crm:P156_occupies>
                        <crm:E53_Place>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_sewing, '#', @location, 'Place')"/>
                        </crm:E53_Place>
                    </crm:P156_occupies>
                </crm:E25_Man-Made_Feature>
            </crm:P56_bears_feature>
            <crm:P56_bears_feature>
                <crm:E25_Man-Made_Feature>
                    <xsl:attribute name="rdf:about"
                        select="
                            concat($filename_covering, '#cover', $coverNo, '-', 'tyingUpImpressions', name(), @location)"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4573">
                            <rdfs:label xml:lang="en">tying-up cord impressions</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <crm:P156_occupies>
                        <crm:E53_Place>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_covering, '#cover', $coverNo, '-', name(), @location, 'Place')"
                            />
                        </crm:E53_Place>
                    </crm:P156_occupies>
                </crm:E25_Man-Made_Feature>
            </crm:P56_bears_feature>
            <crm:P58_has_section_definition>
                <crm:E46_Section_Definition>
                    <xsl:attribute name="rdf:about"
                        select="
                            concat($filename_covering, '#cover', $coverNo, '-', name(), @location, 'SectDef')"/>
                    <crm:P87i_identifies>
                        <crm:E53_Place>
                            <xsl:attribute name="rdf:about"
                                select="
                                    concat($filename_covering, '#cover', $coverNo, '-', name(), @location, 'Place')"/>
                            <xsl:copy-of select="./child::node()"/>
                        </crm:E53_Place>
                    </crm:P87i_identifies>
                </crm:E46_Section_Definition>
            </crm:P58_has_section_definition>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="placesDefinitions">
        <xsl:param name="count"/>
        <xsl:param name="coverNo"/>
        <xsl:variable name="places">
            <!-- Defines the places prescribed by the schema or useful general places -->
            <caphead>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2374">
                        <rdfs:label xml:lang="en">caps</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3803">
                        <rdfs:label xml:lang="en">head</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </caphead>
            <captail>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2374">
                        <rdfs:label xml:lang="en">caps</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3805">
                        <rdfs:label xml:lang="en">tail</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </captail>
            <foredgeLeft>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3808">
                        <rdfs:label xml:lang="en">fore-edge (place)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2947">
                        <rdfs:label xml:lang="en">left</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </foredgeLeft>
            <foredgeRight>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3808">
                        <rdfs:label xml:lang="en">fore-edge (place)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3004">
                        <rdfs:label xml:lang="en">right</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </foredgeRight>
            <head>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3803">
                        <rdfs:label xml:lang="en">head</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </head>
            <tail>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3805">
                        <rdfs:label xml:lang="en">tail</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </tail>
            <left>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2947">
                        <rdfs:label xml:lang="en">left</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </left>
            <right>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3004">
                        <rdfs:label xml:lang="en">right</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </right>
            <spine>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3810">
                        <rdfs:label xml:lang="en">spine (place)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </spine>
            <sideLeft>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4676">
                        <rdfs:label xml:lang="en">sides (place)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2947">
                        <rdfs:label xml:lang="en">left</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </sideLeft>
            <sideRight>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4676">
                        <rdfs:label xml:lang="en">sides (place)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3004">
                        <rdfs:label xml:lang="en">right</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </sideRight>
            <xsl:for-each select="turnins/turnin[trim/deckles]">
                <turnin location="{location/element()/name()}">
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1694">
                            <rdfs:label xml:lang="en">turn-ins</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                </turnin>
            </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$places/element()">
            <crm:P58_has_section_definition>
                <crm:E46_Section_Definition>
                    <xsl:attribute name="rdf:about"
                        select="
                            concat($filename_covering, '#cover', $coverNo, '-', name(), if (@location) then
                                @location
                            else
                                '', 'SectDef')"/>
                    <crm:P87i_identifies>
                        <crm:E53_Place>
                            <xsl:attribute name="rdf:about"
                                select="
                                    concat($filename_covering, '#cover', $coverNo, '-', name(), if (@location) then
                                        @location
                                    else
                                        '', 'Place')"/>
                            <xsl:copy-of select="./child::node()"/>
                        </crm:E53_Place>
                    </crm:P87i_identifies>
                </crm:E46_Section_Definition>
            </crm:P58_has_section_definition>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
