<?xml version="1.0" encoding="UTF-8"?>
  <xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:tei="http://www.tei-c.org/ns/1.0"
      xmlns="http://www.w3.org/1999/xhtml">

  <xsl:template match="tei:teiCorpus">

          <h2>Informazioni</h2>
          <div id="prog">
                <xsl:for-each select="tei:teiHeader/tei:fileDesc/tei:notesStmt/tei:note">
                <p class="noteInfo">
                    <xsl:value-of select="." />
                    <br />
                </p>
                </xsl:for-each>
            </div>

              <div id="title_info" class="info_list">
                  <h3>Responsabili di codifica:</h3>
                  <xsl:apply-templates select="tei:teiHeader//tei:editionStmt//tei:respStmt[(contains(tei:resp, 'Codificato da:'))]/tei:persName"/>
              </div>

              <div id="title_info" class="info_list">
                    <h3>Supervisione alla codifica:</h3>
                    <xsl:apply-templates select="tei:teiHeader//tei:editionStmt//tei:respStmt[(contains(tei:resp, 'Supervisionato da:'))]/tei:persName"/>
                </div>

              <div id="edition_info" class="info_list">
                  <h3>Responsabili di edizione:</h3>
                  <xsl:if test="tei:teiHeader//tei:editionStmt//tei:respStmt[position() > 1]">
                      <xsl:apply-templates select="tei:teiHeader//tei:editionStmt//tei:respStmt[not(contains(tei:resp, 'Codificato da:'))]" />
                  </xsl:if>
              </div>

              <div id="publication_info" class="info_list">
                  <h3>Pubblicazione e distribuzione:</h3>
                  <xsl:apply-templates select="tei:teiHeader//tei:publicationStmt"/>
              </div>

              <div id="publication_info" class="info_list">
                  <h3>Ente di appartenenza:</h3>
                  <xsl:apply-templates select="tei:teiHeader//tei:titleStmt/tei:respStmt/tei:name"/>
              </div>

  </xsl:template>

  <xsl:template match="tei:teiHeader//tei:titleStmt/tei:respStmt/tei:name">
      <div class="section_footer">
          <i class="material-icons">account_balance</i>
          <p id="location_unipi" class="location">
              <span id="abbr" class="span_info">
                  <xsl:value-of select="."/>
              </span>
          </p>
      </div>
  </xsl:template>

  <xsl:template match="tei:teiHeader//tei:publicationStmt">
      <div class="section_footer">
          <i class="material-icons">account_balance</i>
          <p id="location_unipi" class="location">
              <span id="abbr" class="span_info">
                  <xsl:value-of select="tei:publisher"/> 
              </span>
          </p>
      </div>
  </xsl:template>
  <xsl:template match="tei:teiHeader//tei:editionStmt//tei:respStmt[not(contains(tei:resp, 'Codificato da:'))]">
      <div class="section_footer">
          <p>
              <i class="material-icons">assignment</i>
              <span class="pers_role span_info">
                  <xsl:value-of select="tei:resp"/>
              </span>
              <xsl:for-each select="tei:persName">
                  <span class="pers_name span_info">
                      <xsl:value-of select="."/>
                  </span>
              </xsl:for-each>
          </p>
      </div>
  </xsl:template>

  <xsl:template match="tei:teiHeader//tei:editionStmt//tei:respStmt[(contains(tei:resp, 'Codificato da:'))]/tei:persName">
      <div class="section_footer">
          <i class="material-icons">person</i>
          <p>
              <xsl:for-each select=".">
                  <span class="pers_name span_info">
                      <xsl:value-of select="."/>
                  </span>
              </xsl:for-each>
          </p>
      </div>
  </xsl:template>

  <xsl:template match="tei:teiHeader//tei:editionStmt//tei:respStmt[(contains(tei:resp, 'Supervisionato da:'))]/tei:persName">
      <div class="section_footer">
          <i class="material-icons">person</i>
          <p>
              <xsl:for-each select=".">
                  <span class="pers_name span_info">
                      <xsl:value-of select="."/>
                  </span>
              </xsl:for-each>
          </p>
      </div>
  </xsl:template>


</xsl:stylesheet>
