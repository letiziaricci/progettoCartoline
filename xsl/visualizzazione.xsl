<?xml version="1.0" encoding="UTF-8"?>
  <xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:tei="http://www.tei-c.org/ns/1.0"
      xmlns="http://www.w3.org/1999/xhtml">

  <xsl:template match="tei:teiCorpus">
          <h2><xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title" /></h2>
          <h4>Donazione Borghi - Museo Civico Etnografico “Giovanni Podenzana” della Spezia</h4>

          <div class="tot">
          <xsl:for-each select="tei:TEI">
            <div class="container">
            <xsl:variable name="id" select="@xml:id" />
                <img src="img-cartoline/{$id}F.jpg" alt="{$id}" id="{$id}" class="meta"/>
              <p><xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:title" /></p>
              <ul class="option">
                <li><!--<a href="img-cartoline/{$id}F.jpg" class="lightbox_trigger">--><img src="ext/picture.png" alt="img" id="{$id}" class="open"></img><!--</a>--></li>
                <li><img src="ext/link.png" alt="link" id="{$id}" class="link"/></li>
                <li><img src="ext/text.png" alt="testo" id="{$id}" class="text"/></li>
              </ul>
            </div>
          </xsl:for-each>
        </div>
          <br/>

  </xsl:template>
</xsl:stylesheet>
