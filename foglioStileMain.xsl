<?xml version="1.0" encoding="UTF-8"?>
    <xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*" />

    <xsl:variable name="altroDoc" select="doc('')" /> <!-- inserire il file xml dei progetti -->

    <xsl:template match="/">

    <xsl:variable name="id" select="$altroDoc/tei:TEI/@xml:id"/>

    <tei:TEI xml:id="{$id}">
<!-- il teiCorpus utilizzato è quello composto dagli XML-TEI dalle trascrizioni delle cartoline -->
          <tei:teiHeader>
                <tei:fileDesc>
                  <tei:titleStmt>
                    <tei:title><xsl:value-of select="$altroDoc/tei:TEI//tei:bibl/tei:title"/><xsl:text> - Edizione digitale</xsl:text></tei:title>
                  </tei:titleStmt>
                  <xsl:copy-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:publicationStmt" />
                  <xsl:copy-of select="$altroDoc/tei:TEI//tei:sourceDesc"/>
                </tei:fileDesc>
                <xsl:copy-of select="$altroDoc/tei:TEI//tei:profileDesc"/>
                <xsl:copy-of select="tei:teiCorpus/tei:teiHeader/tei:encodingDesc" />
          </tei:teiHeader>

            <xsl:copy-of select="$altroDoc/tei:TEI/tei:facsimile"/> <!-- facsimile -->

          <tei:text> <!-- text -->
            <tei:body>

              <xsl:copy-of select="$altroDoc/tei:TEI//tei:div[@type='fronte']"/> <!-- div fronte-->
              <tei:div type='retro'>    <!-- div retro-->
                <xsl:for-each select="tei:teiCorpus/tei:TEI" >
                  <xsl:if test=" tei:text/tei:body/tei:div/@xml:id = $altroDoc/tei:TEI/@xml:id " >
                    <tei:div type="message">
                        <xsl:copy-of select="tei:text/tei:body/tei:div[@type='retro']/tei:opener"/>
                        <xsl:copy-of select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='postcard-body']"/>
                        <xsl:copy-of select="tei:text/tei:body/tei:div[@type='retro']/tei:closer"/>
                    </tei:div>
                    <xsl:copy-of select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='address-destination']"/>
                  </xsl:if>
                </xsl:for-each>
                <tei:div type='postmark-postage'>
                  <tei:ab>
                   <xsl:copy-of select="$altroDoc/tei:TEI//tei:div[@type='destination']//tei:stamp"/> <!-- div postmark/postage-->
                   <xsl:apply-templates select="$altroDoc/tei:TEI//tei:div[@type='postmark']//tei:stamp" />
                   <xsl:apply-templates select="$altroDoc/tei:TEI//tei:div[@xml:id='right']//tei:stamp" />
                   <xsl:apply-templates select="$altroDoc/tei:TEI//tei:div[@type='francobolli_timbri']//tei:stamp" />
                   <xsl:apply-templates select="$altroDoc/tei:TEI//tei:div[@type='marchi']//tei:stamp" />
                   <!--<xsl:call-template name="stamp"/> -->
                  </tei:ab>
                </tei:div>
                <tei:div type='secondamano'>
                  <tei:ab type="paratext">
                    <tei:add>
                    <xsl:copy-of select="$altroDoc/tei:TEI//tei:div[@type='add']/tei:ab//tei:num"/> <!-- div numero seconda mano-->
                    <xsl:apply-templates select="$altroDoc/tei:TEI//tei:div[@type='rt']/tei:div[@type='rtrHand']/tei:p/tei:num" />
                    <xsl:apply-templates select="$altroDoc/tei:TEI//tei:div[@type='add']/tei:p/tei:num" />
                    <xsl:apply-templates select="$altroDoc/tei:TEI//tei:div[@type='hand']//tei:num" />
                    <xsl:apply-templates select="$altroDoc/tei:TEI//tei:div[@type='remaining']//tei:stamp[@type='catalogue_id']" />
                    <xsl:apply-templates select="$altroDoc/tei:TEI//tei:div[@type='stampe_cartolina']//tei:s[@type='catalog']" />
                    <xsl:apply-templates select="$altroDoc/tei:TEI//tei:div[@type='retro']/tei:div[@type='ccl']/tei:p/tei:num/tei:idno" />
                    <xsl:apply-templates select="$altroDoc/tei:TEI//tei:div[@type='rtrArchivio']/tei:p/tei:num/tei:idno" />
                    <xsl:apply-templates select="$altroDoc/tei:TEI//tei:div[@type='terzaMano']//tei:num" />
                    <xsl:apply-templates select="$altroDoc/tei:TEI//tei:div[@type='archivio']/tei:p/tei:idno" />
                    <xsl:apply-templates select="$altroDoc/tei:TEI//tei:div[@type='catalogazione']/tei:ab/tei:num" />
                  </tei:add>
                  </tei:ab>
                </tei:div>
              </tei:div>

            </tei:body>
          </tei:text>

    </tei:TEI>
    </xsl:template>


    <xsl:template match="$altroDoc/tei:TEI//tei:div[@type='rt']/tei:div[@type='rtrHand']/tei:p/tei:num">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="$altroDoc/tei:TEI//tei:div[@type='postmark']//tei:stamp">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="$altroDoc/tei:TEI//tei:div[@type='add']/tei:p/tei:num">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="$altroDoc/tei:TEI//tei:div[@xml:id='right']//tei:stamp">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="$altroDoc/tei:TEI//tei:div[@type='hand']//tei:num">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="$altroDoc/tei:TEI//tei:div[@type='remaining']//tei:stamp[@type='catalogue_id']">
      <tei:num type="cardinal">
        <xsl:value-of select="."/>
      </tei:num>
    </xsl:template>

    <xsl:template match="$altroDoc/tei:TEI//tei:div[@type='stampe_cartolina']//tei:s[@type='catalog']">
     <tei:num type="cardinal">
        <xsl:value-of select="."/>
     </tei:num>
    </xsl:template>

    <xsl:template match="$altroDoc/tei:TEI//tei:div[@type='francobolli_timbri']//tei:stamp">
      <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="$altroDoc/tei:TEI//tei:div[@type='retro']/tei:div[@type='ccl']/tei:p/tei:num/tei:idno">
      <tei:num type="cardinal">
        <xsl:value-of select="."/>
      </tei:num>
    </xsl:template>

    <xsl:template match="$altroDoc/tei:TEI//tei:div[@type='rtrArchivio']/tei:p/tei:num/tei:idno">
      <tei:num type="cardinal">
        <xsl:value-of select="."/>
      </tei:num>
    </xsl:template>

    <xsl:template match="$altroDoc/tei:TEI//tei:div[@type='marchi']//tei:stamp">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="$altroDoc/tei:TEI//tei:div[@type='terzaMano']//tei:num">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="$altroDoc/tei:TEI//tei:div[@type='archivio']/tei:p/tei:idno">
      <tei:num type="cardinal">
        <xsl:value-of select="."/>
      </tei:num>
    </xsl:template>

    <xsl:template match="$altroDoc/tei:TEI//tei:div[@type='catalogazione']/tei:ab/tei:num">
      <xsl:copy-of select="."/>
    </xsl:template>

  </xsl:stylesheet>
