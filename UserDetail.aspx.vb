Partial Class UserDetail
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim sProfileId As String = Request.QueryString("ProfileId")
        Dim client As New Facebook.FacebookClient(Session("accessToken").ToString)
        Dim friendlists As Object = client.[Get]("/" + sProfileId + "", New With {Key .fields = "id,first_name,last_name,birthday,gender,location,bio,picture.height(200),mutualfriends.fields(gender,name,devices)"})
    End Sub
End Class
