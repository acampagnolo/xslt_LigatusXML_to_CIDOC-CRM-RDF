# xslt_LigatusXML_to_CIDOC-CRM-RDF
Code to transform Ligatus XML descriptions of bookbindings into CIDOC-CRM RDF files (typed through the Language of Bindings thesaurus). Draft1-2016-06-26

This code was written specifically for a research project at the Herzog August Bibliothek Wolfenbüttel <http://www.hab.de/de/home/wissenschaft/gastforscher-und-alumni/stipendiatenprofile/alberto-campagnolo.html>. However the code takes a number of general parameters (see below) to adapt the output to other projects (for the generation of the URI for example).

The code is written in modules. The master file is ligatus2rdf.xsl, which includes all the other modules via <xsl:include/>
This template takes 4 general parameters to adapt the code to different projects.

   
    <!-- This, non compulsory, parameter tells the stylesheet to generate output with a long list of namespace URI that will be converted into shortened URI in Turtle for easier reading; input should be in the form of 'yes' or 'no'-->
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

The only parameter that is required at runtime is the 'collectionURI' that is used to generated all the project's URIs based on a collection web address. 

The folder structure of the project is as follows:

xslt_LigatusXML_to_CIDOC-CRM-RDF:   folder containing all the xslt modules (this GitHub repository)
Ligatus-HAB_schema:                 folder containing the Ligatus XML schema
records:                            folder containinng the XML records
RDF:                                folder containing the CIDOC-CRM RDF files
SVG:                                folder containing the SVG generated via the XSLT codes contained in the ../XSLTransformations rep.


The Oxygen project file is: HABdescriptions.xpr
