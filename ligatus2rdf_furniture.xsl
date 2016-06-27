<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="book/furniture/yes">
        <xsl:result-document href="{$filepath_furniture}" method="xml" indent="yes" encoding="utf-8">
            <rdf:RDF>
                <xsl:call-template name="namespaceDeclaration"/>
                <!-- In LoB fastenings are not classified as part of the furniture: this separates the elements in fastenings and furniture -->
                <xsl:choose>
                    <xsl:when
                        test="furniture[type[clasp | catchplate | pin | straps | strapPlates | strapCollars | ties]]">
                        <xsl:for-each
                            select="furniture/type[clasp | catchplate | pin | straps | strapPlates | strapCollars | ties]">
                            <crm:E22_Man-Made_Object>
                                <xsl:attribute name="rdf:about"
                                    select="
                                        concat($filename_furniture, '#fasteningComp', position())"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2893">
                                        <rdfs:label xml:lang="en">fastenings</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                                <xsl:apply-templates mode="furniture">
                                    <xsl:with-param name="ID" select="concat('fasteningComp',position())"/>
                                </xsl:apply-templates>
                                <crm:P46i_forms_part_of>
                                    <crm:E22_Man-Made_Object>
                                        <xsl:attribute name="rdf:about"
                                            select="concat($filename_main, '#', $fileref)"/>
                                    </crm:E22_Man-Made_Object>
                                </crm:P46i_forms_part_of>
                            </crm:E22_Man-Made_Object>
                        </xsl:for-each>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when
                        test="furniture[type[bosses | corners | plates | fullCover | articulatedMetalSpines | other]]">

                        <xsl:for-each
                            select="furniture/type[bosses | corners | plates | fullCover | articulatedMetalSpines | other]">
                            <crm:E22_Man-Made_Object>
                                <xsl:attribute name="rdf:about"
                                    select="
                                        concat($filename_furniture, '#furnitureComp', position())"/>
                                <crm:P2_has_type>
                                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1353">
                                        <rdfs:label xml:lang="en">furniture
                                            (components)</rdfs:label>
                                    </crm:E55_Type>
                                </crm:P2_has_type>
                                <xsl:apply-templates mode="furniture">
                                    <xsl:with-param name="ID" select="concat('furnitureComp',position())"/>
                                </xsl:apply-templates>
                                <crm:P46i_forms_part_of>
                                    <crm:E22_Man-Made_Object>
                                        <xsl:attribute name="rdf:about"
                                            select="concat($filename_main, '#', $fileref)"/>
                                    </crm:E22_Man-Made_Object>
                                </crm:P46i_forms_part_of>
                            </crm:E22_Man-Made_Object>
                        </xsl:for-each>
                    </xsl:when>
                </xsl:choose>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="clasp[not(type/piercedStrap)]" mode="furniture">
        <xsl:param name="ID"/>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1254">
                <rdfs:label xml:lang="en">clasps (components)</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="furniture">
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="type/stirrupRing" mode="furniture">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3037">
                <rdfs:label xml:lang="en">slotted pin-clasps</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type/simpleHook" mode="furniture">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4476">
                <rdfs:label xml:lang="en">single hooked clasps</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type/foldedHook" mode="furniture">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4478">
                <rdfs:label xml:lang="en">folded hooked clasps</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="clasp/type/piercedStrap" mode="furniture">        
        <xsl:param name="ID"/>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3411">
                <rdfs:label xml:lang="en">straps (fastening components)</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="name()"/>
        </xsl:call-template>
        <xsl:apply-templates mode="furniture">
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="type/other" mode="furniture">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="."/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="catchplate" mode="furniture">
        <xsl:param name="ID"/>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1244">
                <rdfs:label xml:lang="en">catchplates</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="furniture">
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="type/rollerRoundBar" mode="furniture">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2827">
                <rdfs:label xml:lang="en">bar catchplates</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type/raisedLip" mode="furniture">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2954">
                <rdfs:label xml:lang="en">lipped catchplates</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3000">
                <rdfs:label xml:lang="en">raised-lip catchplates</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type/bentAndSlotted" mode="furniture">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2831">
                <rdfs:label xml:lang="en">bent and slotted catchplates</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="pin" mode="furniture">
        <xsl:param name="ID"/>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2987">
                <rdfs:label xml:lang="en">pins (fastening components)</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="furniture">
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="location/edge" mode="furniture">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1304">
                <rdfs:label xml:lang="en">edge pins</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="location/side" mode="furniture">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3026">
                <rdfs:label xml:lang="en">side pins</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type/simplePin" mode="furniture">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4323">
                <rdfs:label xml:lang="en">spiked pins</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type/fastenedPin" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:choose>
            <xsl:when test="ancestor::pin/location/edge">
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2891">
                        <rdfs:label xml:lang="en">fastened edge pins</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="other">
                    <xsl:with-param name="value" select="'fastened pin'"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="straps" mode="furniture">
        <xsl:param name="ID"/>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3411">
                <rdfs:label xml:lang="en">straps (fastening components)</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="furniture">
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="type/tripleBraidedStrap" mode="furniture">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1400">
                <rdfs:label xml:lang="en">interlaced straps</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4330">
                <rdfs:label xml:lang="en">triple interlaced straps</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type/doubleBraidedStrap" mode="furniture">
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1400">
                <rdfs:label xml:lang="en">interlaced straps</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3050">
                <rdfs:label xml:lang="en">double interlaced straps</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
    </xsl:template>

    <xsl:template match="type/flat" mode="furniture">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="name()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="materials" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:apply-templates mode="furniture">
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="laminated/yes" mode="furniture">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="'laminated'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="strapPlates" mode="furniture">
        <xsl:param name="ID"/>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3049">
                <rdfs:label xml:lang="en">strap plates</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="furniture">
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="strapCollars" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="name()"/>
        </xsl:call-template>
        <xsl:apply-templates mode="furniture">
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="ties" mode="furniture">
        <xsl:param name="ID"/>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1669">
                <rdfs:label xml:lang="en">ties</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="furniture">
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="bosses" mode="furniture">
        <xsl:param name="ID"/>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/1230">
                <rdfs:label xml:lang="en">bosses</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="furniture">
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="corners" mode="furniture">
        <xsl:param name="ID"/>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2866">
                <rdfs:label xml:lang="en">corners</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="furniture">
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="plates" mode="furniture">
        <xsl:param name="ID"/>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2990">
                <rdfs:label xml:lang="en">plates (furniture)</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="furniture">
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="fullCover" mode="furniture">
        <xsl:param name="ID"/>
        <crm:P2_has_type>
            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4488">
                <rdfs:label xml:lang="en">metal sides</rdfs:label>
            </crm:E55_Type>
        </crm:P2_has_type>
        <xsl:apply-templates mode="furniture">
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="articulatedMetalSpines" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="other">
            <xsl:with-param name="value"
                select="concat('articulated metal spine,', type/element()/name())"/>
        </xsl:call-template>
        <xsl:apply-templates mode="furniture">
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:apply-templates>
    </xsl:template>
<!--
    <xsl:template match="other[parent::type/parent::furniture]" mode="furniture">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="."/>
        </xsl:call-template>
    </xsl:template>-->

    <xsl:template match="material/tannedSkin" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="materialtannedSkin">
            <xsl:with-param name="component" select="$filename_furniture"/>
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/tawedSkin" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="materialtawedSkin">
            <xsl:with-param name="component" select="$filename_furniture"/>
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/parchment" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="materialParchment">
            <xsl:with-param name="component" select="$filename_furniture"/>
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/textile" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="materialtextile">
            <xsl:with-param name="component" select="$filename_furniture"/>
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/silk" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="materialsilk">
            <xsl:with-param name="component" select="$filename_furniture"/>
            <xsl:with-param name="ID" select="$ID"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/copperAlloy" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="materialCopperAlloy">
            <xsl:with-param name="component" select="$filename_furniture"/>
            <xsl:with-param name="ID" select="$ID"/>
            <xsl:with-param name="furniture" select="true()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/silver" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="materialSilver">
            <xsl:with-param name="component" select="$filename_furniture"/>
            <xsl:with-param name="ID" select="$ID"/>
            <xsl:with-param name="furniture" select="true()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/silverGilt" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="materialSilverGilt">
            <xsl:with-param name="component" select="$filename_furniture"/>
            <xsl:with-param name="ID" select="$ID"/>
            <xsl:with-param name="furniture" select="true()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/iron" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="materialIron">
            <xsl:with-param name="component" select="$filename_furniture"/>
            <xsl:with-param name="ID" select="$ID"/>
            <xsl:with-param name="furniture" select="true()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/wood" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="materialWood">
            <xsl:with-param name="component" select="$filename_furniture"/>
            <xsl:with-param name="ID" select="$ID"/>
            <xsl:with-param name="furniture" select="true()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/ivory" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="materialIvory">
            <xsl:with-param name="component" select="$filename_furniture"/>
            <xsl:with-param name="ID" select="$ID"/>
            <xsl:with-param name="furniture" select="true()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="material/other" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="."/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="technique/enamelled" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="materialEnamel">
            <xsl:with-param name="component" select="$filename_furniture"/>
            <xsl:with-param name="ID" select="$ID"/>
            <xsl:with-param name="furniture" select="true()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="technique/cast" mode="furniture">
        <xsl:param name="ID"/>
        <crm:P108i_was_produced_by>
            <crm:E12_Production>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_furniture, '#castingEvent')"/>
                <crm:P33_used_specific_technique>
                    <crm:E29_Design_or_Procedure>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_furniture, '#castingTechnique')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2844">
                                <rdfs:label xml:lang="en">casting</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E29_Design_or_Procedure>
                </crm:P33_used_specific_technique>
            </crm:E12_Production>
        </crm:P108i_was_produced_by>
    </xsl:template>

    <xsl:template match="technique/repousse" mode="furniture">
        <xsl:param name="ID"/>
        <crm:P108i_was_produced_by>
            <crm:E12_Production>
                <xsl:attribute name="rdf:about"
                    select="concat($filename_furniture, '#embossingEvent')"/>
                <crm:P33_used_specific_technique>
                    <crm:E29_Design_or_Procedure>
                        <xsl:attribute name="rdf:about"
                            select="concat($filename_furniture, '#embossingTechnique')"/>
                        <crm:P2_has_type>
                            <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2884">
                                <rdfs:label xml:lang="en">metal embossing</rdfs:label>
                            </crm:E55_Type>
                        </crm:P2_has_type>
                    </crm:E29_Design_or_Procedure>
                </crm:P33_used_specific_technique>
            </crm:E12_Production>
        </crm:P108i_was_produced_by>
    </xsl:template>

    <xsl:template match="technique/other" mode="furniture">
        <xsl:param name="ID"/>
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="."/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="throughPastedown/yes">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="'through pastedown'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="throughPastedown/no">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="'not through pastedown'"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="throughPastedown/NA">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="'not through pastedown'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="throughPastedown/other">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="concat('through pastedown:', .)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="pastedownSide/under | trough">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="name()"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="pastedownSide/other">
        <xsl:call-template name="other">
            <xsl:with-param name="value" select="concat('pastedown side: ', .)"/>
        </xsl:call-template>
    </xsl:template>

</xsl:stylesheet>
