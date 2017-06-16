<%@ Page Title="Din profil" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UserProfile._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <span><a href="Help.aspx">Hjälp</a></span>
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="row">
                <div class="col-md-6">
                    <h1><%=this.UserDisplayName %></h1>
                    <h3><%=this.UserTitle %></h3>
                </div>
                <div class="col-md-6">
                <% if (this.IsMobileDevice()) { %>
                    <div class="pull-right">
                <% } else { %>
                    <div class="pull-right">
                <% } %>
                        <div class="text-center">
                            <asp:Image ID="profileImage" runat="server" CssClass="img img-user" />
                            <br />
                            <% if (this.IsMobileDevice()) { %>
                                <small>Det går inte att byta bild från en mobil enhet.</small>
                            <% } else { %>
                                <asp:HyperLink ID="updateImageLink" runat="server" CssClass="btn btn-sm btn-primary" NavigateUrl="~/ProfileImage.aspx"><span class="glyphicon glyphicon-user"></span> Byt bild</asp:HyperLink>
                            <% } %>
                         </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-6">
                    <ul class="list-group">
                        <li class="list-group-item">Förnamn: <b><%=this.UserGivenName %></b></li>
                        <li class="list-group-item">Efternamn: <b><%=this.UserSurname %></b></li>
                        <li class="list-group-item">E-postadress: <b><%=this.UserMail %></b></li>
                        <li class="list-group-item">Telefonnummer: <b><%=this.UserPhone %></b></li>
                    </ul>
                </div>
                <div class="col-md-6">
                    <ul class="list-group">
                        <li class="list-group-item">Befattning: <b><%=this.UserTitle %></b></li>
                        <li class="list-group-item">Förvaltning: <b><%=this.UserDepartment %></b></li>
                        <li class="list-group-item">Enhet: <b><%=this.UserOffice %></b></li>
                        <li class="list-group-item">Chef: <b><%=this.UserManager %></b></li>
                    </ul>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            E-postsignatur
                        </div>
                        <div class="panel-body">
                            Hälsningar<br />
                            <%=this.UserDisplayName %><br />
                            <%=this.UserTitle %><br />
                            ______________________<br />
                            Kungsbacka kommun<br />
                            <%=this.UserDepartment %><br />
                            <%=this.UserPhoneFormatted %><br />
                            <%=this.UserMail %><br />
                            www.kungsbacka.se<br />
                            www.facebook.com/kungsbackakommun<br />
                            Värna om miljön! Behöver du skriva ut det här meddelandet?<br />
                        </div>
                        <div class="panel-footer">
                            <em>Kopiera texten och använd den i Outlook eller i mobilen.</em>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
        </div>
    </div>
</asp:Content>


