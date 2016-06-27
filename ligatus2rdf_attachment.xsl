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
    <xsl:template name="attachmentMethod-sewn">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>        
        <crm:P33_used_specific_technique>
            <crm:E29_Design_or_Procedure>
                <!-- The file path of the component is passed through as a parameter  -->
                <xsl:attribute name="rdf:about"
                    select="concat($component, '#sewing' ,$ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/2362">
                        <rdfs:label xml:lang="en">sewing (techniques)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E29_Design_or_Procedure>
        </crm:P33_used_specific_technique>                
    </xsl:template>
    
    <xsl:template name="attachmentMethod-adhered">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>        
        <crm:P33_used_specific_technique>
            <crm:E29_Design_or_Procedure>
                <!-- The file path of the component is passed through as a parameter  -->
                <xsl:attribute name="rdf:about"
                    select="concat($component, '#adhering' ,$ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/3901">
                        <rdfs:label xml:lang="en">adhering (forwarding)</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E29_Design_or_Procedure>
        </crm:P33_used_specific_technique>                
    </xsl:template>
    
    <xsl:template name="attachmentMethod-nailed">
        <xsl:param name="component"/>
        <xsl:param name="ID"/>        
        <crm:P33_used_specific_technique>
            <crm:E29_Design_or_Procedure>
                <!-- The file path of the component is passed through as a parameter  -->
                <xsl:attribute name="rdf:about"
                    select="concat($component, '#nailing' ,$ID)"/>
                <crm:P2_has_type>
                    <crm:E55_Type rdf:about="http://w3id.org/lob/concept/4045">
                        <rdfs:label xml:lang="en">nailing</rdfs:label>
                    </crm:E55_Type>
                </crm:P2_has_type>
            </crm:E29_Design_or_Procedure>
        </crm:P33_used_specific_technique>                
    </xsl:template>

</xsl:stylesheet>
