<%-- 
    Document   : favorite
    Created on : 5 nov 2024, 8:15:15 p.m.
    Author     : Jairo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="movies.database.module.databaseHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <style>
            html, body {
                height: 100%;
            }
            body {
                display: flex;
                flex-direction: column;
            }
            main {
                flex-grow: 1;
            }
        </style>
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String msg = request.getParameter("msg");
        %>
        <%
            if (session.getAttribute("email") == null) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp?error=You must log in");
                dispatcher.forward(request, response);
            }

            String email = session.getAttribute("email").toString();

            databaseHelper ds = new databaseHelper();
            ResultSet resultsUser = ds.getUser(email);
            ResultSet resultset = ds.getFavoriteMovies(email);
           
            resultsUser.next();
        %>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp">MoviesApp</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="index.jsp">Welcome <%=resultsUser.getString("firstName")%></a>
                        </li> 
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp">Home</a>
                        </li>                  
                        <li class="nav-item">
                            <a class="nav-link" href="favorite.jsp">Favorites</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">Logout</a>
                        </li> 
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <div class="row">
                <div class="col-12">
                    <h2 class="text-center">Favorite Movies</h2>
                </div>
            </div>
        </div>

        <main class='container mt-5'>
            <div class="row">
                <% while (resultset.next()) {%>
                <div class="card" style="width: 18rem;margin-right: 10px">
                    <img src="<%=resultset.getString("photo")%>" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title"><%=resultset.getString("title")%></h5>
                        <p class="card-text"><%=resultset.getString("releaseDate")%></p>                            
                    </div>
                    <div class='mb-3'>
                        <button type='submit' onclick="window.location.href = 'deleteFavoriteMovie.jsp?email=<%=email%>&idMovie=<%=resultset.getInt("id")%>'" class='btn btn-danger'>Eliminar</button>
                    </div> 
                </div>                        
                <% }%>                    
            </div>
        </main>
    </body>
</html>
