<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="PSCPortal.Portlets.Media.Test1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="mediaelement-and-player.min.js"></script>
    <link href="mediaelementplayer.css" rel="stylesheet" />
    <script>
        $(document).ready(function () {
            var pscjq = jQuery.noConflict();
            alert('OK');
            pscjq('video,audio').mediaelementplayer();
        });


        function pageLoad() {
           
        }
    </script>
</head>
<body>
    <a>dd</a>
    <video controls="controls">
        <source src="http://www.sggp.org.vn/flash/2016/03/flash12208_costa.flv" type="video/flv" />

    </video>


    <video  controls="controls" >
        <!-- MP4 for Safari, IE9, iPhone, iPad, Android, and Windows Phone 7 -->
        <source type="video/flv" src="http://www.sggp.org.vn/flash/2016/03/flash12208_costa.flv"  />
        <!-- WebM/VP8 for Firefox4, Opera, and Chrome -->
    

    </video>
</body>
</html>
