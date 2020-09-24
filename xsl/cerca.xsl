<?xml version="1.0" encoding="UTF-8"?>
  <xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:tei="http://www.tei-c.org/ns/1.0">

      <xsl:output method="xml" omit-xml-declaration="yes" media-type="application/json"/>

  <xsl:template match="tei:teiCorpus">

    <root-tmp>
  <xsl:text>[</xsl:text>
        <xsl:for-each select="tei:TEI">

          <xsl:variable name="id" select="@xml:id" />
      <xsl:text>       {   </xsl:text>
            <xsl:text>      "value" : </xsl:text> <xsl:text>"</xsl:text><xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:title" /><xsl:text>"</xsl:text><xsl:text>,</xsl:text>
            <xsl:text>     "id" : </xsl:text><xsl:text>"</xsl:text><xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:idno" /><xsl:text>"</xsl:text><xsl:text>,</xsl:text>
            <xsl:text>     "descrizione" : </xsl:text> <xsl:text>"</xsl:text><img src='img-cartoline/{$id}F.jpg' alt='{$id}' id='{$id}' class='imgCerca'/><xsl:text>"</xsl:text>
    <xsl:text>         }     </xsl:text><xsl:text>,</xsl:text>
        </xsl:for-each>
    <xsl:text>       ]   </xsl:text>
  </root-tmp>


  </xsl:template>
</xsl:stylesheet>
