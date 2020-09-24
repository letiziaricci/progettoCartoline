<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml" >

  <xsl:param name="id" />

  <xsl:template match="tei:teiCorpus">

<div type="c">

    <section id="contLink" class="content_postcard">
        <h4 class="sectionTitle">
            <xsl:value-of select="./tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
        </h4>
      <div class="postcardWrapper">

            <xsl:apply-templates select="tei:TEI[@xml:id=$id]/tei:facsimile"/> <!-- FACSIMILE -->
            <xsl:apply-templates select="tei:TEI" />
            
        </div>


    </section>


</div>

  </xsl:template>

  <xsl:template match="tei:TEI[@xml:id=$id]">

  <div class="trascrizione">

        <div class="digital">

          <div class="page">

            
            <p class="dateline manoscritto"><xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']//tei:dateline"/></p>
           
            <p class="manoscritto"><xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:div[@type='postcard-body']"/></p>
            
            <p class="manoscritto"> <xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='message']/tei:closer"/></p>

          </div>

        <xsl:if test="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='address-destination']//tei:addrLine">
          <div class="page2">
            <xsl:for-each select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='address-destination']//tei:addrLine/tei:lb/following-sibling::text()" >
                <p class="manoscritto"><xsl:value-of select="." /></p>
            </xsl:for-each>
          </div>
        </xsl:if>

    </div>
<div class="metadatazione">
        <div class="meta-tipo">

          <xsl:if test=".//tei:support//tei:stamp">
              <p class="tipografia">
                  <span class="label">Timbri e Francobolli:</span>
              </p>
          </xsl:if>
          <xsl:for-each select=".//tei:support//tei:stamp">
              <p class="tipografia">
                  *
                    <xsl:value-of select="."/>
              </p>
          </xsl:for-each>
      </div>
      <div class="meta-tipo2">
            <p class="tipografia">
                <span class="label">N° di catalogazione: </span>
                <xsl:value-of select="normalize-space(tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='secondamano']//tei:add)"/>
            </p>
            <xsl:if test=".//tei:front//tei:orgName">
                <p class="tipografia">
                    <span class="label">Editore cartolina: </span>
                    <xsl:value-of select=".//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:publisher"/>
                </p>
            </xsl:if>

            <xsl:if test=".//tei:front//tei:s">
                <p class="tipografia">
                    <span class="label">Testo tipografico:</span>
                </p>
            </xsl:if>
            <xsl:for-each select=".//tei:front//tei:s|.//tei:front//tei:ab">
                <p class="tipografia">
  
                    <xsl:for-each select="text()|*">
                        <xsl:choose>
                            <xsl:when test="self::tei:choice">
                                <xsl:value-of select="tei:abbr"/>
                            </xsl:when>
                            <xsl:when test="self::text()|self::*">
                                <xsl:value-of select="."/>
                            </xsl:when>
                            <xsl:when test="self::tei:num">
                                <xsl:value-of select="."/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </p>
            </xsl:for-each>
  
          </div>

    </div>
</div>
</xsl:template>

  
   <!-- FACSIMILIE -->
   <xsl:template match="tei:TEI[@xml:id=$id]/tei:facsimile">
       <xsl:variable name="width" select="substring-before(tei:surface/tei:graphic/@width, 'px')"/>
       <xsl:variable name="height" select="substring-before(tei:surface/tei:graphic/@height, 'px')"/>


           <img class="scan retro" src="img-cartoline/{$id}R.jpg" title="{$id}"/>
           <svg width="550.33" height="360.33" viewBox="0 0 {$width} {$height}" class="overlayPath">
               <xsl:for-each select="tei:surface[@type='retro']/tei:zone">
               <xsl:variable name="zonetype" select="@type"/>
               <xsl:variable name="zoneID" select="@xml:id"/>
                   <xsl:choose>
                       <xsl:when test="@points">
                           <xsl:variable name="points" select="@points"/>
                           <polygon points="{$points}" class="{$zonetype}" id="{$zoneID}" />
                       </xsl:when>
                       <xsl:otherwise>
                           <xsl:variable name="pointx" select="@ulx"/>
                           <xsl:variable name="pointy" select="@uly"/>
                           <xsl:variable name="widthr" select="@lrx - @ulx"/>
                           <xsl:variable name="heightr" select="@lry - @uly"/>
                           <rect x="{$pointx}" y="{$pointy}" height="{$heightr}" width="{$widthr}" class="{$zonetype}" id="{$zoneID}"/>
                       </xsl:otherwise>
                   </xsl:choose>
               </xsl:for-each>
           </svg>

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

    <xsl:template match="tei:p">
        <xsl:for-each select="tei:lb">
            <xsl:value-of select="following-sibling::text()"/>
        <br/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:s">
         <xsl:value-of select="tei:lb/following-sibling::text()"/>
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
