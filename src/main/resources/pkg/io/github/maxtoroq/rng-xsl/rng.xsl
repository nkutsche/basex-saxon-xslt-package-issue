<?xml version="1.0" encoding="utf-8"?>
<!--
 Copyright 2015 Max Toro Q.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
-->
<stylesheet version="2.0" exclude-result-prefixes="#all"
   xmlns="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:r="http://maxtoroq.github.io/rng.xsl"
   xmlns:s="http://maxtoroq.github.io/rng.xsl/simplify"
   xpath-default-namespace="http://relaxng.org/ns/structure/1.0">

   <import href="rng-lib.xsl"/>

   <param name="r:schema" as="document-node()?"/>
    
    
   <template match="/ | @* | node()" mode="r:main">
      <param name="schema" select="$r:schema" as="document-node()"/>
      <param name="instance" select="." as="node()"/>
      <call-template name="r:main">
         <with-param name="schema" select="$schema"/>
         <with-param name="instance" select="$instance"/>
      </call-template>
   </template>

</stylesheet>