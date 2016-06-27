<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="book/bibliographical">
        <xsl:result-document href="{$filepath_content}" method="xml" indent="yes" encoding="utf-8">
            <rdf:RDF>
                <xsl:call-template name="namespaceDeclaration"/>
                <crm:E33_Linguistic_Object>
                    <xsl:attribute name="rdf:about"
                        select="concat($filename_content, '#', $fileref, '-content')"/>
                    <xsl:apply-templates mode="bibliographical"/>                    
                    <crm:P128i_is_carried_by>
                        <crm:E22_Man-Made_Object>                        
                            <xsl:attribute name="rdf:about" select="concat($filename_main, '#', $fileref)"/>
                        </crm:E22_Man-Made_Object>
                    </crm:P128i_is_carried_by>
                </crm:E33_Linguistic_Object>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="title" mode="bibliographical">
        <crm:P102_has_title>
            <!-- Blank node -->
            <xsl:comment>NB: Blank node</xsl:comment>
            <crm:E35_Title>
                <rdfs:label>
                    <xsl:value-of select="title"/>
                </rdfs:label>
            </crm:E35_Title>
        </crm:P102_has_title>
    </xsl:template>

    <xsl:template match="author" mode="bibliographical">
        <crm:P94i_was_created_by>
            <!-- Blank node -->
            <xsl:comment>NB: Blank node</xsl:comment>
            <crm:E65_Creation>
                <crm:P14_carried_out_by>
                    <!-- Blank node -->
                    <xsl:comment>NB: Blank node</xsl:comment>
                    <crm:E21_Person>
                        <crm:P1_is_identified_by>
                            <!-- Blank node -->
                            <xsl:comment>NB: Blank node</xsl:comment>
                            <crm:E82_Actor_Appellation>
                                <rdfs:label>
                                    <xsl:value-of select="."/>
                                </rdfs:label>
                            </crm:E82_Actor_Appellation>
                        </crm:P1_is_identified_by>
                    </crm:E21_Person>
                </crm:P14_carried_out_by>
            </crm:E65_Creation>
        </crm:P94i_was_created_by>
    </xsl:template>

    <!-- The Schema was developed for the Printed book project at St Catherine and therefore it
        only describes printed books. We used it for MSS too, in which case we indicated 
        'NA' as the printing place and the bookseller -->
    <xsl:template match="placeOfPrinting[child::text() != 'NA']" mode="bibliographical">
        <crm:P92i_was_brought_into_existence_by>
            <!-- Blank node -->
            <xsl:comment>NB: Blank node</xsl:comment>
            <crm:E12_Production>
                <crm:P7_took_place_at>
                    <!-- Blank node -->
                    <xsl:comment>NB: Blank node</xsl:comment>
                    <crm:E53_Place>
                        <crm:P1_is_identified_by>
                            <!-- Blank node -->
                            <xsl:comment>NB: Blank node</xsl:comment>
                            <crm:E48_Place_name>
                                <rdfs:label>
                                    <xsl:value-of select="."/>
                                </rdfs:label>
                            </crm:E48_Place_name>
                        </crm:P1_is_identified_by>
                    </crm:E53_Place>
                </crm:P7_took_place_at>
                <xsl:apply-templates mode="printedBook"/>
            </crm:E12_Production>
        </crm:P92i_was_brought_into_existence_by>
    </xsl:template>

    <xsl:template match="placeOfPrinting[child::text() eq 'NA']" mode="bibliographical">
        <xsl:apply-templates mode="mss"/>
    </xsl:template>

    <xsl:template match="bookseller" mode="printedBook">
        <crm:P14_carried_out_by>
            <!-- Blank node -->
            <xsl:comment>NB: Blank node</xsl:comment>
            <crm:E39_Actor>
                <crm:P1_is_identified_by>
                    <!-- Blank node -->
                    <xsl:comment>NB: Blank node</xsl:comment>
                    <crm:E41_Appellation>
                        <rdfs:label>
                            <xsl:value-of select="."/>
                        </rdfs:label>
                    </crm:E41_Appellation>
                </crm:P1_is_identified_by>
            </crm:E39_Actor>
        </crm:P14_carried_out_by>
    </xsl:template>

    <xsl:template match="editions/edition/dateOfPrinting" mode="printedBook">
        <crm:P4_has_time-span>
            <!-- Blank node -->
            <xsl:comment>NB: Blank node</xsl:comment>
            <crm:E52_Time-Span>
                <rdfs:label>
                    <xsl:value-of select="."/>
                </rdfs:label>
            </crm:E52_Time-Span>
        </crm:P4_has_time-span>
    </xsl:template>

    <xsl:template match="editions/edition/dateOfPrinting" mode="mss">
        <crm:P92i_was_brought_into_existence_by>
            <!-- Blank node -->
            <xsl:comment>NB: Blank node</xsl:comment>
            <crm:E12_Production>
                <crm:P4_has_time-span>
                    <!-- Blank node -->
                    <xsl:comment>NB: Blank node</xsl:comment>
                    <crm:E52_Time-Span>
                        <rdfs:label>
                            <xsl:value-of select="."/>
                        </rdfs:label>
                    </crm:E52_Time-Span>
                </crm:P4_has_time-span>
            </crm:E12_Production>
        </crm:P92i_was_brought_into_existence_by>
    </xsl:template>

</xsl:stylesheet>
