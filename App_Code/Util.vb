Imports Microsoft.VisualBasic

Public Class Util

    Public Shared Function PostToMyWall(ByVal i_sProfileId As String, ByVal i_objFBWallPost As FBWallPost, ByVal client As Facebook.FacebookClient) As Object
        Dim objResponse As Object = client.[Post]("" + i_sProfileId + "/feed", i_objFBWallPost)
        Return objResponse
    End Function
End Class
