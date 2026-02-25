<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xpm="http://www.nkutsche.com/xpath-model"
    xmlns:es="http://bsi.bund.de/ns/edit-script"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:use-package name="http://www.nkutsche.com/xpath-model" package-version="*"/>
    
    <xsl:template name="init" match="/*">
        <xsl:sequence select="xpm:xpath-model(.)"/>
    </xsl:template>
    
</xsl:stylesheet>