<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output omit-xml-declaration="yes" indent="yes" method="xml" xml:space="default"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="//book/dimensions/bookProfileDrawing"/>
    
    <xsl:template match="//book/openingCharacteristics/node()[not(self::hollowBack)]"/>
    
    <xsl:template match="//book/markers/yes/marker/pageMarker/conditions"/>
    
    <xsl:template match="//book/markers/yes/marker/pageMarker/profile"/>
    
    <xsl:template match="//book/insertedMaterials"/>
    
    <xsl:template match="//book/textLeaves/node()[not(self::editionMaterials)]"/>
    
    <xsl:template match="//book/textLeaves/editionMaterials/editionMaterial/material/parchment/ruling/yes/types/type/pricked/drawing"/>
    
    <xsl:template match="//book/inkPigments"/>
    
    <xsl:template match="//book/endleaves//condition"/>
    
    <xsl:template match="//book/sewing/stations/station/type/supported/type/double/route"/>
    
    <xsl:template match="//book/sewing/sewingCondition"/>
    
    <xsl:template match="//book/edges/condition"/>
    
    <xsl:template match="//book/boards/yes/boards/board/mechanicalAttachment/yesNoNK/yes/drawing"/>
    
    <xsl:template match="//book/boards/yes/boards/board/formation/spineEdgeProfile"/>
    
    <xsl:template match="//book/boards/yes/boardAttachmentCondition"/>
    
    <xsl:template match="//book/boards/yes/boardCondition"/>
    
    <xsl:template match="//book/spine/adhesive"/>
    
    <xsl:template match="//book/spine/profile/originalProfile"/>
    
    <xsl:template match="//book/spine/profile/currentProfile"/>
    
    <xsl:template match="//book/spine/lining/yes/liningsFromOutside"/>
    
    <xsl:template match="//book/spine/lining/yes/lining/liningCondition"/>
    
    <xsl:template match="//book/endbands/yes/endband/cores/yes/crossSection"/>
    
    <xsl:template match="//book/endbands/yes/endband/condition"/>
    
    <xsl:template match="//book/endbands/yes/endband/primary/yes/construction/front"/>    
    
    <xsl:template match="//book/endbands/yes/endband/primary/yes/construction/back"/>
    
    <xsl:template match="//book/endbands/yes/endband/secondary/yes/front"/>    
    
    <xsl:template match="//book/endbands/yes/endband/secondary/yes/back"/>
    
    <xsl:template match="//book/coverings/yes/cover/existingRepairs"/>
    
    <xsl:template match="//book/coverings/yes/cover/condition"/>
    
    <xsl:template match="//book/coverings/yes/cover/coverExtentions/yes/condition"/>
    
    <xsl:template match="//book/coverings/yes/cover/coverExtentions/yes/location"/>
    
    <xsl:template match="//book/coverings/yes/cover/tooling/yes/tools/tool/rubbings/rubbing/rubbingDone"/>
    
    <xsl:template match="//book/coverings/yes/cover/tooling/yes/outline"/>
    
    <xsl:template match="//book/furniture/yes/furniture/condition"/>
    
    <xsl:template match="//book/furniture/yes/location"/>
    
    <xsl:template match="//book/furniture/yes/furniture/type/bosses/bossProfile"/>
    
    <xsl:template match="//book/furniture/yes/furniture/type/pin/pinHeadShape"/>
    
    <xsl:template match="//book/additionalNotes"/>
    
</xsl:stylesheet>