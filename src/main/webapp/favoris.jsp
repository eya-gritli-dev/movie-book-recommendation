<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="entities.Filmslivre" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mes favoris - CineJoy</title>
    <style>
        body {
            background-color: #1d0574;
            font-family: 'Poppins', sans-serif;
            color: #fff;
            padding: 40px;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        .film-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: auto;
        }

        .film-card {
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 10px;
            text-align: center;
            color: aliceblue;
            position: relative;
        }

        .film-card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 10px;
        }

        .film-card h3 {
            margin-top: 15px;
        }

        .btn-supprimer {
            margin-top: 15px;
            padding: 10px 20px;
            background-color: #ff4d4d;
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-supprimer:hover {
            background-color: #cc0000;
        }

        .film-card form {
            margin-top: 10px;
        }

        .film-link {
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>
<body>
    <h1>🎬 Mes films favoris</h1>

    <c:if test="${empty favoris}">
        <p style="text-align: center;">Vous n'avez encore ajouté aucun film aux favoris.</p>
    </c:if>

    <div class="film-container">
        <c:forEach var="film" items="${favoris}">
            <div class="film-card">
                <a href="myController?submitbtn=detailFilm&idFilm=${film.idFilmlivre}" class="film-link">
                    <img src="${film.imagefilm}" alt="${film.titre}">
                    <h3>${film.titre}</h3>
                </a>
                <form action="myController" method="post">
                    <input type="hidden" name="idFilm" value="${film.idFilmlivre}">
                    <button type="submit" name="submitbtn" value="supdufavoris" class="btn-supprimer">
                        Retirer des favoris
                    </button>
                </form>
            </div>
        </c:forEach>
    </div>
</body>
</html>
