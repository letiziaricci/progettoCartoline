<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml" >

  <xsl:param name="id" />

  <xsl:template match="tei:teiCorpus">

    <div id="content-img">

      <xsl:apply-templates select="tei:TEI" />

    </div>

  </xsl:template>

    <xsl:template match="tei:TEI[@xml:id=$id]">


        <h2><xsl:value-of select="tei:teiHeader/tei:fileDesc/*/tei:bibl/tei:title" /></h2>

        <img src="img-cartoline/{$id}F.jpg" alt="{$id}" id="{$id}" class="openImg"/>  



      </xsl:template>


      <xsl:template match="tei:TEI">
        <xsl:apply-templates />
      </xsl:template>

      <xsl:template match="@*|node()">
        <xsl:text />
      </xsl:template>

      </xsl:stylesheet>
