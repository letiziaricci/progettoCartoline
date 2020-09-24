<?xml version="1.0" encoding="UTF-8"?>
  <xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:tei="http://www.tei-c.org/ns/1.0"
      xmlns="http://www.w3.org/1999/xhtml">

  <xsl:param name="id" />

  <xsl:template match="tei:teiCorpus">

        <xsl:apply-templates select="tei:TEI" />

    </xsl:template>

    <xsl:template match="tei:TEI[@xml:id=$id]">

        <div class="metadatiC">

          <a href="sito.html"><img src="ext/back.png" alt="back" class="back"/></a>
            <h2><xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:title" /></h2>

            <div class="box">
                <img src="img-cartoline/{$id}F.jpg" alt="{$id}" id="meta-{$id}" class="meta"/>
              <ul class="ops">
                <li><img src="ext/picture.png"  alt="img" id="img-{$id}" class="open"/></li>
                <li><img src="ext/text.png" alt="testo" id="text-{$id}" class="text"/></li>
                <li><img src="ext/link.png" alt="link" id="link-{$id}" class="link"/></li>
              </ul>
            </div>

          <div class="boxTesto">
            <h3>Informazioni sull'opera d'arte</h3>
            <p>Titolo: <xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:title" /></p>
            <p>Autore dell'illustrazione:
            <xsl:choose>
              <xsl:when test="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:author">
                 <xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:author" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>---</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
            </p>
            <p>Descrizione:
            <xsl:choose>
              <xsl:when test="tei:text/tei:body/*/tei:figure/tei:figDesc">
                 <xsl:value-of select="tei:text/tei:body/*/tei:figure/tei:figDesc" />
              </xsl:when>
              <xsl:otherwise>
                 <xsl:text>---</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
            </p>
            <h3>Informazioni identificative della cartolina</h3>
            <p>Editore:
              <xsl:choose>
                <xsl:when test="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:publisher">
                    <xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:publisher" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>---</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </p>
            <p>Luogo di publicazione:
            <xsl:choose>
              <xsl:when test="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:pubPlace">
                 <xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:pubPlace" />
              </xsl:when>
              <xsl:otherwise>
                 <xsl:text>---</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
            </p>
            <p>Data di publicazione:
            <xsl:choose>
              <xsl:when test="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:date">
                 <xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:date" />
              </xsl:when>
              <xsl:otherwise>
                 <xsl:text>---</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
            </p>
            <p>Dimensioni: <xsl:value-of select="//tei:support/tei:dimensions/tei:height" />x<xsl:value-of select="//tei:support/tei:dimensions/tei:width" /><xsl:value-of select="//tei:support/tei:dimensions/@unit" /></p>
            <p>Codice identificativo: <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:idno"  /></p>
            <p>Collocazione: <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:repository" /></p>
          </div>
        </div>

  </xsl:template>

  <xsl:template match="tei:TEI">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:text />
  </xsl:template>
</xsl:stylesheet>
