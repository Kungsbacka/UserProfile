<%@ Register TagPrefix="mc" Namespace="ModernControls" %>
<%@ Page Title="Byt bild" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProfileImage.aspx.cs" Inherits="UserProfile.ProfileImage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        jQuery(function ($) {

            $('#MainContent_fileUpload').change(function () {
                <%=ClientScript.GetPostBackEventReference(fileUpload, "", true) %>            
            });

            var boundx, boundy;

            $('#MainContent_profileImage').Jcrop({
                boxWidth: 765,
                minSize: [96, 96],
                aspectRatio: 1,
                onSelect: saveAndPreview,
                onRelease: showWholeImageInPreview
            }, function () {
                var bounds = this.getBounds();
                boundx = bounds[0];
                boundy = bounds[1];
                showWholeImageInPreview();
            });

            function showWholeImageInPreview() {
                var w, h;
                if (boundx > boundy) {
                    w = 96;
                    h = 96 * boundy / boundx;
                }
                else {
                    w = 96 * boundx / boundy;
                    h = 96;
                }
                $('#MainContent_previewImage').css({
                    width: w + 'px',
                    height: h + 'px',
                    marginLeft: '0px',
                    marginTop: '0px'
                });
            }

            function saveAndPreview(c) {
                //save coordinates
                $('#MainContent_cropCoordinates').val('(' + Math.round(c.x) + ',' + Math.round(c.y) + ',' + Math.round(c.x2) + ',' + Math.round(c.y2) + ')');

                //show preview
                var rx = 96 / c.w;
                var ry = 96 / c.h;

                $('#MainContent_previewImage').css({
                    width: Math.round(rx * boundx) + 'px',
                    height: Math.round(ry * boundy) + 'px',
                    marginLeft: '-' + Math.round(rx * c.x) + 'px',
                    marginTop: '-' + Math.round(ry * c.y) + 'px'
                });
            }

        });
    </script>
    <a href="Help.aspx">Hjälp</a>
    <div class="panel panel-default">
        <div class="panel-heading" style="padding-top: 0;">
            <asp:HiddenField ID="cropCoordinates" runat="server" />
            <div class="container">
                <div class="row">
                    <table>
                        <tr>
                            <td style="width:130px;vertical-align:top;"><h3>Välj en bild:</h3></td>
                            <td style="width:275px;vertical-align:top;padding-top:18px;"><asp:FileUpload ID="fileUpload" runat="server" CssClass="btn btn-sm btn-primary" /></td>
                            <td style="width:90px;vertical-align:top;padding-top:18px;"><asp:Button ID="saveButton" runat="server" CssClass="btn btn-sm btn-primary" OnClick="saveButton_Click" Text="Spara" /></td>
                            <td style="width:130px;vertical-align:top;padding-top:18px;"><asp:Button ID="cancelButton" runat="server" CssClass="btn btn-sm btn-primary" OnClick="cancelButton_Click" Text="Avbryt" /></td>
                            <td style="width:100px;"><div id="preview-pane"><div class="preview-container"><asp:Image ID="previewImage" runat="server" CssClass="jcrop-preview dentered" /><span class="centerer"></span></div></div></td>
                         </tr>
                        <tr>
                            <td colspan="4" style="vertical-align:top;">
                                Bilden:
                                <ul>
                                    <li>ska vara en <b>porträttbild</b> av användaren,</li>
                                    <li>kommer att synas både i <b>Lync</b> och <b>Outlook</b> (observera att det kan dröja en stund innan bilden ändras),</li>
                                    <li>kan <b>beskäras</b> innan du sparar genom att <b>klicka i bilden och dra</b> med musknappen nedtryckt (<a href="Help.aspx#heading-crop">instruktioner</a>).</li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4"><asp:Label ID="statusLabel" runat="server" Text="&nbsp;"></asp:Label></td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <button id="rotateButton" runat="server" class="btn btn-sm btn-secondary" onserverclick="rotateButton_Click">
                                    <span class="glyphicon glyphicon-repeat" aria-hidden="true"></span>&nbsp;&nbsp;Rotera
                                </button>                                      
                                <button id="flipHorizontalButton" runat="server" class="btn btn-sm btn-secondary" onserverclick="flipHorizontalButton_Click">
                                    <span class="glyphicon glyphicon-resize-horizontal" aria-hidden="true"></span>&nbsp;&nbsp;Vänd horisontellt
                                </button>                                      
                                <button id="flipVerticalButton" runat="server" class="btn btn-sm btn-secondary" onserverclick="flipVerticalButton_Click">
                                    <span class="glyphicon glyphicon-resize-vertical" aria-hidden="true"></span>&nbsp;&nbsp;Vänd vertikalt
                                </button>                                      
                            </td>
                        </tr>
                    </table>
                </div>
            </div>            
        </div>
        <div class="panel-body" style="min-height: 600px;">
            <asp:Image ID="profileImage" runat="server" />
        </div>
        <div class="panel-footer">&nbsp;</div>
    </div>
    
</asp:Content>