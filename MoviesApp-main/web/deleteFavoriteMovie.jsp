<%-- 
    Document   : deleteFavoriteMovie
    Created on : 9 nov 2024, 7:52:32 p.m.
    Author     : Jairo
--%>


<%@page import="movies.database.module.databaseHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String email = request.getParameter("email");
    int idMovie = Integer.parseInt(request.getParameter("idMovie"));    
    String path;
    databaseHelper dt = new databaseHelper();

    if (dt.deleteFavoriteMovie(email, idMovie)) {        
        path = "/favorite.jsp?msg=Movie deleted";
    } else {
        path = "/favorite.jsp?msg=Error deleting the Movie";
    }
    
    dt.Close();
    RequestDispatcher dispatcher = request.getRequestDispatcher(path);
    dispatcher.forward(request, response);
%>
