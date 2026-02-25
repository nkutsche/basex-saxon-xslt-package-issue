let $xsl := resolve-uri('test.xsl')
let $file1 := resolve-uri('test.xml')
return

(
      '&#xA;---- result 1 ----&#xA;',
  xslt:transform(
        $file1,
        $xsl
      ),
      '&#xA;---- result 2 ----&#xA;',
  xslt:transform(
        $file1,
        $xsl
      ),  
  '&#xA;----------------&#xA;&#xA;'
)