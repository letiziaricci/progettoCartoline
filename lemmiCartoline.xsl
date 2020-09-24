<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:variable name="altroDoc" select="doc('linguA.xml')" />

    <xsl:template match="/">

          <xsl:variable name="id" select="tei:TEI/@xml:id"/>

          <tei:TEI xml:id="{$id}">

            <xsl:copy-of select="tei:TEI/tei:teiHeader"/>
            <xsl:copy-of select="tei:TEI/tei:facsimile"/>

            <tei:text>

              <xsl:copy-of select="tei:TEI/tei:text/tei:front"/>
              <xsl:copy-of select="tei:TEI/tei:text/tei:body"/>

            <xsl:for-each select="$altroDoc/linguistic/analisi">
              <xsl:if test="@id = $id">
              <xsl:variable name="t" select="text()"/>
              <tei:back>
                  <tei:div type="linguistic">
                      <tei:ab>
                      <xsl:for-each select="tokenize($t,'\n')"> <!-- per ogni riga -->
                        <xsl:choose>
                          <xsl:when test="matches( . , '^\s+$') or matches( . , '^$')" /> <!-- riga vuota -->
                          <xsl:otherwise>
                            <xsl:variable name="word" select="tokenize( . ,'\t')" />
                            <tei:seg lemma="{$word[3]}">
                                <tei:w type="form">
                                    <xsl:value-of select="$word[2]"/>
                                </tei:w>
                                <tei:ptr target="#string-range(//div[@type='postcard-body'],0,10)"/>
                                <tei:ptr target="#string-range(//closer,0,10)"/>
                            </tei:seg>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:for-each>
                      </tei:ab>
                  </tei:div>
            </tei:back>
            </xsl:if>
          </xsl:for-each>
        </tei:text>

      </tei:TEI>

    </xsl:template>

  </xsl:stylesheet>
