<?xml version="1.0" encoding="UTF-8"?>
    <xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*" />

    <xsl:template match="/">
             <tei:teiCorpus xmlns="http://www.tei-c.org/ns/1.0"> <!-- corpus degli XML-TEI delle trascrizioni delle cartoline-->
	              <tei:teiHeader>
                    <tei:fileDesc> <!-- contiene le informazioni relative al documento digitale-->
                      <tei:titleStmt> <!-- titolo e responsabili dell'edizione digitale -->
                        <tei:title> Cartoline della Grande Guerra - Edizione digitale </tei:title>
                        <tei:respStmt>
                           <tei:resp>Trascritto da:</tei:resp>
                           <tei:persName>Letizia Ricci</tei:persName>
				                </tei:respStmt>
                        <tei:respStmt>
                          <tei:resp>Ente di Appartenenza:</tei:resp>
                          <tei:name>Comune di
						                    <tei:placeName>La Spezia</tei:placeName>
					                </tei:name>
				               </tei:respStmt>
                     </tei:titleStmt>
                     <tei:editionStmt> <!-- contiene informazion sull'edizione -->
				                  <tei:edition>Studenti di Codifica di testi, Corso di Laurea Triennale di Informatica Umanistica, Università di Pisa
                            <tei:date>2018</tei:date>
				                  </tei:edition>
				                  <tei:respStmt>
					                       <tei:resp>Codificato da:</tei:resp>
					                       <tei:persName>Letizia Ricci</tei:persName>
				                 </tei:respStmt>
                         <respStmt>
                                <resp>Compilatore</resp>
                                <persName>Tommaso Castagneto</persName>
                        </respStmt>
                         <tei:respStmt>
                           <tei:resp>Responsabile scientifico:</tei:resp>
                           <tei:persName>Giacomo Paolicchi</tei:persName>
                           <tei:persName>Enrica Salvatori</tei:persName>
                         </tei:respStmt>
                         <tei:respStmt>
                           <tei:resp>Funzionario responsabile:</tei:resp>
                           <tei:persName>Marzia Ratti</tei:persName>
				                 </tei:respStmt>
                   </tei:editionStmt>
                   <tei:publicationStmt> <!-- contiene informazioni sulla pubblicazione e distribuzione del documento digitale -->
                     <tei:publisher>
                       <tei:choice>
                         <tei:abbr>Unipi</tei:abbr>
                         <tei:expan>Università di
                            <tei:placeName>Pisa</tei:placeName>
                        </tei:expan>
                      </tei:choice>
                    </tei:publisher>
                    <tei:pubPlace>Pisa</tei:pubPlace>
                    <tei:availability>
                      <tei:p>Available under licence only</tei:p>
                    </tei:availability>
                    <tei:date>2019</tei:date>
                    <tei:distributor>
					                 <tei:orgName>
						                     <tei:choice>
                      	            <tei:abbr>LabCD</tei:abbr>
                       	            <tei:expan>Laboratorio di Cultura Digitale</tei:expan>
                   		           </tei:choice>
					                 </tei:orgName>
				           </tei:distributor>
                   <tei:address>
                      <tei:addrLine>Laboratorio di Cultura Digitale - Università di Pisa</tei:addrLine>
                      <tei:addrLine><tei:placeName>Pisa</tei:placeName></tei:addrLine>
				          </tei:address>
			          </tei:publicationStmt>
               </tei:fileDesc>
            </tei:teiHeader>

              <xsl:for-each select="cartoline/cartolina">
              <tei:TEI>
                <tei:text>
                  <tei:body>
                        <xsl:variable name="id" select="@id "/>
                        <tei:div type="retro" xml:id="{$id}" >

                            <xsl:call-template name="date"/> <!--  opener -->

                            <tei:div type="postcard-body">  <!-- body -->
                                <xsl:call-template name="body-retro"/>
                                <xsl:call-template name="body-fronte"/>
                            </tei:div>

                            <xsl:apply-templates select="text//salute"/> <!--  closer -->

                            <xsl:call-template name="address"/> <!-- address -->

                        </tei:div>

                  </tei:body>
                </tei:text>
              </tei:TEI>
              </xsl:for-each>

          </tei:teiCorpus>
    </xsl:template>


    <xsl:template name="date" >
      <tei:opener>
        <tei:dateline>
          <xsl:variable name="S" select="text"/>
          <xsl:for-each select="tokenize($S,'\n')">
               <xsl:if test="matches( . , '([-]*(\s)?[-]+[,]?)*([A-Z]([a-z]+))*[,]?(\s)?[a-z]*[,]?(\s)?[0-9][0-9]*((\s)([Gg]ennaio|[Ff]ebbraio|[Mm]arzo|[Aa]prile|[Mm]aggio|[Gg]iugno|[Ll]uglio|[Aa]gosto|[Ss]ettembre|[Oo]ttobre|[Nn]ovembre|[Dd]icembre)(\s))*[-/.]?[0-9]*[IVX]*[-/.]?[0-9][0-9][0-9]*[.]?')" >
                 <tei:lb/>
                 <tei:s>
                   <xsl:call-template name="text" >
                     <xsl:with-param name="txt" select="."/>
                   </xsl:call-template>
                 </tei:s>
               </xsl:if>
            </xsl:for-each>
        </tei:dateline>
      </tei:opener>
    </xsl:template>

    <xsl:template name="body-retro">
      <tei:p>
      <xsl:variable name="SimpleText" select="concat( ./text/retro/text() , ./text/retro/salute/following-sibling::text() )"/>
      <xsl:choose>
        <xsl:when test="matches( $SimpleText , '\n\n' )" >
          <xsl:variable name="rigavuota" select="string('&#x0a;&#x0a;')" />
          <xsl:variable name ="body" select="substring-before( $SimpleText , $rigavuota )" />
                <xsl:for-each select="tokenize( $body ,'\n')">
                 <xsl:choose>
                   <xsl:when test="matches( . , '^\s+$') or matches( . , '^$')" />
                   <xsl:when test="matches( . , '([-]*(\s)?[-]+[,]?)*([A-Z]([a-z]+))*[,]?(\s)?[a-z]*[,]?(\s)?[0-9][0-9]*((\s)([Gg]ennaio|[Ff]ebbraio|[Mm]arzo|[Aa]prile|[Mm]aggio|[Gg]iugno|[Ll]uglio|[Aa]gosto|[Ss]ettembre|[Oo]ttobre|[Nn]ovembre|[Dd]icembre)(\s))*[-/.]?[0-9]*[IVX]*[-/.]?[0-9][0-9][0-9]*[.]?'  )" />
                   <xsl:otherwise>
                     <tei:lb/>
                     <xsl:text />
                     <xsl:call-template name="text" >
                       <xsl:with-param name="txt" select="."/>
                     </xsl:call-template>
                   </xsl:otherwise>
                 </xsl:choose>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <xsl:for-each select="tokenize($SimpleText,'\n')">
               <xsl:choose>
                 <xsl:when test="matches( . , '^\s+$') or matches( . , '^$')" />
                 <xsl:when test="matches( . , '([-]*(\s)?[-]+[,]?)*([A-Z]([a-z]+))*[,]?(\s)?[a-z]*[,]?(\s)?[0-9][0-9]*((\s)([Gg]ennaio|[Ff]ebbraio|[Mm]arzo|[Aa]prile|[Mm]aggio|[Gg]iugno|[Ll]uglio|[Aa]gosto|[Ss]ettembre|[Oo]ttobre|[Nn]ovembre|[Dd]icembre)(\s))*[-/.]?[0-9]*[IVX]*[-/.]?[0-9][0-9][0-9]*[.]?' )" />
                 <xsl:otherwise>
                   <tei:lb/>
                   <xsl:text />
                   <xsl:call-template name="text" >
                     <xsl:with-param name="txt" select="."/>
                   </xsl:call-template>
                 </xsl:otherwise>
               </xsl:choose>
              </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
      </tei:p>
    </xsl:template>

    <xsl:template name="body-fronte" >
      <xsl:variable name="st" select="./text/fronte/text()"/>
      <tei:p type="fronte">
      <xsl:for-each select="tokenize($st,'\n')">
        <xsl:choose>
          <xsl:when test="matches( . , '^\s+$') or matches( . , '^$')" />
          <xsl:otherwise>
            <tei:lb/>
            <xsl:text />
            <xsl:call-template name="text" >
              <xsl:with-param name="txt" select="."/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
       </xsl:for-each>
      </tei:p>
    </xsl:template>

    <xsl:template name="address">
    <xsl:variable name="txt" select="text//salute/following-sibling::text()" />
    <xsl:variable name="txt2" select="text/retro/text()" />
    <xsl:if test="matches( $txt , '\n\n' ) or matches( $txt2 , '\n\n' )" >
      <tei:div type="address-destination">
        <tei:p>
          <tei:address>
              <tei:addrLine>
                  <xsl:variable name="newline" select="string('&#x0a;&#x0a;')" /> <!-- corrisponde a una riga vuota -->
                  <xsl:variable name ="addr" select="substring-after( $txt , $newline )" />
                  <xsl:variable name ="addr2" select="substring-after( $txt2 , $newline )" />
                  <xsl:for-each select="tokenize($addr,'\n')">
                    <xsl:choose>
                      <xsl:when test="matches( . , '^\s+$') or matches( . , '^$')" />
                      <xsl:otherwise>
                        <tei:lb/>
                        <xsl:text />
                        <xsl:call-template name="text" >
                          <xsl:with-param name="txt" select="."/>
                        </xsl:call-template>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:for-each>
                  <xsl:for-each select="tokenize($addr2,'\n')">
                    <xsl:choose>
                      <xsl:when test="matches( . , '^\s+$') or matches( . , '^$')" />
                      <xsl:otherwise>
                        <tei:lb/>
                        <xsl:text />
                        <xsl:call-template name="text" >
                          <xsl:with-param name="txt" select="."/>
                        </xsl:call-template>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:for-each>
              </tei:addrLine>
          </tei:address>
        </tei:p>
      </tei:div>
  </xsl:if>
  </xsl:template>

  <xsl:template match="text//salute">
    <tei:closer>
          <xsl:variable name="insert" select="string('t')" />
          <xsl:variable name="T" select="text()"/>
          <xsl:variable name="listName"><list><item><n>Giovannino</n></item><item><n>Pia</n></item><item><n>Jean</n></item>
          <item><n>Ginevra</n></item><item><n>Nino</n></item><item><n>Bruno</n></item><item><n>Oliva</n></item><item><n>E.</n><c>Barbagelata</c></item>
          <item><n>S.</n><c>Banchi</c></item><item><n>Mario</n></item><item><n>Maria</n></item><item><n>R</n><c>R</c></item><item><n>Luigia</n></item>
          <item><n>Giulio</n><c>Fantoni</c></item><item><c>Brunoli</c><n>Carla</n></item><item><n>Giuseppe</n><c>Magi</c><c>Morfede</c></item>
          <item><n>Ceresina</n><c>Gambi</c></item><item><c>Orina</c></item><item><c>Cricca</c></item><item><c>Buti</c></item>
          <item><c>Busolini</c><n>Massimo</n></item><item><n>Maria</n><c>Coliola</c></item><item><c>Benelli</c><n>Romeo</n></item>
          <item><n>Remigio</n><c>Dalla</c><c>Valle</c></item><item><c>Fabbri</c><n>A.</n></item></list></xsl:variable>
          <xsl:for-each select="tokenize($T,'\n')">
              <tei:lb />
              <xsl:for-each select="tokenize( normalize-space(.) ,' ')">
                <xsl:variable name="position" select="position()" />
                <xsl:variable name="word" select="." />
                <xsl:variable name="testReg">.* </xsl:variable>
                <xsl:if test=" ($word != ' ') or ($word != '') ">
                  <xsl:for-each select="$listName/list/item" >
                    <xsl:choose>
                        <xsl:when test=" current()/n = $word ">
                        <tei:signed>
                          <tei:persName>
                            <tei:forename ref="{current()/n}">
                              <xsl:value-of select="$word" />
                            </tei:forename>
                          </tei:persName>
                        </tei:signed>
                      </xsl:when>
                      <xsl:when test=" current()/c = $word ">
                      <tei:signed>
                        <tei:persName>
                          <tei:surname>
                            <xsl:value-of select="$word" />
                          </tei:surname>
                        </tei:persName>
                      </tei:signed>
                    </xsl:when>
                      <xsl:otherwise>
                         <xsl:if test="(position()=last()) and (not( $listName/list/item/n = $word or  $listName/list/item/c = $word )) ">
                           <xsl:call-template name="text" >
                             <xsl:with-param name="txt" select="$word"/>
                           </xsl:call-template><xsl:text> </xsl:text>
                          </xsl:if>
                      </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
		</tei:closer>
  </xsl:template>

  <xsl:template name="text">
    <xsl:param name="txt" />
    <xsl:choose>
      <xsl:when test="matches( $txt , '.*--+.*' )">
          <xsl:variable name="contestoSx" select="substring-before( $txt , '--' )" />
          <xsl:value-of select="$contestoSx" />
          <tei:gap reason="illegible" />
        <xsl:choose>
          <xsl:when test="$contestoSx != '' ">
          <xsl:variable name="replace1" select="replace( $txt , $contestoSx, '')" />
          <xsl:variable name="replace2" select="replace( $replace1 , '--+', '')" />
          <xsl:value-of select="$replace2" />
        </xsl:when>
        <xsl:otherwise>
            <xsl:variable name="replace" select="replace( $txt , '--+', '')" />
            <xsl:value-of select="$replace" />
        </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$txt" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  </xsl:stylesheet>
