Imports Newtonsoft.Json
Imports System.Dynamic
Imports Facebook

Partial Class Landing
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Session("accessToken") Is Nothing Then
            Response.Redirect("Default.aspx")
        End If

    End Sub
    Protected Sub btnTest_Click(sender As Object, e As System.EventArgs) Handles btnTest.Click
        Dim client As New Facebook.FacebookClient(Session("accessToken").ToString)
        Dim friendlists As Object = client.[Get]("me", New With {Key .fields = "friendlists.fields(members.fields(name,picture,id))"})
        'Dim friendlists As Object = client.[Get]("/fql", New With {Key .q = "SELECT uid, name, pic,birthday_date, profile_url FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me())"})

        For Each [friendlist] In friendlists("friendlists")("data")
            'There can be many friend lists and each list can have many friends
            Dim objList As Object = [friendlist]

            Try
                For Each [member] In objList("members")("data")
                    Dim objMember As Object = [member]
                    Dim fbUser As New FbUser()
                    fbUser.ProfileId = [member].id
                    fbUser.ProfileName = [member].name
                    Try
                        fbUser.ProfilePic = [member].picture("data").url
                    Catch
                        fbUser.ProfileName = String.Empty
                    End Try

                    Dim xtblRow As New TableRow
                    Dim xCelId As New TableCell
                    xCelId.Style("padding") = "5px"
                    xCelId.Text = fbUser.ProfileId

                    Dim xCellName As New TableCell
                    xCellName.Text = fbUser.ProfileName
                    xCellName.Style("padding") = "5px"

                    Dim xCellPic As New TableCell
                    xCellPic.Text = "<img src='" + fbUser.ProfilePic + "'></img>"
                    xCellPic.Style("padding") = "5px"

                    Dim xCellAlbums As New TableCell
                    xCellAlbums.Text = "<a href='UserDetail.aspx?ProfileId=" + fbUser.ProfileId + "'>Album</a>"
                    xCellAlbums.Style("padding") = "5px"

                    xtblRow.Cells.Add(xCellPic)
                    xtblRow.Cells.Add(xCellName)
                    '  xtblRow.Cells.Add(xCelId)
                    xtblRow.Cells.Add(xCellAlbums)
                    xtblFriends.Rows.Add(xtblRow)
                Next
            Catch
            End Try
        Next



    End Sub
    Protected Sub xbtnPostToWall_Click(sender As Object, e As EventArgs) Handles xbtnPostToWall.Click
        'PostToMyWallDemo(client)
    End Sub
    Private Sub PostToMyWallDemo(ByVal client As FacebookClient)
        Dim objWallPost As New FBWallPost()
        objWallPost.picture = "http://www.dotnetfunda.com/UserFiles/Profiles/Jayakumars_Profile_5589_kaka.jpg"
        objWallPost.link = "http://sbvs.com/"
        objWallPost.name = "Facebook uhuhu..."
        objWallPost.caption = " Facebook caption"
        objWallPost.description = "[description] Facebook description"
        objWallPost.message = "[message] Facebook message"
        Util.PostToMyWall("MysoreGuy", objWallPost, client)
    End Sub
End Class


