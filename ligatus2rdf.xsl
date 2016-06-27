<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:crm="http://www.cidoc-crm.org/cidoc-crm/" xmlns:lob="http://w3id.org/lob/concept/"
    xmlns:aat="http://vocab.getty.edu/aat/" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:dbp="http://dbpedia.org/resource/" xmlns:wr="http://wiktionary.dbpedia.org/resource/"
    exclude-result-prefixes="xs" version="2.0">
    
    <!-- This, non compulsory, parameter tells the stylesheet to generate output with a long list of namespace URI that will be converted into shortened URI in Turtle for easier reading;
    input should be in the form of 'yes' or 'no'-->
    <xsl:param name="toTurtle" select="'yes'"/>
    
    <!-- This, non compulsory, parameter tells the stylesheet whether to generate the reference to the SVG line drawings of endleaf structures or not;
    input should be in the form of 'yes' or 'no' -->
    <xsl:param name="SVG" select="'yes'"/>
    
    <!-- This parameter feeds the stylesheet with the general URI of the digital collection of which every other single URI is a child;
    input should be in the form of a complete URI, e.g. 'http://diglib.hab.de' -->
    <xsl:param name="collectionURI" required="yes"/>
    
    <!-- This, non compulsory, parameter allows the stylesheet to know what preferred acronym to use in the generation of the project's URIs,
    e.g. 'HAB'-->
    <xsl:param name="collectionAcronym" select="'HAB'"/>
    
    <xsl:output indent="yes" method="xml" encoding="utf-8"
        include-content-type="no"/>
    
    <xsl:variable name="shelfmark" select="//bibliographical/shelfmark"/>
    <!-- This normalises the shelfmark: removes colons, full stops, parentheses, and spaces, and replaces '°' with a lower-case 'o' -->
    <xsl:variable name="fileref" select="replace(replace($shelfmark, '[.:\s()]', ''), '°', 'o')"/>
    
    <xsl:variable name="filename_fragment_content" select="'content'"/>
    <xsl:variable name="filename_fragment_main" select="'main'"/>
    <xsl:variable name="filename_fragment_markers" select="'markers'"/>
    <xsl:variable name="filename_fragment_textblock" select="'textblock'"/>
    <xsl:variable name="filename_fragment_endleaves" select="'endleaves'"/>
    <xsl:variable name="filename_fragment_sewing" select="'sewing'"/>
    <xsl:variable name="filename_fragment_edges" select="'edges'"/>
    <xsl:variable name="filename_fragment_boards" select="'board'"/>
    <xsl:variable name="filename_fragment_spine" select="'spine'"/>
    <xsl:variable name="filename_fragment_lining" select="'lining'"/>
    <xsl:variable name="filename_fragment_endbands" select="'endband'"/>
    <xsl:variable name="filename_fragment_covering" select="'cover'"/>
    <xsl:variable name="filename_fragment_furniture" select="'furniture'"/>
    
    <xsl:variable name="filename_content" select="concat( $fileref, '_', $filename_fragment_content, '.rdf')"/>
    <xsl:variable name="filename_main" select="concat( $fileref, '.rdf')"/>
    <xsl:variable name="filename_markers" select="concat($fileref, '_', $filename_fragment_markers, '.rdf')"/>
    <xsl:variable name="filename_textblock" select="concat($fileref, '_', $filename_fragment_textblock, '.rdf')"/>
    <!-- filenames for endleaves have to be parametrized -->
    <xsl:variable name="filename_sewing" select="concat($fileref, '_', $filename_fragment_sewing, '.rdf')"/>
    <xsl:variable name="filename_edges" select="concat($fileref, '_', $filename_fragment_edges, '.rdf')"/>
    <!-- filenames for boards have to be parametrized -->
    <xsl:variable name="filename_spine" select="concat($fileref, '_', $filename_fragment_spine, '.rdf')"/>
    <xsl:variable name="filename_lining" select="concat($fileref, '_', $filename_fragment_lining, '.rdf')"/>
    <!-- filenames for endbands have to be parametrized -->
    <xsl:variable name="filename_covering" select="concat($fileref, '_', $filename_fragment_covering, '.rdf')"/>
    <xsl:variable name="filename_furniture" select="concat($fileref, '_', $filename_fragment_furniture, '.rdf')"/>
    
    
    <xsl:variable name="filepath_content"
        select="concat('../RDF/', $fileref, '/', $filename_content)"/>
    <xsl:variable name="filepath_main"
        select="concat('../RDF/', $fileref, '/', $filename_main)"/>
    <xsl:variable name="filepath_markers"
        select="concat('../RDF/', $fileref, '/', $filename_markers)"/>
    <xsl:variable name="filepath_textblock"
        select="concat('../RDF/', $fileref, '/', $filename_textblock)"/>
    <!-- Filepath for endleaves has to be parametrized -->
    <xsl:variable name="filepath_sewing"
        select="concat('../RDF/', $fileref, '/', $filename_sewing)"/>
    <xsl:variable name="filepath_edges"
        select="concat('../RDF/', $fileref, '/', $filename_edges)"/>
    <!-- Filepath for boards has to be parametrized -->
    <xsl:variable name="filepath_spine"
        select="concat('../RDF/', $fileref, '/', $filename_spine)"/>
    <xsl:variable name="filepath_lining"
        select="concat('../RDF/', $fileref, '/', $filename_lining)"/>
    <!-- Filepath for endbands has to be parametrized -->
    <xsl:variable name="filepath_covering"
        select="concat('../RDF/', $fileref, '/', $filename_covering)"/>
    <xsl:variable name="filepath_furniture"
        select="concat('../RDF/', $fileref, '/', $filename_furniture)"/>
    
    <xsl:variable name="xmlbase" select="concat($collectionURI,'/', $collectionAcronym,'bindings/objects/', $fileref, '/')"/>
    
    <xsl:include href="ligatus2rdf_content.xsl"/>
    
    <xsl:include href="ligatus2rdf_main.xsl"/>
    <xsl:include href="ligatus2rdf_markers.xsl"/>
    <xsl:include href="ligatus2rdf_textblock.xsl"/>
    <xsl:include href="ligatus2rdf_endleaves.xsl"/>    
    <xsl:include href="ligatus2rdf_sewing.xsl"/>
    <xsl:include href="ligatus2rdf_edges.xsl"/>
    <xsl:include href="ligatus2rdf_boards.xsl"/>
    <xsl:include href="ligatus2rdf_spine.xsl"/>
    <xsl:include href="ligatus2rdf_lining.xsl"/>
    <xsl:include href="ligatus2rdf_endbands.xsl"/>
    <xsl:include href="ligatus2rdf_covering.xsl"/>
    <xsl:include href="ligatus2rdf_furniture.xsl"/>
    
    <xsl:include href="ligatus2rdf_attachment.xsl"/> 
    <xsl:include href="ligatus2rdf_materials.xsl"/>    
    <xsl:include href="ligatus2rdf_general.xsl"/>
    
    <!-- MUTE all unwanted text elements -->
    <xsl:template match="text()" mode="#all"/>
    
</xsl:stylesheet>
