<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            font-family: "Segoe UI", sans-serif;
            background-image: url('https://cdn.wallpapersafari.com/80/26/W34E0N.jpg');
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
            color: #e490b3;
            line-height: 1.6;
        }

        .container {
            max-width: 800px;
            margin: 3rem auto;
            background-color: rgba(68, 3, 3, 0.92);
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(171, 223, 76, 0.25);
            text-align: left;
            color: white;
        }

        h1 {
            color: #1f0101;
            margin-bottom: 1.5rem;
            text-align: center;
            font-size: 2.2rem;
            border-bottom: 2px solid #e1bee7;
            padding-bottom: 10px;
        }

        h2 {
            color: #110101;
            margin-bottom: 1.5rem;
            font-size: 1.8rem;
            text-align: center;
        }

        p {
            font-size: 1.1rem;
            margin: 0.8rem 0;
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #f3e5f5;
            padding-bottom: 8px;
        }

        p strong {
            font-weight: 600;
            color: #dfca0c;
            min-width: 150px;
        }

        a {
            color: #000000;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        a:hover {
            color: #000000;
            text-decoration: underline;
        }

        img {
            margin: 1.5rem auto;
            max-width: 100%;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            display: block;
        }

        .return-link {
            text-align: center;
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 2px solid #ec577c;
        }

        .return-link a {
            display: inline-block;
            background-color: #cc2e22;
            color: white;
            padding: 10px 20px;
            border-radius: 30px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .return-link a:hover {
            background-color: #ee0d0d;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .btn-favori {
    display: inline-block;
    background-color: #1a0101;
    color: white;
    padding: 15px 30px; /* plus de hauteur et largeur */
    font-size: 1.2rem;  /* taille du texte plus grande */
    border: none;
    border-radius: 30px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease;
    margin-top: 10px;
    margin-bottom: 10px;
}

        .btn-favori:hover {
            background-color: #e70b28;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .emoji {
            font-size: 2.5rem;
    margin-right: 10px;
    animation: glow 1.5s infinite ease-in-out;
    display: inline-block;
}

@keyframes glow {
    0%   { text-shadow: 0 0 5px #fff, 0 0 10px #ffd700, 0 0 15px #ffd700; }
    50%  { text-shadow: 0 0 10px #fff, 0 0 20px #ffea00, 0 0 30px #ffd700; }
    100% { text-shadow: 0 0 5px #fff, 0 0 10px #ffd700, 0 0 15px #ffd700; }
}

    </style>
</head>
<body>
<div class="container">
    <h1><span class="emoji">⭐</span> Détails du Film</h1>
    <c:if test="${not empty film}">
        <h2>${film.titre}</h2>
        <p><strong>Date de sortie :</strong> ${film.anneesortie}</p>
        <p><strong>Genre :</strong> ${film.genre}</p>
        <p><strong>Réalisateur :</strong> ${film.auteurfilm}</p>
        <p><strong>Acteurs :</strong> ${film.acteurs}</p>
        <p><strong>Description du film :</strong> ${film.descriptionlfilm}</p>
        <p><strong>Lien du film :</strong> <a href="${film.lienfilm}">${film.lienfilm}</a></p>
        <p><strong>Disponibilité du livre :</strong> ${film.dispolivre}</p>
        <p><strong>Titre du livre :</strong> ${film.titrelivre}</p>
        <p><strong>Lien du livre :</strong> <a href="${film.lienlivre}">${film.lienlivre}</a></p>
        <img src="${film.imagefilm}" alt="${film.titre}" style="max-width: 300px;">

        <form action="myController" method="post">
            <input type="hidden" name="submitbtn" value="ajouterFavori">
            <input type="hidden" name="idFilm" value="${film.idFilmlivre}">
            <button type="submit" class="btn-favori">❤️ Ajouter aux favoris</button>
        </form>
		<form action="myController" method="get">
		<div class="return-link a">
            <input type="hidden" name="submitbtn" value="RetourFilm">
            <button type="submit" class="btn-favori">← Retour à la liste des films</button>
            </div>
        </form>
        
    </c:if>

    <c:if test="${empty film}">
        <p>Film introuvable ou non spécifié.</p>
    </c:if>
</div>
</body>
</html>
