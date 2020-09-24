$(document).ready(function(){

  // indice json ricerca
  var xobj = new XMLHttpRequest();
  xobj.overrideMimeType("application/json");
  xobj.open('GET','indiceJSON.json', false);
  xobj.send("");
  var idx = xobj.responseText;

  var xobj2 = new XMLHttpRequest();
  xobj.open('GET','indiceJSON2.json', false);
  xobj.send("");
  var idx2 = xobj.responseText;

  var xobj3 = new XMLHttpRequest();
  xobj.open('GET','indiceJSON3.json', false);
  xobj.send("");
  var idx3 = xobj.responseText;

//  var xobj2 = new XMLHttpRequest();
//  xobj.overrideMimeType("application/json");
//  xobj.open('GET','indiceJSON2.json', false);
//  xobj.send("");
//  var idx2 = xobj.responseText;


  //PROGRESSBAR
  $( function() {
    var progressbar = $( "#progressbar" ),
      progressLabel = $( ".progress-label" );

    progressbar.progressbar({
      value: false,
      change: function() {
        progressLabel.text( progressbar.progressbar( "value" ) + "%" );
      },
      complete: function() {
        progressLabel.text( "Complete!" );
        /* displayResult(); */
        $("#progressbar").css({"display": "none"});
      }
    });

    function progress() {
      var val = progressbar.progressbar( "value" ) || 0;

      progressbar.progressbar( "value", val + 2 );

      if ( val < 99 ) {
        setTimeout( progress, 50 );
      }
    }

    setTimeout( progress, 100 );
  } );

function loadXMLDoc(filename){
if (window.ActiveXObject)
  {
  xhttp = new ActiveXObject("Msxml2.XMLHTTP");
  }
else
  {
  xhttp = new XMLHttpRequest();
  }
  xhttp.open("GET", filename, false);
try {xhttp.responseType = "msxml-document"} catch(err) {} // Helping IE11
  xhttp.send("");
return xhttp.responseXML;
};


function displayResult(){
xml = loadXMLDoc("corpusTot.xml");
xsl = loadXMLDoc("xsl/visualizzazione.xsl");
xsl2 = loadXMLDoc("xsl/lecartoline.xsl");
xsl4 = loadXMLDoc("xsl/about.xsl");
// code for IE
if (window.ActiveXObject || xhttp.responseType == "msxml-document")
  {
  ex = xml.transformNode(xsl);
  ex2 = xml.transformNode(xsl2);
//  ex3 = xml.transformNode(xsl3);
  ex4 = xml.transformNode(xsl4);
  document.getElementById("home").innerHTML = ex;
  document.getElementById("cartoline").innerHTML = ex2;
//  document.getElementById("cerca").innerHTML = ex3;
  document.getElementById("about").innerHTML = ex4;
  }
// code for Chrome, Firefox, Opera, etc.
else if (document.implementation && document.implementation.createDocument)
  {
  xsltProcessor = new XSLTProcessor();
  xsltProcessor.importStylesheet(xsl);
  resultDocument = xsltProcessor.transformToFragment(xml, document);
  document.getElementById("home").appendChild(resultDocument);
  xsltProcessor.reset();
  xsltProcessor.importStylesheet(xsl2);
  resultDocument2 = xsltProcessor.transformToFragment(xml, document);
  document.getElementById("cartoline").appendChild(resultDocument2);
  xsltProcessor.reset();
//  xsltProcessor.importStylesheet(xsl3);
//  resultDocument3 = xsltProcessor.transformToFragment(xml, document);
//  document.getElementById("cerca").appendChild(resultDocument3);
//  xsltProcessor.reset();
  xsltProcessor.importStylesheet(xsl4);
  resultDocument4 = xsltProcessor.transformToFragment(xml, document);
  document.getElementById("about").appendChild(resultDocument4);
  }
};
displayResult();
console.log("DOM trasformato", resultDocument);

var flagM = 0;

$(".meta").each(
  function(i, elem){
    $(elem).click(function() {
      if(flagM == 0) {
        var xml = loadXMLDoc("corpusTot.xml");
        var xsl = loadXMLDoc("xsl/visualizzaMetadati.xsl");
        // code for IE
        if (window.ActiveXObject || xhttp.responseType == "msxml-document")
          {
          var ex = xml.transformNode(xsl);
          document.getElementById("infoCartolina").innerHTML = ex;
          }
        // code for Chrome, Firefox, Opera, etc.
        else if (document.implementation && document.implementation.createDocument)
          {
          var xsltProcessor = new XSLTProcessor();
          xsltProcessor.importStylesheet(xsl);
          xsltProcessor.clearParameters();
          xsltProcessor.setParameter('', 'id', elem.id);
          var resultDocument = xsltProcessor.transformToFragment(xml, document);
          let first = document.getElementById("infoCartolina").firstChild;
          $(first).replaceWith(resultDocument);
          xsltProcessor.reset();
          }
          $("img.open").click(function(){console.log("cliccato img",elem.id)});
          $("img.text").click(function(){console.log("cliccato text",elem.id)});
          $("img.link").click(function(){console.log("cliccato link",elem.id)});

        $("#home").css({"display": "none"});
        $("#cartoline").css({"display": "none"});
        $("#cerca").css({"display": "none"});
        $("#about").css({"display": "none"});
        $("#infoCartolina").css({"display": "block"});
        $("#infoTesto").css({"display": "none"});
        $("#infoLink").css({"display": "none"});
         flagM = 1;
         flagH = 0;
         flagC = 0;
         flagF = 0;
         flagA = 0;
         flagT = 0;
    }
    })
  });

  var c = 0;

  $(".imgCerca").each(
    function(i, elem){
      $(elem).click(function() {
        if(c == 0) {
          var xml = loadXMLDoc("corpusTot.xml");
          var xsl = loadXMLDoc("xsl/visualizzaMetadati.xsl");
          // code for IE
          if (window.ActiveXObject || xhttp.responseType == "msxml-document")
            {
            var ex = xml.transformNode(xsl);
            document.getElementById("content-cercaa").innerHTML = ex;
            }
          // code for Chrome, Firefox, Opera, etc.
          else if (document.implementation && document.implementation.createDocument)
            {
            var xsltProcessor = new XSLTProcessor();
            xsltProcessor.importStylesheet(xsl);
            xsltProcessor.clearParameters();
            xsltProcessor.setParameter('', 'id', elem.id);
            var resultDocument = xsltProcessor.transformToFragment(xml, document);
            let first = document.getElementById("content-cerca").firstChild;
            $(first).replaceWith(resultDocument);
            xsltProcessor.reset();
            }
          $("#home").css({"display": "none"});
          $("#cartoline").css({"display": "none"});
          $("#cerca").css({"display": "none"});
          $("#about").css({"display": "none"});
          $("#infoCartolina").css({"display": "none"});
          $("#infoTesto").css({"display": "none"});
          $("#infoLink").css({"display": "none"});
          $("#content-cerca").css({"display": "block"});
           flagM = 0;
           flagH = 0;
           flagC = 0;
           flagF = 0;
           flagA = 0;
           flagT = 0;
           c = 1
      }
      })
    });


var flagT = 0;

$(".text").each(
  function(i, elem){
    $(elem).click(function() {
      if(flagT == 0) {
    xml = loadXMLDoc("corpusTot.xml");
    xsl = loadXMLDoc("xsl/visualizzaTesto.xsl");
    // code for IE
    if (window.ActiveXObject || xhttp.responseType == "msxml-document")
      {
      var ex = xml.transformNode(xsl);
      document.getElementById("infoTesto").innerHTML = ex;
      }
    // code for Chrome, Firefox, Opera, etc.
    else if (document.implementation && document.implementation.createDocument)
      {
      var xsltProcessor = new XSLTProcessor();
      xsltProcessor.importStylesheet(xsl);
      xsltProcessor.clearParameters();
      xsltProcessor.setParameter('', 'id', elem.id);
      var resultDocument = xsltProcessor.transformToFragment(xml, document);
      let first = document.getElementById("infoTesto").firstChild;
      $(first).replaceWith(resultDocument);
      xsltProcessor.reset();
      }
    $("#home").css({"display": "none"});
    $("#cartoline").css({"display": "none"});
    $("#cerca").css({"display": "none"});
    $("#about").css({"display": "none"});
    $("#infoCartolina").css({"display": "none"});
    $("#infoTesto").css({"display": "block"});
    $("#infoLink").css({"display": "none"});
    flagM = 0;
    flagH = 0;
    flagC = 0;
    flagF = 0;
    flagA = 0;
    flagT = 1;
    flagL = 0;
  }
})
});

$(".text1").each(
  function(i, elem){
    $(elem).click(function() {
      if(flagT == 0) {
    xml = loadXMLDoc("corpusTot.xml");
    xsl = loadXMLDoc("xsl/visualizzaTesto.xsl");
    // code for IE
    if (window.ActiveXObject || xhttp.responseType == "msxml-document")
      {
      var ex = xml.transformNode(xsl);
      document.getElementById("infoCartolina").innerHTML = ex;
      }
    // code for Chrome, Firefox, Opera, etc.
    else if (document.implementation && document.implementation.createDocument)
      {
      var xsltProcessor = new XSLTProcessor();
      xsltProcessor.importStylesheet(xsl);

      var resultDocument = xsltProcessor.transformToFragment(xml, document);
      let first = document.getElementById("infoCartolina").firstChild;
      $(first).replaceWith(resultDocument);
      xsltProcessor.reset();
      }
    $("#home").css({"display": "none"});
    $("#cartoline").css({"display": "none"});
    $("#cerca").css({"display": "none"});
    $("#about").css({"display": "none"});
    $("#infoCartolina").css({"display": "block"});
    $("#infoTesto").css({"display": "none"});
    $("#infoLink").css({"display": "none"});
    flagM = 0;
    flagH = 0;
    flagC = 0;
    flagF = 0;
    flagA = 0;
    flagT = 1;
    flagL = 0;
  }
})
});



var flagL = 0;

$(".link").each(
  function(i, elem){
    $(elem).click(function() {
      if(flagL == 0) {
    xml = loadXMLDoc("corpusTot.xml");
    xsl = loadXMLDoc("xsl/visualizzaCartolina.xsl");
    // code for IE
    if (window.ActiveXObject || xhttp.responseType == "msxml-document")
      {
      var ex = xml.transformNode(xsl);
      document.getElementById("infoLink").innerHTML = ex;
      }
    // code for Chrome, Firefox, Opera, etc.
    else if (document.implementation && document.implementation.createDocument)
      {
      var xsltProcessor = new XSLTProcessor();
      xsltProcessor.importStylesheet(xsl);
      xsltProcessor.clearParameters();
      xsltProcessor.setParameter('', 'id', elem.id);
      var resultDocument = xsltProcessor.transformToFragment(xml, document);
      let first = document.getElementById("infoLink").firstChild;
      $(first).replaceWith(resultDocument);
      xsltProcessor.reset();
    }
    $("#home").css({"display": "none"});
    $("#cartoline").css({"display": "none"});
    $("#cerca").css({"display": "none"});
    $("#about").css({"display": "none"});
    $("#infoCartolina").css({"display": "none"});
    $("#infoTesto").css({"display": "none"});
    $("#infoLink").css({"display": "block"});
    flagM = 0;
    flagH = 0;
    flagC = 0;
    flagF = 0;
    flagA = 0;
    flagT = 0;
    flagL = 1;
  }
})
});

//DIALOG immagini
$(".open").each(
  function(i, elem){
    $(elem).click( function() {
      console.log("visualizzazione img");
    var xml = loadXMLDoc("corpusTot.xml");
    var xsl = loadXMLDoc("xsl/visualizzaImg.xsl");
    // code for IE
    if (window.ActiveXObject || xhttp.responseType == "msxml-document")
      {
      var ex = xml.transformNode(xsl);
      document.getElementById("dialog").innerHTML = ex;
      }
    // code for Chrome, Firefox, Opera, etc.
    else if (document.implementation && document.implementation.createDocument)
      {
      var xsltProcessor = new XSLTProcessor();
      xsltProcessor.importStylesheet(xsl);
      xsltProcessor.clearParameters();
      xsltProcessor.setParameter('', 'id', elem.id);
      console.log("param", xsltProcessor.getParameter("", "id"));
      var tmpElem = document.createElement("div");
      var resultDocument = xsltProcessor.transformToFragment(xml, document);
      var first = document.getElementById("dialog").firstChild;
      $(first).replaceWith(resultDocument);
      xsltProcessor.reset();
      //var h=window.innerHeight;
      //var h=document.documentElement.clientHeight;
      //var h=screen.width*0.4;
      var hBar=$(bar).height();
      var h=($(window).height())-hBar;
      $("#home").css({"height": h});
      $("#home").css({"overflow":"hidden"}); 
      console.log("altezza window", h);
      $( "#dialog" ).dialog( "open" );
    }
})
});


$(function() {
  var hBar=$(bar).height();
  var v=$(window).width()*0.5;
  var h=$(window).height()-hBar;
  console.log("dialog open", this);
  $( "#dialog" ).dialog({
    modal: true,
    width: v,
    height: h,
    autoOpen: false,
    show: {
      effect: "blind",
      duration: 500,
    },
    hide: {
      effect: "explode",
      duration: 500
    },
    open: function(event, ui){
      console.log("open function event", event);
      console.log("open function ui", ui);
      console.log("open function", this);
      
      //var h = (CONDIZIONE img.v > img.h) ? "auto" : $(window).height()-hBar;
      var h="auto";
      $(this).height(h);
    },
    close: function(){
      var idCartolina=$(this).find("img").attr("id");
      console.log("id cartolina", idCartolina);
      $("#home").css({"height":"auto"});
      $("#home").css({"overflow":"visible"});
      $("html, body").animate(
        {
          scrollTop: ($("#".concat(idCartolina)).offset().top) - hBar - 15
        }, 1000
      );
    }
  });
}); 


//CLICK SUL MENU
    var flagH = 0;
    var flagC = 0;
    var flagF = 0;
    var flagA = 0;

    $("#h").click(function() {
      if(flagH == 0) {
        $("#home").css({"display": "block"});
        $("#cartoline").css({"display": "none"});
        $("#cerca").css({"display": "none"});
        $("#about").css({"display": "none"});
        $("#infoCartolina").css({"display": "none"});
        $("#infoTesto").css({"display": "none"});
        $("#infoLink").css({"display": "none"});
        flagH = 1;
        flagC = 0;
        flagF = 0;
        flagA = 0;
        flagM = 0;
        flagT = 0;
        flagL = 0;
      }
    });

    $("#c").click(function() {
      if(flagC == 0) {
        $("#home").css({"display": "none"});
        $("#cartoline").css({"display": "block"});
        $("#cerca").css({"display": "none"});
        $("#about").css({"display": "none"});
        $("#infoCartolina").css({"display": "none"});
        $("#infoTesto").css({"display": "none"});
        $("#infoLink").css({"display": "none"});
        flagH = 0;
        flagC = 1;
        flagF = 0;
        flagA = 0;
        flagM = 0;
        flagT = 0;
        flagL = 0;
      }
    });

    $("#f").click(function() {
      if(flagF == 0) {
        $("#home").css({"display": "none"});
        $("#cartoline").css({"display": "none"});
        $("#cerca").css({"display": "block"});
        $("#about").css({"display": "none"});
        $("#infoCartolina").css({"display": "none"});
        $("#infoTesto").css({"display": "none"});
        $("#infoLink").css({"display": "none"});
        flagH = 0;
        flagC = 0;
        flagF = 1;
        flagA = 0;
        flagM = 0;
        flagT = 0;
        flagL = 0;
      }
    });

   $("#a").click(function() {
      if(flagA == 0) {
        $("#home").css({"display": "none"});
        $("#cartoline").css({"display": "none"});
        $("#cerca").css({"display": "none"});
        $("#about").css({"display": "block"});
        $("#infoCartolina").css({"display": "none"});
        $("#infoTesto").css({"display": "none"});
        $("#infoLink").css({"display": "none"});
        flagH = 0;
        flagC = 0;
        flagF = 0;
        flagA = 1;
        flagM = 0;
        flagT = 0;
        flagL = 0;
      }
    });

//RICERCA
    $('#titolo').click( function() {
      console.log("CLICK TITLE", idx);
      var indice = JSON.parse(idx);
      console.log("STRINGA TITLE IDX", indice);


      $("#project").autocomplete({
        minLength: 0,
        source: indice,
        focus: function( event, ui ) {
          console.log("onfocus", ui)
          $( "#project" ).val( ui.item.value);
          return false;
        },
        select: function( event, ui ) {
          $( "#project" ).val( ui.item.value );
          $( "#project-id" ).val( ui.item.id );
          $( "#project-description" ).html( ui.item.descrizione );

          return false;
        }
      })
      .autocomplete( "instance" )._renderItem = function( ul, item ) {
        return $( "<li>" )
          .append( "<div>" + item.value + "<br>" + item.id + "</div>" )
          .appendTo( ul );
      };
    } );


    $('#lemma').click( function() {
      console.log("CLICK LEMMA", idx2);
      var indice2 = JSON.parse(idx2);
      console.log("TESTO LEMMA", indice2);

      $("#project").autocomplete({
        minLength: 0,
        source: indice2,
        focus: function( event, ui ) {
          console.log("onfocus", ui)
          $( "#project" ).val( ui.item.value);
          return false;
        },
        select: function( event, ui ) {
          $( "#project" ).val( ui.item.value );
          $( "#project-id" ).val( ui.item.id );
          $( "#project-description" ).html( ui.item.descrizione );

          return false;
        }
      })
      .autocomplete( "instance" )._renderItem = function( ul, item ) {
        return $( "<li>" )
          .append( "<div>" + item.value + "<br>" + item.id + "</div>" )
          .appendTo( ul );
      };
    } );


    $('#mittente').click( function() {
      var indice3 = JSON.parse(idx3);

      $("#project").autocomplete({
        minLength: 0,
        source: indice3,
        focus: function( event, ui ) {
          console.log("onfocus", ui)
          $( "#project" ).val( ui.item.value);
          return false;
        },
        select: function( event, ui ) {
          $( "#project" ).val( ui.item.value );
          $( "#project-id" ).val( ui.item.id );
          $( "#project-description" ).html( ui.item.descrizione );

          return false;
        }
      })
      .autocomplete( "instance" )._renderItem = function( ul, item ) {
        return $( "<li>" )
          .append( "<div>" + item.value + "<br>" + item.id + "</div>" )
          .appendTo( ul );
      };
    } );


//ON CLICK per SCROLLING MORBIDO
    $("a").on('click', function(event) {
        if (this.hash !== "") {
           event.preventDefault();
           var hash = this.hash;
          $('html, body').animate({
             scrollTop: $(hash).offset().top
          }, 1000, function(){
            window.location.hash = hash;
          });
        }
    });


      //INIZIO ANIMAZIONE MENU
      $("#ImgMenu").mouseover(function () {
        $(this).attr('src', $(this).data("hover"));
      }).mouseout(function () {
        $(this).attr('src', $(this).data("src"));
      });
  
       $("#ImgMenuMedia").mouseover(function () {
        $(this).attr('src', $(this).data("hover"));
      }).mouseout(function () {
        $(this).attr('src', $(this).data("src"));
      });
  
  
  //INIZIO ANIMAZIONE MENU COMPARSA con variabili di controllo
  var flagIMG = 0;
  
  $("#ImgMenuMedia").click(function() {
    if(flagIMG == 0) {
      $("#menuDiscesa").css({"display": "block"});
      flagIMG = 1;
    }
    else {
      $("#menuDiscesa").css({"display": "none"});
      flagIMG = 0;
    }
  });
  
  $("#menuDiscesa").click(function() {
    $("#menuDiscesa").css({"display": "none"});
    flagIMG = 0;
  });


}); // FINE READY
