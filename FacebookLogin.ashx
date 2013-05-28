<%@ WebHandler Language="VB" Class="FacebookLogin" %>

Imports System
Imports System.Web

Public Class FacebookLogin : Implements IHttpHandler, System.Web.SessionState.IRequiresSessionState
    
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Dim accessToken As Object = context.Request("accessToken")
        context.Session("accessToken") = accessToken
        context.Response.Redirect("Landing.aspx")
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class