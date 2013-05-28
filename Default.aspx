<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="https://www.facebook.com/2008/fbml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="fb-root">
    </div>
    <%--<div class="fb-login-button" data-show-faces="true" data-width="400" data-max-rows="1">--%>

    <a href="#" onclick="fbLogin();return false;">Start Here! </a>

        

    </div>
    <script>
        function fbLogin() {
            FB.login(function (response) {
                if (response.session) {
                    //user is logged in, reload page
                    window.location.reload(true);
                } else {
                    // user is not logged in
                }
            }, { perms: 'email,read_friendlists,friends_about_me,friends_location,friends_photos,manage_pages,publish_stream' });
        }

        window.fbAsyncInit = function () {
            FB.init({
                appId: '570657702955289', // App ID
                status: true, // check login status
                cookie: true, // enable cookies to allow the server to access the session
                xfbml: true,  // parse XFBML
                oauth: true
                        });

           

            // Additional initialization code here
            FB.Event.subscribe('auth.authResponseChange', function (response) {
                if (response.status === 'connected') {
                    // the user is logged in and has authenticated your
                    // app, and response.authResponse supplies
                    // the user's ID, a valid access token, a signed
                    // request, and the time the access token 
                    // and signed request each expire
                    var uid = response.authResponse.userID;
                    var accessToken = response.authResponse.accessToken;

                    // TODO: Handle the access token
                    var form = document.createElement("form");
                    form.setAttribute("method", 'post');
                    form.setAttribute("action", 'FacebookLogin.ashx');

                    var field = document.createElement("input");
                    field.setAttribute("type", "hidden");
                    field.setAttribute("name", 'accessToken');
                    field.setAttribute("value", accessToken);
                    form.appendChild(field);

                    document.body.appendChild(form);
                    form.submit();


                } else if (response.status === 'not_authorized') {
                    // the user is logged in to Facebook, 
                    // but has not authenticated your app
                } else {
                    // the user isn't logged in to Facebook.
                }
            });
        };

        function PostToFeedDialog() {
            // calling the API ...
            var obj = {
                method: 'feed',
                redirect_uri: 'YOUR URL HERE',
                link: 'https://developers.facebook.com/docs/reference/dialogs/',
                picture: 'http://fbrell.com/f8.jpg',
                name: 'Facebook Dialogs',
                caption: 'Reference Documentation',
                description: 'Using Dialogs to interact with people.'
            };

            function callback(response) {
                document.getElementById('msg').innerHTML = "Post ID: " + response['post_id'];
            }

            FB.ui(obj, callback);
        }


        // Load the SDK Asynchronously
        (function (d) {
            var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
            if (d.getElementById(id)) { return; }
            js = d.createElement('script'); js.id = id; js.async = true;
            js.src = "//connect.facebook.net/en_US/all.js";
            ref.parentNode.insertBefore(js, ref);
        } (document));
    </script>
    </form>
</body>
</html>
