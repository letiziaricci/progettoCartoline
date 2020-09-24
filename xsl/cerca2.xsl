<?xml version="1.0" encoding="UTF-8"?>
  <xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:tei="http://www.tei-c.org/ns/1.0">

      <xsl:output method="xml" omit-xml-declaration="yes" media-type="application/json"/>

  <xsl:template match="tei:teiCorpus">
      <xsl:variable name="lemmi" select="distinct-values(//tei:text/tei:back/tei:div[@type='linguistic']/tei:ab/tei:seg/@lemma)" />
      <xsl:variable name="root" select="tei:teiCorpus" />

      <root-tmp>

        <xsl:text>[</xsl:text>
              <xsl:for-each select="$lemmi">
                <xsl:variable name="l" select="." />

                <xsl:variable name="cartXlemma" select="$root//tei:div[@type='linguistic']/tei:ab/tei:seg[@lemma = $l]/@lemma/ancestor::tei:TEI/@xml:id" />
      
            <xsl:text>       {   </xsl:text>
                  <xsl:text>     "value" : </xsl:text> <xsl:text>"</xsl:text><xsl:value-of select="$l" /><xsl:text>"</xsl:text><xsl:text>,</xsl:text>
                  <xsl:text>     "id" : </xsl:text><xsl:text>"</xsl:text><xsl:value-of select="count($cartXlemma)" /><xsl:text> cartoline</xsl:text><xsl:text>"</xsl:text><xsl:text>,</xsl:text>
                  <xsl:text>     "descrizione" : </xsl:text> <xsl:text>"</xsl:text><xsl:for-each select="$cartXlemma" ><xsl:value-of select="$cartXlemma"/></xsl:for-each><xsl:text>"</xsl:text>
          <xsl:text>         }     </xsl:text><xsl:text>,</xsl:text>
              </xsl:for-each>
          <xsl:text>       ]   </xsl:text>
        </root-tmp>


  </xsl:template>
</xsl:stylesheet>
