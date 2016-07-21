﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SubDomainDisplay.ascx.cs" Inherits="PSCPortal.Modules.SubDomainDisplay" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link href="/Lightbox/resource/lightbox.css" rel="stylesheet" type="text/css" />
<script src="/Lightbox/resource/lightbox_plus_min.js" type="text/javascript"></script>
<style type="text/css">
    .paging {
        font-family: Verdana;
        font-size: 11px;
        cursor: pointer;
        color: #3f4041;
        text-decoration: none;
    }

        .paging:hover {
            text-decoration: none;
            font-family: Verdana;
            font-size: 11px;
            cursor: pointer;
            color: #fd9b00;
        }
</style>
<div style="width: 937px;padding-left:47px;">
    <div class="title_topic_show" style="padding-top: 10px;">
        <div class="text_title_show">
            <img src="/Resources/ImagePhoto/icon_title.png" /><asp:HyperLink ID="hplArrivalTypeName"
                CssClass="hplClass" runat="server" Font-Underline="false"></asp:HyperLink>
        </div>
        <div class="line_topic_show">
            <img src="/Resources/ImagePhoto/arrow_title.png" />
        </div>
    </div>
    <asp:Panel ID="pnDisplayAlbum" runat="server">
        <div class="content_show" id="Conten" runat="server" style="width: 937px">
            <div class="imgl_album">
                <img src="/Resources/ImagePhoto/top_showimg.jpg" width="937" />
            </div>
            <div class="row_show" style="padding-left: 50px">
                <asp:DataList ID="Pictype" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                    Width="560px" CellPadding="0" CellSpacing="0">
                    <ItemTemplate>
                        <div class="td_album">
                            <div class="hinhalbum">
                                <img style="cursor: pointer" src="<%#Eval("PathImgFirst") %>"
                                    alt="" onclick="chuyentrang('<%#Eval("Path") %>')" />
                            </div>
                        </div>
                        <div class="title_album">
                            <a href="#" onclick="chuyentrang('<%#Eval("Path") %>')">
                                <%#Eval("Name") %>
                                - <span style="color: Black; font-weight: normal;">[
                                    <%#Eval("NumberOfImages") %>
                                    ảnh]</span> </a><span></span>
                        </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
            <div class="imgl_album">
                <img src="/Resources/ImagePhoto/bottom_img.jpg" width="937" />
            </div>
        </div>
        <div class="part_trang ">
            <div class="trang">
                <asp:Panel ID="pnAlbum" runat="server">
                </asp:Panel>
            </div>
        </div>
    </asp:Panel>

    <div class="row_show">
        <asp:DataList ID="Pic" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
            Width="585px" CellPadding="0" CellSpacing="0" CaptionAlign="Bottom">
            <ItemTemplate>
                <div class="td_sp">
                    <div class="hinhsp">
                        <a href="<%#Eval("Path") %>" rel="lightbox1" class="effectable">
                            <img style="cursor: pointer" src="<%#Eval("Path")%>" />
                        </a>
                    </div>
                    <div class="title_sp">
                        <%--<a href="#"><%#Eval("Name")%></a>--%>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
    </div>
    <div class="part_trang ">
        <div class="trang">
            <asp:Panel ID="pnPager" runat="server">
            </asp:Panel>
        </div>
    </div>
</div>
<script language="javascript" type="text/javascript">
    function chuyentrang(Path) {
        window.location.href = "?ModuleId=<%#ConfigurationManager.AppSettings["ModuleAlbum"]%>&Path=" + Path; //  +"&Link=" + $(".hplClass").text();
    }
</script>