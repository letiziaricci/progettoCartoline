<?xml version="1.0" encoding="UTF-8"?>
  <xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:tei="http://www.tei-c.org/ns/1.0"
      xmlns="http://www.w3.org/1999/xhtml">

  <xsl:template match="tei:teiCorpus">


          <div class="general">

            <xsl:for-each select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:history/tei:p" >
              <p><xsl:value-of select="." /></p>

            </xsl:for-each>

          </div>

  </xsl:template>
</xsl:stylesheet>
