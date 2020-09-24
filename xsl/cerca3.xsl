<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:tei="http://www.tei-c.org/ns/1.0">

      <xsl:output method="xml" omit-xml-declaration="yes" media-type="application/json"/>

  <xsl:template match="tei:teiCorpus">
    <xsl:variable name="names" select="distinct-values(//tei:TEI//tei:correspAction[@type='sent']/tei:persName)" />
    <xsl:variable name="root" select="tei:TEI/tei:teiHeader" />

  <root-tmp>
  <xsl:text>[</xsl:text>
        <xsl:for-each select="$names">
          <xsl:variable name="p" select="." />

          <xsl:variable name="cart" select="$root//tei:correspAction[@type='sent'][tei:persName = $p]/ancestor::tei:TEI/@xml:id" />

      <xsl:text>       {   </xsl:text>
            <xsl:text>"value" : </xsl:text> <xsl:text>"</xsl:text><xsl:value-of select="$p" /><xsl:text>"</xsl:text><xsl:text>,</xsl:text>
            <xsl:text>"id" : </xsl:text><xsl:text>"</xsl:text><xsl:value-of select="count($cart)" /><xsl:text> cartoline</xsl:text><xsl:text>"</xsl:text><xsl:text>,</xsl:text>
            <xsl:text>"descrizione" : </xsl:text> <xsl:text>"</xsl:text><xsl:for-each select="$cart" ><img src='img-cartoline/{$cart}F.jpg' class="imgMitt"/></xsl:for-each><xsl:text>"</xsl:text>
    <xsl:text>         }     </xsl:text><xsl:text>,</xsl:text>
        </xsl:for-each>
    <xsl:text>       ]   </xsl:text>
  </root-tmp>


  </xsl:template>
</xsl:stylesheet>
