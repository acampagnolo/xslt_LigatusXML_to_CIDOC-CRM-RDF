<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <!-- GENERAL MATERIAL TEMPLATES TO BE CALLED WHERE NEEDED -->
    <xsl:template name="materialPaper">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'paper-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1481">
                        <rdfs:label xml:lang="en">paper</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:choose>
                    <xsl:when test=".//material/type/western">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2462">
                                <rdfs:label xml:lang="en">western paper</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//material/type/eastern">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2460">
                                <rdfs:label xml:lang="en">eastern paper</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test=".//decoration/yes">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1285">
                                <rdfs:label xml:lang="en">decorated paper</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                </xsl:choose>
            </crm:E57_Material>
        </crm:P45_consists_of>
        <xsl:choose>
            <xsl:when test=".//watermark/yes">
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($component, '#', 'paper-', $ID, '-WM')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3092">
                                <rdfs:label xml:lang="en">watermarks</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E25_Man-Made_Feature>
                </crm:P56_bears_feature>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test=".//colour[white | cream | blue | other]">
                <crm:P56_bears_feature>
                    <crm:E26_Physical_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($component, '#', 'paper-', $ID, '-colour')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300056130">
                                <rdfs:label xml:lang="en-GB">colour (perceived
                                    attribute)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <xsl:choose>
                            <xsl:when test=".//colour/white">
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://dbpedia.org/resource/White">
                                        <rdfs:label xml:lang="en">white</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </xsl:when>
                            <xsl:when test=".//colour/cream">
                                <crm:P2_has_type>
                                    <crm:E55_Type
                                        rdf:about="http://dbpedia.org/resource/Cream_(colour)">
                                        <rdfs:label xml:lang="en-GB">cream (colour)</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </xsl:when>
                            <xsl:when test=".//colour/blue">
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://dbpedia.org/resource/Blue">
                                        <rdfs:label xml:lang="en-GB">blue</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </xsl:when>
                            <xsl:when test=".//colour/other">
                                <xsl:call-template name="other">
                                    <xsl:with-param name="value" select=".//colour/other"/>
                                </xsl:call-template>
                            </xsl:when>
                        </xsl:choose>
                    </crm:E26_Physical_Feature>
                </crm:P56_bears_feature>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test=".//quality[fine | medium | poor | other]">
                <crm:P44_has_condition>
                    <crm:E3_Condition_State>
                        <xsl:attribute name="rdf:about"
                            select="concat($component, '#', 'paper-', $ID, '-quality')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300179462">
                                <rdfs:label xml:lang="en">quality</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <xsl:choose>
                            <xsl:when test=".//quality/fine">
                                <crm:P2_has_type>
                                    <crm:E55_Type
                                        rdf:about="http://wiktionary.dbpedia.org/resource/fine">
                                        <rdfs:label xml:lang="en">fine</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </xsl:when>
                            <xsl:when test=".//quality/medium">
                                <crm:P2_has_type>
                                    <crm:E55_Type
                                        rdf:about="http://wiktionary.dbpedia.org/resource/medium-English-Adjective-2en">
                                        <rdfs:label xml:lang="en">medium</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </xsl:when>
                            <xsl:when test=".//quality/poor">
                                <crm:P2_has_type>
                                    <crm:E55_Type
                                        rdf:about="http://wiktionary.dbpedia.org/resource/poor-English-Adjective-2en">
                                        <rdfs:label xml:lang="en">medium</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </xsl:when>
                            <xsl:when test=".//quality/other">
                                <xsl:call-template name="other">
                                    <xsl:with-param name="value" select=".//other"/>
                                </xsl:call-template>
                            </xsl:when>
                        </xsl:choose>
                    </crm:E3_Condition_State>
                </crm:P44_has_condition>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test=".//decoration/yes">
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($component, '#', 'paper-', $ID, '-decoration')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2340">
                                <rdfs:label xml:lang="en">decoration (features)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E25_Man-Made_Feature>
                </crm:P56_bears_feature>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test=".//burnishing/yes">
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($component, '#', 'paper-', $ID, '-polishingFeature')"/>
                        <crm:P108i_was_produced_by>
                            <crm:E12_Production>
                                <xsl:attribute name="rdf:about"
                                    select="concat($component, '#', 'paper-', $ID, '-polishingEvent')"/>
                                <crm:P33_used_specific_tecnique>
                                    <crm:E29_Design_or_Procedure>
                                        <xsl:attribute name="rdf:about"
                                            select="concat($component, '#', 'paper-', $ID, '-polishing')"/>
                                        <crm:P2_has_type>
                                            <crm:E55_Type
                                                rdf:about="http://w3id.org/lob/concept/2992">
                                                <rdfs:label xml:lang="en">polishing</rdfs:label>
                                            </crm:E55_Type>
                                        </crm:P2_has_type>
                                    </crm:E29_Design_or_Procedure>
                                </crm:P33_used_specific_tecnique>
                            </crm:E12_Production>
                        </crm:P108i_was_produced_by>
                    </crm:E25_Man-Made_Feature>
                </crm:P56_bears_feature>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test=".//ruling/yes">
                <xsl:variable name="type">
                    <xsl:value-of select=".//ruling//type/node()/name()"/>
                </xsl:variable>
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="concat('ruled:', $type)"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="materialParchment">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <xsl:param name="covering"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'parchment-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2293">
                        <rdfs:label xml:lang="en">animal skin</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1485">
                        <rdfs:label xml:lang="en">parchment</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:call-template name="skinAnimal"/>
                <xsl:call-template name="reusedMat"/>
                <xsl:call-template name="skinArrangement"/>                
                <xsl:choose>
                    <xsl:when test="$covering">
                        <xsl:apply-templates mode="coverMaterialStatus" select="ancestor::cover/status"/>
                    </xsl:when>
                </xsl:choose>
            </crm:E57_Material>
        </crm:P45_consists_of>
        <xsl:call-template name="colourMat">
            <xsl:with-param name="component" select="$component"/>
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:call-template>
        <xsl:choose>
            <xsl:when test=".//ruling/yes">
                <xsl:variable name="type">
                    <xsl:value-of select=".//ruling//type/node()/name()"/>
                </xsl:variable>
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="concat('ruled:', $type)"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="skinArrangement">
        <xsl:choose>
            <xsl:when test=".//arrangementDetails/fleshsideOut">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1545">
                        <rdfs:label xml:lang="en">reversed skin</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="materialtawedSkin">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <xsl:param name="covering"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'tawedSkin-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2293">
                        <rdfs:label xml:lang="en">animal skin</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1197">
                        <rdfs:label xml:lang="en">alum-tawed skin</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:call-template name="skinAnimal"/>
                <xsl:call-template name="skinArrangement"/>
                <xsl:choose>
                    <xsl:when test="$covering">
                        <xsl:apply-templates mode="coverMaterialStatus" select="ancestor::cover/status"/>
                    </xsl:when>
                </xsl:choose>
            </crm:E57_Material>
        </crm:P45_consists_of>
        <xsl:call-template name="colourMat">
            <xsl:with-param name="component" select="$component"/>
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:call-template>
        <xsl:call-template name="stain">
            <xsl:with-param name="component" select="$component"/>
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="materialtannedSkin">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <xsl:param name="covering"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'tannedSkin-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2293">
                        <rdfs:label xml:lang="en">animal skin</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1658">
                        <rdfs:label xml:lang="en">tanned skin</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:call-template name="skinAnimal"/>
                <xsl:call-template name="skinArrangement"/>
                <xsl:choose>
                    <xsl:when test="$covering">
                        <xsl:apply-templates mode="coverMaterialStatus" select="ancestor::cover/status"/>
                    </xsl:when>
                </xsl:choose>
            </crm:E57_Material>
        </crm:P45_consists_of>
        <xsl:call-template name="colourMat">
            <xsl:with-param name="component" select="$component"/>
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="skinAnimal">
        <xsl:choose>
            <xsl:when test=".//skinAnimal[not(NC | NK)]">
                <xsl:choose>
                    <xsl:when test=".//skinAnimal/calf">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1238">
                                <rdfs:label xml:lang="en">calfskin</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//skinAnimal/goat">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1368">
                                <rdfs:label xml:lang="en">goat-sheep (caprinae skins)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1369">
                                <rdfs:label xml:lang="en">goatskin</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//skinAnimal/hairsheep">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4079">
                                <rdfs:label xml:lang="en">hairsheep</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//skinAnimal/sheep">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1368">
                                <rdfs:label xml:lang="en">goat-sheep (caprinae skins)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1593">
                                <rdfs:label xml:lang="en">sheepskin</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//skinAnimal/pig">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1503">
                                <rdfs:label xml:lang="en">pigskin</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//skinAnimal/other">
                        <xsl:call-template name="other">
                            <xsl:with-param name="value" select=".//other"/>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="reusedMat">
        <xsl:param name="other" select="'no'"/>
        <xsl:choose>
            <xsl:when test=".//previousUse[MS | Printed]">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1535">
                        <rdfs:label xml:lang="en">re-used (materials)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:choose>
                    <xsl:when test=".//MS">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1433">
                                <rdfs:label xml:lang="en">manuscript waste</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//Printed">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1523">
                                <rdfs:label xml:lang="en">printed waste</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="materialCord">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'cord-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3129">
                        <rdfs:label xml:lang="en">cord</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E57_Material>
        </crm:P45_consists_of>
    </xsl:template>

    <xsl:template name="materialHide">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'hide-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4099">
                        <rdfs:label xml:lang="en">hide</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E57_Material>
        </crm:P45_consists_of>
    </xsl:template>

    <xsl:template name="materialtextile">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <xsl:param name="covering"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'textile-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2470">
                        <rdfs:label xml:lang="en">textile</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:choose>
                    <xsl:when test="$covering">
                        <xsl:apply-templates mode="coverMaterialStatus" select="ancestor::cover/status"/>
                    </xsl:when>
                </xsl:choose>
            </crm:E57_Material>
        </crm:P45_consists_of>
        <xsl:call-template name="colourMat">
            <xsl:with-param name="component" select="$component"/>
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="materialsilk">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'silk-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2468">
                        <rdfs:label xml:lang="en">silk</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E57_Material>
        </crm:P45_consists_of>
        <xsl:call-template name="colourMat">
            <xsl:with-param name="component" select="$component"/>
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="materialCartonnage">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <xsl:param name="covering"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'cartonnage-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1241">
                        <rdfs:label xml:lang="en">cartonnage</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:choose>
                    <xsl:when test="$covering">
                        <xsl:apply-templates mode="coverMaterialStatus" select="ancestor::cover/status"/>
                    </xsl:when>
                </xsl:choose>
            </crm:E57_Material>
        </crm:P45_consists_of>
    </xsl:template>
    
    <xsl:template name="materialCopperAlloy">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <xsl:param name="furniture"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'copperAlloy-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2408">
                        <rdfs:label xml:lang="en">copper alloy</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:apply-templates select="ancestor::furniture//technique" mode="sheetMaterial">
                    <xsl:with-param name="component" select="$component"/>
                    <xsl:with-param name="ID" select="$ID"/>
                </xsl:apply-templates>
            </crm:E57_Material>
        </crm:P45_consists_of>
    </xsl:template>
    
    <xsl:template match="sheetMaterial" mode="sheetMaterial">        
        <xsl:param name="component"/>
        <xsl:param name="ID"/>        
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4616">
                <rdfs:label xml:lang="en">sheet material</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>
    
    <xsl:template name="materialSilver">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <xsl:param name="furniture"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'silver-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2420">
                        <rdfs:label xml:lang="en">silver metal</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:apply-templates select="ancestor::furniture//technique" mode="sheetMaterial">
                    <xsl:with-param name="component" select="$component"/>
                    <xsl:with-param name="ID" select="$ID"/>
                </xsl:apply-templates>
            </crm:E57_Material>
        </crm:P45_consists_of>
    </xsl:template>
    
    <xsl:template name="materialSilverGilt">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <xsl:param name="furniture"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'silverGilt-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4107">
                        <rdfs:label xml:lang="en">silver gilt</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:apply-templates select="ancestor::furniture//technique" mode="sheetMaterial">
                    <xsl:with-param name="component" select="$component"/>
                    <xsl:with-param name="ID" select="$ID"/>
                </xsl:apply-templates>
            </crm:E57_Material>
        </crm:P45_consists_of>
    </xsl:template>
    
    <xsl:template name="materialIron">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <xsl:param name="furniture"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'iron-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2416">
                        <rdfs:label xml:lang="en">iron</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:apply-templates select="ancestor::furniture//technique" mode="sheetMaterial">
                    <xsl:with-param name="component" select="$component"/>
                    <xsl:with-param name="ID" select="$ID"/>
                </xsl:apply-templates>
            </crm:E57_Material>
        </crm:P45_consists_of>
    </xsl:template>
    
    <xsl:template name="materialIvory">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <xsl:param name="furniture"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'ivory-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2398">
                        <rdfs:label xml:lang="en">ivory (bone)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:apply-templates select="ancestor::furniture//technique" mode="sheetMaterial">
                    <xsl:with-param name="component" select="$component"/>
                    <xsl:with-param name="ID" select="$ID"/>
                </xsl:apply-templates>
            </crm:E57_Material>
        </crm:P45_consists_of>
    </xsl:template>
    
    <xsl:template name="materialEnamel">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <xsl:param name="furniture"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'enamel-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3575">
                        <rdfs:label xml:lang="en">enamel (fused coating)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E57_Material>
        </crm:P45_consists_of>
    </xsl:template>

    <xsl:template name="materialWood">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <xsl:param name="furniture"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#', 'wood-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2480">
                        <rdfs:label xml:lang="en">wood</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:choose>
                    <xsl:when test=".//hardness[hardwood | .//beech]">
                        <xsl:comment>In the Ligatus schema beech was erroneously listed under softwood;
                            the mistake is here corrected by not listing beech as type softwood</xsl:comment>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1386">
                                <rdfs:label xml:lang="en">hardwood</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <xsl:choose>
                            <xsl:when test=".//beech">
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2830">
                                        <rdfs:label xml:lang="en">beech</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </xsl:when>
                            <xsl:when test=".//oak">
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2976">
                                        <rdfs:label xml:lang="en">oak</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test=".//hardness/softwood[not(beech)]">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1611">
                                <rdfs:label xml:lang="en">softwood</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                </xsl:choose>
                <xsl:apply-templates select="ancestor::furniture//technique" mode="sheetMaterial">
                    <xsl:with-param name="component" select="$component"/>
                    <xsl:with-param name="ID" select="$ID"/>
                </xsl:apply-templates>
            </crm:E57_Material>
        </crm:P45_consists_of>
    </xsl:template>

    <xsl:template name="materialThread">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <crm:P45_consists_of>
            <crm:E57_Material>
                <!-- The component of which the material is part is passed through as a parameter  -->
                <xsl:attribute name="rdf:about" select="concat($component, '#thread-', $ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2474">
                        <rdfs:label xml:lang="en">thread</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
                <xsl:choose>
                    <xsl:when test="name() eq 'sewing'">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4533">
                                <rdfs:label xml:lang="en">sewing thread</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <crm:P16i_was-used-for>
                            <crm:E12_Production>
                                <xsl:attribute name="rdf:about"
                                    select="concat($filename_sewing, '#sewingEvent')"/>
                                <crm:P33_used_specific_technique>
                                    <crm:E29_Design_or_Procedure>
                                        <xsl:attribute name="rdf:about"
                                            select="concat($filename_sewing, '#sewingTechnique')"/>
                                        <crm:P2_has_type>
                                            <crm:E55_Type
                                                rdf:about="http://w3id.org/lob/concept/2362">
                                                <rdfs:label xml:lang="en">sewing
                                                  (techniques)</rdfs:label>
                                            </crm:E55_Type>
                                        </crm:P2_has_type>
                                    </crm:E29_Design_or_Procedure>
                                </crm:P33_used_specific_technique>
                            </crm:E12_Production>
                        </crm:P16i_was-used-for>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test=".//material[parent::thread | parent::threadMaterial]/plain">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1505">
                                <rdfs:label xml:lang="en">plain thread</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//material[parent::thread | parent::threadMaterial]/metal">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2970">
                                <rdfs:label xml:lang="en">metal thread</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//material[parent::thread | parent::threadMaterial]/wool">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4506">
                                <rdfs:label xml:lang="en">wool hair</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//material[parent::thread | parent::threadMaterial]/silk">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2468">
                                <rdfs:label xml:lang="en">silk (fibre)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test=".//ply/Sply">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1554">
                                <rdfs:label xml:lang="en">s-twist thread</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//ply/Zply">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1714">
                                <rdfs:label xml:lang="en">z-twist thread</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test=".//twist/loose">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1430">
                                <rdfs:label xml:lang="en">loose twist thread</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//twist/medium">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1439">
                                <rdfs:label xml:lang="en">medium twist thread</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                    <xsl:when test=".//twist/tight">
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1670">
                                <rdfs:label xml:lang="en">tight twist thread</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test=".//thickness[parent::thread | parent::threadMaterial]">
                        <crm:P43_has_dimension>
                            <crm:E54_Dimension>
                                <xsl:attribute name="rdf:about"
                                    select="concat($component, '#', 'threadThickness-', $ID)"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300055646">
                                        <rdfs:label>thickness</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                                <crm:P3_has_note xml:lang="en">
                                    <xsl:value-of
                                        select=".//thickness[parent::thread | parent::threadMaterial]/element()/name()"
                                    />
                                </crm:P3_has_note>
                            </crm:E54_Dimension>
                        </crm:P43_has_dimension>
                    </xsl:when>
                </xsl:choose>
            </crm:E57_Material>
        </crm:P45_consists_of>
    </xsl:template>

    <xsl:template name="stain">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <xsl:choose>
            <xsl:when test=".//stain[text() | yes/text()]">
                <crm:P56_bears_feature>
                    <crm:E25_Man-Made_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($component, '#', $ID, '-stain')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1636">
                                <rdfs:label xml:lang="en">stained decoration</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                        <xsl:choose>
                            <xsl:when test=".//stain | yes/text()">
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300056130">
                                        <rdfs:label xml:lang="en-GB">colour (perceived
                                            attribute)</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                                <crm:P3_has_note>
                                    <xsl:attribute name="xml:lang" select="en"/>
                                    <xsl:value-of select=".//stain | yes/text()"/>
                                </crm:P3_has_note>
                            </xsl:when>
                        </xsl:choose>
                        <crm:P108i_was_produced_by>
                            <crm:E12_Production>
                                <xsl:attribute name="rdf:about"
                                    select="concat($component, '#', $ID, '-stainEvent')"/>
                                <crm:P33_used_specific_technique>
                                    <crm:E29_Design_or_Procedure>
                                        <xsl:attribute name="rdf:about"
                                            select="concat($component, '#', $ID, '-staining')"/>
                                        <crm:P2_has_type>
                                            <crm:E55_Type
                                                rdf:about="http://w3id.org/lob/concept/3876">
                                                <rdfs:label xml:lang="en">staining</rdfs:label>
                                            </crm:E55_Type>
                                        </crm:P2_has_type>
                                    </crm:E29_Design_or_Procedure>
                                </crm:P33_used_specific_technique>
                            </crm:E12_Production>
                        </crm:P108i_was_produced_by>
                    </crm:E25_Man-Made_Feature>
                </crm:P56_bears_feature>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="colourMat">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>
        <xsl:choose>
            <xsl:when test="./child::node()[1]/colour[1]/text()">
                <crm:P56_bears_feature>
                    <crm:E26_Physical_Feature>
                        <xsl:attribute name="rdf:about"
                            select="concat($component, '#', $ID, '-colour')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://vocab.getty.edu/aat/300056130">
                                <rdfs:label xml:lang="en-GB">colour (perceived
                                    attribute)</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E26_Physical_Feature>
                </crm:P56_bears_feature>
                <xsl:call-template name="other">
                    <xsl:with-param name="value">
                        <xsl:variable name="label">
                            <xsl:value-of select="concat('colour: ', ./child::node()[1]/colour[1])"/>
                        </xsl:variable>
                        <xsl:value-of select="$label"/>
                    </xsl:with-param>
                    <xsl:with-param name="lang" select="'en-GB'"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
