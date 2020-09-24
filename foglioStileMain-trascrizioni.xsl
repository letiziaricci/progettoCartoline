<?xml version="1.0" encoding="UTF-8"?>
    <xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*" />

    <xsl:template match="/">

      <xsl:for-each select="tei:teiCorpus/tei:TEI">

        <xsl:variable name="id" select="tei:text/tei:body/tei:div[@type='retro']/@xml:id"/>

          <xsl:result-document method="xml" href="{$id}.xml" encoding="UTF-8" indent="yes">

          <tei:TEI xml:id="{$id}">
<!-- il teiCorpus utilizzato è quello composto dagli XML-TEI dalle trascrizioni delle cartoline -->
          <tei:teiHeader>

          </tei:teiHeader>

          <tei:text> <!-- text -->
            <tei:front>

            </tei:front>
            <tei:body>
              <tei:div type='retro'>    <!-- div retro-->

                    <tei:div type="message">
                        <xsl:copy-of select="tei:text/tei:body/tei:div[@type='retro']/tei:opener"/>
                        <xsl:copy-of select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='postcard-body']"/>
                        <xsl:copy-of select="tei:text/tei:body/tei:div[@type='retro']/tei:closer"/>
                    </tei:div>
                    <xsl:copy-of select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='address-destination']"/>

                <tei:div type='postmark-postage'>
                  <tei:ab>

                  </tei:ab>
                </tei:div>
                <tei:div type='secondamano'>
                  <tei:ab type="paratext">
                    <tei:add>

                  </tei:add>
                  </tei:ab>
                </tei:div>
              </tei:div>

            </tei:body>
          </tei:text>

        </tei:TEI>
      </xsl:result-document>
    </xsl:for-each>

    </xsl:template>

  </xsl:stylesheet>
