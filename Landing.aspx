<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Landing.aspx.vb" Inherits="Landing" %>

<!DOCTYPE >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

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
                    //  form.submit();


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
                to: 'srivalli.kashyap',
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

        function FriendDialog() {
            // calling the API ...
            var obj = {
                method: 'friends',
                redirect_uri: 'http://localhost',
                id: 'pinaldave'
            };

            function callback(response) {
                //document.getElementById('msg').innerHTML = "Post ID: " + response['post_id'];
            }

            FB.ui(obj, callback);
        }

        // Can send only to friends of authorized user
        function sendRequestToRecipients() {
            FB.ui({
                method: 'apprequests',
                title: "Dude, try this app!",
                message: 'http://www.msguy.com The Request string the <b>receiving<b> user will see.The message value is displayed in Notifications and can also be viewed on the App Center Requests.',
                to: 'srivalli.kashyap,rajesh.raghav.169'
            }, requestCallback);
        }

        function sendRequestViaMultiFriendSelector() {
            FB.ui({
                method: 'apprequests',
                title: "Dude, try this app!",
                message: 'The Request string the receiving user will see.The message value is displayed in Notifications and can also be viewed on the App Center Requests.'
            }, requestCallback);
        }

        function sendMsgDialog() {

            FB.ui({
                method: 'send',
                to:'pinaldave',
                link: 'http://www.msguy.com/2013/05/windows-azure-mobile-services-scripting-scheduler-push-forex-data.html',
                picture: 'http://4.bp.blogspot.com/-Ctez93Ky5mk/UVXNOTCw1BI/AAAAAAAAANw/Z3RjgSrB1mM/s320/positive-attidtue.jpg',
                name: "By default a title will be taken from the link specified",
                description: 'Optional String : The Request string the receiving user will see.The message value is displayed in Notifications and can also be viewed on the App Center Requests.'
            }, requestCallback);
        }
        function requestCallback(response) {
            // Handle callback here
        }



        // Load the SDK Asynchronously
            (function (d) {
                var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
                if (d.getElementById(id)) { return; }
                js = d.createElement('script'); js.id = id; js.async = true;
                js.src = "//connect.facebook.net/en_US/all.js";
                ref.parentNode.insertBefore(js, ref);
            }(document));
    </script>

</head>
<body>
    <form id="form1" runat="server" method="post">
        <div>
            <div id="fb-root">
            </div>

            <a href="#" onclick="PostToFeedDialog()">Post to My/Friend's Wall</a>
            <br />
            <br />
            <a href="#" onclick="FriendDialog()">Add Friend Dialog</a>
            <br />
            <br />
            <a href="#" onclick="sendRequestToRecipients()">Selected Receiver Requests</a>
            <br />
            <br />
            <a href="#" onclick="sendRequestViaMultiFriendSelector()">Multi Receiver Request</a>
            <br />
            <br />
            <a href="#" onclick="sendMsgDialog()">Send Message</a>
            <br />
            <br />
            <asp:Button runat="server" ID="xbtnPostToWall" Text="Post To My Wall" />
            <br />
            <br />
            <asp:Button runat="server" ID="btnTest" Text="Get Friends List" />
            <br />
            <asp:Table ID="xtblFriends" runat="server" GridLines="Both" Font-Size="Smaller" Font-Names="Verdana" EnableViewState="true">
            </asp:Table>

        </div>
    </form>
</body>

</html>
