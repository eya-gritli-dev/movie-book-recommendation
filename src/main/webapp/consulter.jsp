<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="entities.Filmslivre" %>
<%
String role = (String) session.getAttribute("role");
if (role == null || !role.equals("admin")) {
    response.sendRedirect("authentification.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administration - CineJoy</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-color: #3d5a80;
            --secondary-color: #98c1d9;
            --accent-color: #ee6c4d;
            --dark-color: #293241;
            --light-color: #e0fbfc;
            --success-color: #2ecc71;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background-color: #f5f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--dark-color);
            line-height: 1.6;
            padding: 0;
        }
        
        header {
            background-color: var(--primary-color);
            color: white;
            padding: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        header h1 {
            margin: 0;
            font-size: 2rem;
        }
        
        /* Styles pour le menu utilisateur */
        .user-menu {
            position: relative;
            display: inline-block;
        }
        
        .user-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--accent-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 1.2rem;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }
        
        .user-icon:hover {
            background-color: #e85d3a;
            transform: scale(1.05);
        }
        
        .dropdown-menu {
            position: absolute;
            top: 50px;
            right: 0;
            background-color: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 200px;
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: all 0.3s ease;
            z-index: 1000;
        }
        
        .user-menu:hover .dropdown-menu {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }
        
        .dropdown-menu .user-header {
            padding: 15px;
            background-color: var(--secondary-color);
            color: var(--dark-color);
            border-radius: 8px 8px 0 0;
            text-align: center;
            font-weight: bold;
        }
        
        .dropdown-menu ul {
            list-style: none;
            padding: 10px 0;
        }
        
        .dropdown-menu ul li {
            padding: 0;
        }
        
        .dropdown-menu ul li a {
            display: flex;
            align-items: center;
            padding: 10px 15px;
            color: var(--dark-color);
            text-decoration: none;
            transition: all 0.2s ease;
        }
        
        .dropdown-menu ul li a:hover {
            background-color: #f5f5f5;
            color: var(--accent-color);
        }
        
        .dropdown-menu ul li i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .admin-title {
            font-size: 1.2rem;
            font-weight: bold;
            color: white;
        }
        
        .content {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 50px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
        .btn-ajouter {
            background-color: var(--success-color);
            color: white;
        }
        
        .btn-ajouter:hover {
            background-color: #27ae60;
            transform: translateY(-2px);
        }
        
        .btn-modifier {
            background-color: var(--warning-color);
            color: white;
        }
        
        .btn-modifier:hover {
            background-color: #e67e22;
            transform: translateY(-2px);
        }
        
        .btn-supprimer {
            background-color: var(--danger-color);
            color: white;
        }
        
        .btn-supprimer:hover {
            background-color: #c0392b;
            transform: translateY(-2px);
        }
        
        .film-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }
        
        .film-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            display: flex;
            flex-direction: column;
        }
        
        .film-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        
        .film-image {
            position: relative;
            height: 320px;
            overflow: hidden;
        }
        
        .film-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }
        
        .film-card:hover .film-image img {
            transform: scale(1.05);
        }
        
        .film-info {
            padding: 15px;
            flex-grow: 1;
        }
        
        .film-info h3 {
            margin: 0 0 10px 0;
            font-size: 1.2rem;
            color: var(--dark-color);
        }
        
        .film-actions {
            display: flex;
            gap: 10px;
            padding: 15px;
            border-top: 1px solid #f1f1f1;
        }
        
        .film-actions .btn {
            flex: 1;
            padding: 8px;
            font-size: 0.8rem;
        }
        
        .no-films {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }
        
        @media (max-width: 768px) {
            .film-container {
                grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));
            }
            
            header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .user-menu {
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1><i class="fas fa-film"></i> CineJoy - Administration</h1>
        
        <!-- Menu utilisateur avec icône -->
        <div class="user-menu">
            <div class="user-icon">
                <i class="fas fa-user"></i>
            </div>
            <div class="dropdown-menu">
                <div class="user-header">
                    Admin
                </div>
                <ul>
                <li>
                        <a href="accueil.jsp">
                            <i class="fas fa-sign-out-alt"></i> ACCUEIL
                        </a>
                    </li>
                    
                    <li>
                        <a href="myController?submitbtn=deconnexion">
                            <i class="fas fa-sign-out-alt"></i> Déconnexion
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </header>
    
    <div class="content">
        <div class="page-header">
            <h2><i class="fas fa-list"></i> Liste des Films</h2>
            <a href="Ajouter.jsp" class="btn btn-ajouter">
                <i class="fas fa-plus-circle"></i> Ajouter un film
            </a>
        </div>
        
        <div class="film-container">
            <c:choose>
                <c:when test="${not empty films}">
                    <c:forEach var="film" items="${films}">
                        <div class="film-card">
                            <div class="film-image">
                                <a href="myController?submitbtn=detailFilm&idFilm=${film.idFilmlivre}">
                                    <img src="${film.imagefilm}" alt="${film.titre}">
                                </a>
                            </div>
                            <div class="film-info">
                                <h3>${film.titre}</h3>
                                <p><small>${film.anneesortie} | ${film.genre}</small></p>
                            </div>
                                <div class="film-actions">



                                <a href="myController?submitbtn=modifier&idFilm=${film.idFilmlivre}" class="btn btn-modifier">



                                    <i class="fas fa-edit"></i> Modifier



                                </a>



                                <a href="myController?submitbtn=supprimer&idFilm=${film.idFilmlivre}" class="btn btn-supprimer" >



                                    <i class="fas fa-trash"></i> Supprimer



                                </a>



                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-films">
                        <i class="fas fa-film" style="font-size: 3rem; color: #ddd; margin-bottom: 1rem;"></i>
                        <h3>Aucun film disponible</h3>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>