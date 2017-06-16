<%@ Page Title="Hjälp" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Help.aspx.cs" Inherits="UserProfile.Help" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <a href="javascript:history.back()">Tillbaka</a>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h1>Hjälp</h1>
        </div>
        <div class="panel-body">
            <ul>
                <li>
                    <a href="#faq">Vanliga frågor</a>
                    <ul>
                        <li><a href="#faq-1">Hur lång tid tar det innan bilden visas i Skype och Outlook?</a></li>
                        <li><a href="#faq-2">Vem kan se min bild?</a></li>
                        <li><a href="#faq-3">Hur startar jag om Skype?</a></li>
                        <li><a href="#faq-4">Hur tar jag bort min bild?</a></li>
                        <li><a href="#faq-5">Varför kan jag inte ändra bild från en iPad eller iPhone?</a></li>
                        <li><a href="#faq-6">Var kommer personuppgifterna ifrån?</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#heading-crop">Beskärning av bilden</a>
                    <ul>
                        <li><a href="#heading-crop-preview">Förhandsgranskning</a></li>
                        <li><a href="#heading-crop-mark">Markera ett område</a></li>
                        <li><a href="#heading-crop-resize">Ändra markeringens storlek</a></li>
                        <li><a href="#heading-crop-move">Flytta markering</a></li>
                        <li><a href="#heading-crop-deselect">Ångra markering</a></li>
                        <li><a href="#heading-rotate-flip">Rotera och vänd</a></li>
                    </ul>
                </li>
            </ul>
            <hr />
            <div class="extra-margin-bottom">
                <h2 id="faq">Vanliga frågor</h2>
                <h4 id="faq-1" class="extra-margin-top">Hur lång tid tar det innan bilden visas i Skype och Outlook?</h4>
                <p>
                    Det kan ta så lång tid som upp till ett dygn innan bilden syns i både Skype och Outlook. Det brukar ta längst tid för 
                    bilden att dyka upp i Skype.<br />
                    Om du lägger in en bild för första gången brukar den synas i Skype efter en omstart av programmet.
                </p>
                <h4 id="faq-2" class="extra-margin-top">Vem kan se min bild?</h4>
                <p>
                    Bilden är synlig för alla inom Kungsbacka kommun som har Skype, Outlook eller webmail. Bilden kan i vissa fall även synas för utomstående om ni har en Skype-konversation.
                    Om du endast skickar e-post till en mottagare utanför kommunen kommer bilden inte att synas. <br />
                    Om du vill vara helt säker på att din bild inte syns utanför Kungsbacka kommun rekommenderar vi att du avstår från att lägga in en bild.
                </p>
                <h4 id="faq-3" class="extra-margin-top">Hur startar jag om Skype?</h4>
                <p>
                    För att starta om Skype klickar du på pilen till höger om kugghjulet och väljer Arkiv&nbsp;&#8594;&nbsp;Avsluta. Sedan startar du Skype igen.
                </p>
                <img alt="Skype" src="Content/lync1.png" />
                <h4 id="faq-4" class="extra-margin-top">Hur tar jag bort min bild?</h4>
                <p>
                    Du kan inte själv ta bort din bild utan bara byta ut den mot en annan. Om du vill ta bort din bild helt kan du göra det i
                    <a href="https://webmail.kungsbacka.se/">webmailen</a> eller genom att anmäla det till
                    <a href="https://nilex.kungsbacka.se/NilexSelfService/?I=4&G=13">Service Direkt</a>.
                </p>
                <h4 id="faq-5" class="extra-margin-top">Varför kan jag inte ändra bild från en iPad eller iPhone?</h4>
                <p>
                    Anledningen till att det inte går att ändra bild från en iPad eller iPhone beror på hur dessa enheter hanterar automatisk inloggning i en Windows-miljö.
                </p>
                <h4 id="faq-6" class="extra-margin-top">Var kommer personuppgifterna ifrån?</h4>
                <p>
                    Uppgifterna hämtas från vår användardatabas (Active Directory) som i sin tur får uppgifter från personal- och telefonisystemet.
                    Samma uppgifter syns även i adressboken i Outlook och i webmailen.
                    <br />
                    Om uppgifterna inte stämmer kontakta din chef som gör en ändringsanmälan och skickar den till
                    <a href="https://nilex.kungsbacka.se/NilexSelfService/?I=4&G=13">Service Direkt</a>.
                </p>
            </div>
            <div class="extra-margin-bottom">
                <h2 id="heading-crop">Beskärning av bilden</h2>
                <p>
                    Eftersom bilden i Skype och Outlook är liten (96 x 96 bildpunkter) så är det bra om bilden beskärs så att ansiktet upptar större delen av bilden.
                    Beskärningen görs genom att markera ett område i bilden med hjälp av musen. Det markerade området kommer att bli
                    den bild som sparas och visas i Skype och Outlook.
                </p>
            </div>
            <div class="extra-margin-bottom">
                <h4 id="heading-crop-preview">Förhandsgranskning</h4>
                <p>
                    Bilden uppe till höger är en förhandsgranskning av bilden som kommer att sparas. Förhandsgranskningen gör det lättare
                    att avgöra hur den beskurna bilden kommer att se ut. Eftersom det är en förhandsgranskning är bildkvalitén inte lika bra
                    som för den slutliga bilden.
                </p>
            </div>
            <div class="extra-margin-bottom">
                <h4 id="heading-crop-mark">Markera ett område</h4>
                <p>
                    Markera ett område i bilden genom att hålla nere vänster musknapp och dra korset över bilden.
                </p>
                <img alt="En första markering" src="Content/silhouette1.png" />
            </div>
            <div class="extra-margin-bottom">
                <h4 id="heading-crop-resize">Ändra markeringens storlek</h4>
                <p>
                    Genom att ta tag i en kant eller ett hörn och dra kan du ändra markeringens storlek. <br />
                    Markeringen kommer alltid att behålla en kvadratisk form oavsett hur du drar.
                </p>
                <img alt="Ändra markeringens storlek" src="Content/silhouette2.png" />
            </div>
            <div class="extra-margin-bottom">
                <h4 id="heading-crop-move">Flytta markering</h4>
                <p>
                    Du kan flytta markeringen genom att klicka i den och hålla nere musknappen samtidigt som du drar.
                </p>
                <img alt="Flytta markering" src="Content/silhouette3.png" />
            </div>
            <div class="extra-margin-bottom">
                <h4 id="heading-crop-deselect">Ångra markering</h4>
                <p>
                    Om du vill ångra din markering klickar du någonstans i bilden, men utanför markeringen.
                </p>
            </div>
            <div>
                <h4 id="heading-rotate-flip">Rotera och vänd</h4>
                <p>
                    Du kan rotera bilden 90 grader medsols och vända på bilden både horisontellt och vertikalt genom att använda knapparna ovanför bilden.
                </p>
                <img alt="Knappar för att rotera och vända" src="Content/rotate_flip.png" />
            </div>
        </div>
        <div class="panel-footer">
        </div>
    </div>
</asp:Content>