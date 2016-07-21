﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Edit.ascx.cs" Inherits="PSCPortal.Portlets.HTMLBlog.Edit" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadEditor ID="redHTMLBlog" runat="server" AllowScripts="True">
    <ImageManager DeletePaths="~/Resources/Images" ViewPaths="~/Resources/Images" UploadPaths="~/Resources/Images" MaxUploadFileSize="52428800" SearchPatterns="*.gif,*.png,*.jpg,*.jpeg" />
    <MediaManager DeletePaths="~/Resources/Medias" ViewPaths="~/Resources/Medias" UploadPaths="~/Resources/Medias" MaxUploadFileSize="52428800" SearchPatterns="*.flv,*.mp4,*.mkv,*.mp3,*.avi" />
    <FlashManager DeletePaths="~/Resources/Flashs" ViewPaths="~/Resources/Flashs" UploadPaths="~/Resources/Flashs" MaxUploadFileSize="52428800" SearchPatterns="*.swf" />
    <DocumentManager DeletePaths="~/Resources/Docs" ViewPaths="~/Resources/Docs" UploadPaths="~/Resources/Docs" MaxUploadFileSize="52428800" SearchPatterns="*.ppt,*.rar,*.zip,*.doc, *.txt, *.docx, *.xls, *.xlsx, *.pdf" />
    <Content>
    </Content>
</telerik:RadEditor>
<asp:LinkButton ID="lbtAccept" runat="server" OnClick="lbtAccept_Click">[Accept]</asp:LinkButton>
<asp:LinkButton ID="lbtCancel" runat="server" OnClick="lbtCancel_Click">[Cancel]</asp:LinkButton>

