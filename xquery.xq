let $xsl := resolve-uri('test.xsl')
let $file1 := resolve-uri('test.xml')
return

(
  xslt:transform(
        $file1,
        $xsl
      ),
  xslt:init(),
  xslt:transform(
        $file1,
        $xsl
      )  
  
)