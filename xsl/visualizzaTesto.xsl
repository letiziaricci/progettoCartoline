<?xml version="1.0" encoding="UTF-8"?>
  <xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:tei="http://www.tei-c.org/ns/1.0"
      xmlns="http://www.w3.org/1999/xhtml">

    <xsl:param name="id" />

    <xsl:template match="tei:teiCorpus">

        <div id="content-text">
            <xsl:apply-templates select="tei:TEI" />


        </div>

     </xsl:template>

     <xsl:template match="tei:TEI[@xml:id=$id]">

      <div class="blocco"> <!-- Creazione di un div per ogni file incluso in cartoline.xml -->

        <h2><xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:title" /></h2>

                    <div class="content_tooltip">

                        <!--  <xsl:for-each select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']"> -->
                              <div class="scrittoamano">

                                      <div class="apertura">
                                          <xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']//tei:dateline"/>
                                      </div>
                                      <br />
                                      <div class="testo">
                                            <xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:div[@type='postcard-body']"/>
                                      </div>
                                      <br />
                                      <div class="chiusura">
                                             <xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer"/>
                                      </div>
                                      <br />
                                      <xsl:if test="tei:text/tei:body/tei:div[@type='fronte']/tei:div[@type='message']">
                                             <xsl:apply-templates select="tei:text/tei:body/tei:div[@type='fronte']/tei:div[@type='message']/tei:p"/>
                                      </xsl:if>
                              </div>
                    </div>
      </div>

</xsl:template>

<xsl:template match="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']//tei:dateline">
    <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:div[@type='postcard-body']">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer">
<xsl:apply-templates/>
</xsl:template>



<xsl:template match="tei:choice">
    <xsl:value-of select="tei:reg"/>
</xsl:template>

<xsl:template match="tei:unclear">
  <xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="tei:gap">
    <xsl:text>[ ]</xsl:text>
</xsl:template>


<xsl:template match="tei:p">
  <xsl:for-each select="tei:lb">
      <xsl:for-each select="following-sibling::node()[preceding-sibling::tei:lb[2]]">
        <xsl:choose>
          <xsl:when test="self::*">
              <xsl:apply-templates select="."/>
          </xsl:when>
          <xsl:otherwise>
              <xsl:value-of select="."></xsl:value-of>
          </xsl:otherwise> 
        </xsl:choose>
      </xsl:for-each>
<br/>
</xsl:for-each>
</xsl:template>

<xsl:template match="tei:s">
  <xsl:apply-templates select="tei:lb/following-sibling::node()"/>
  <br/>
</xsl:template>

<xsl:template match="tei:signed">
  <xsl:value-of select="."/>
</xsl:template>




<xsl:template match="text()">
<xsl:value-of select="." />
</xsl:template>

<xsl:template match="tei:TEI">
<xsl:apply-templates />
</xsl:template>

<xsl:template match="@*|node()">
<xsl:text />
</xsl:template>

</xsl:stylesheet>
