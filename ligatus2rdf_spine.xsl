<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="book/spine">
        <xsl:result-document href="{$filepath_spine}" method="xml" indent="yes" encoding="utf-8">
            <rdf:RDF>
                <xsl:call-template name="namespaceDeclaration"/>
                <crm:E25_Man-Made_feature>
                    <xsl:attribute name="rdf:about"
                        select="concat($filename_spine, '#', $filename_fragment_spine)"/>
                    <crm:P2_has_type>
                        <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2352">
                            <rdfs:label xml:lang="en">spine (bookblocks)</rdfs:label>
                        </crm:E55_Type>
                    </crm:P2_has_type>
                    <xsl:call-template name="spineShape"/>
                    <xsl:choose>
                        <xsl:when test="profile/joints/not(none | flat)">
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4340">
                                    <rdfs:label xml:lang="en">backed spines</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="lining/yes">
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4460">
                                    <rdfs:label xml:lang="en">lined spines</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                        </xsl:when>
                    </xsl:choose>
                    <crm:P46i_forms_part_of>
                        <crm:E22_Man-Made_Object>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_main, '#bookblock')"/>
                        </crm:E22_Man-Made_Object>
                    </crm:P46i_forms_part_of>
                </crm:E25_Man-Made_feature>
                <xsl:call-template name="backingJoints"/>
                <xsl:choose>
                    <xsl:when test="ancestor::book/sewing/stations//type/supported">
                        <crm:E53_Place>
                            <xsl:attribute name="rdf:about"
                                select="concat($filename_spine, '#panelsPlace')"/>
                            <crm:P2_has_type>
                                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1621">
                                    <rdfs:label xml:lang="en">spine panels</rdfs:label>
                                </crm:E55_Type>
                            </crm:P2_has_type>
                            <crm:P59i_is_located_on_or_within>
                                <crm:E22_Man-Made_Object>
                                    <xsl:attribute name="rdf:about"
                                        select="concat($filename_spine, '#panels')"/>
                                </crm:E22_Man-Made_Object>
                            </crm:P59i_is_located_on_or_within>
                        </crm:E53_Place>
                    </xsl:when>
                </xsl:choose>
            </rdf:RDF>
        </xsl:result-document>
        <!-- Spine linings come under the SPINE element, and the templates are therefore ignored:
            call them directly -->
        <xsl:apply-templates select="lining"/>
    </xsl:template>

    <xsl:template name="spineShape">
        <xsl:choose>
            <xsl:when test="profile/shape/flat">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1333">
                        <rdfs:label xml:lang="en">flat spines</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="profile/shape[heavyRound | round | slightRound]">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1551">
                        <rdfs:label xml:lang="en">rounded spines</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:choose>
                    <xsl:when test="profile/shape/heavyRound">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1389">
                                <rdfs:label xml:lang="en">heavy round spines</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test="profile/shape/round">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1550">
                                <rdfs:label xml:lang="en">round spines</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test="profile/shape/slightRound">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1604">
                                <rdfs:label xml:lang="en">slight round spines</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="profile/shape/other">
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="profile/shape/other/text()"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="backingJoints">
        <crm:E25_Man-Made_feature>
            <xsl:attribute name="rdf:about" select="concat($filename_spine, '#backingJoints')"/>
            <crm:P2_has_type>
                <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1205">
                    <rdfs:label xml:lang="en">backing joints</rdfs:label>
                </crm:E55_Type>
            </crm:P2_has_type>
            <xsl:call-template name="joints"/>
            <crm:P46i_forms_part_of>
                <crm:E22_Man-Made_Object>
                    <xsl:attribute name="rdf:about" select="concat($filename_main, '#bookblock')"/>
                </crm:E22_Man-Made_Object>
            </crm:P46i_forms_part_of>
        </crm:E25_Man-Made_feature>
    </xsl:template>

    <xsl:template name="joints">
        <xsl:choose>
            <xsl:when test="profile/joints/none | flat">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4865">
                        <rdfs:label xml:lang="en">flat joints</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="profile/joints/acute">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1188">
                        <rdfs:label xml:lang="en">acute joints</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="profile/joints/angled">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1198">
                        <rdfs:label xml:lang="en">angled joints</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="profile/joints/quadrant">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1529">
                        <rdfs:label xml:lang="en">quadrant joints</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="profile/joints/slight">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1603">
                        <rdfs:label xml:lang="en">slight joints</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="profile/joints/square">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1634">
                        <rdfs:label xml:lang="en">square joints</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:when test="profile/joints/other">
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="profile/joints/other/text()"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
