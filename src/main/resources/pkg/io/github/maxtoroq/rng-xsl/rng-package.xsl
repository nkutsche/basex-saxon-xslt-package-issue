<?xml version="1.0" encoding="UTF-8"?>
<!--
    Copyright 2023 Nico Kutscherauer
-->
<!DOCTYPE configuration [<!ENTITY % versions SYSTEM "version.ent">%versions;]>
<xsl:package xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:mtq="http://maxtoroq.github.io/rng-xsl"
    xmlns:r="http://maxtoroq.github.io/rng.xsl"
    package-version="&project.version;"
    name="http://maxtoroq.github.io/rng-xsl"
    declared-modes="false"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    
    <xsl:import href="rng-lib.xsl"/>
    
    
    <xsl:variable name="r:error-code" select="QName('http://maxtoroq.github.io/rng.xsl', 'r:validation-failed')"/>
    
    <xsl:function name="r:validate" visibility="final" as="node()">
        <xsl:param name="schema" as="document-node()"/>
        <xsl:param name="instance" as="node()"/>
        <xsl:sequence select="
            if (r:is-valid($instance, $schema)) 
            then $instance 
            else error($r:error-code, 'Source instance is not valid against the given schema.')
            "/>
    </xsl:function>

    <xsl:function name="r:is-valid" visibility="final" as="xs:boolean">
        <xsl:param name="instance" as="node()"/>
        <xsl:param name="schema" as="document-node()"/>
        <xsl:call-template name="r:main">
            <xsl:with-param name="instance" select="$instance"/>
            <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
    </xsl:function>
    
</xsl:package>