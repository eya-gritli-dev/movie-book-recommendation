<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineJoy - Recommandations Films et Livres</title>
    <style>
        body {
            background:linear-gradient( #1d0574, #9395f5);
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
            font-family: 'Poppins', sans-serif;
            color: #333;
            margin: 0;
            padding: 0 20px;
        }

        header {
            text-align: center;
            padding: 40px 0 20px;
            position: relative;
        }

        header h1 {
            font-size: 48px;
            background: linear-gradient(90deg, #FF6B6B, #FFD166, #06D6A0, #118AB2, #9A48D0);
            background-size: 400% 100%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 2px 2px 6px rgba(140, 185, 14, 0.1);
            margin-bottom: 15px;
            animation: shine 6s linear infinite;
            font-weight: 700;
            letter-spacing: 1px;
        }

        @keyframes shine {
            0% { background-position: 0% center; }
            100% { background-position: 400% center; }
        }

        header p {
            font-size: 18px;
            color: #fff;
            text-shadow: 1px 1px 3px rgba(48, 41, 46, 0.5);
            max-width: 600px;
            margin: 0 auto 20px;
            background: linear-gradient(145deg, #e668ff, #06D6A0);
            padding: 8px 15px;
            border-radius: 30px;
            display: inline-block;
        }

        header .logo {
            font-size: 52px;
            color: #ffdf00;
            margin-right: 15px;
            vertical-align: middle;
            text-shadow: 0 0 10px rgba(255, 223, 0, 0.5);
            display: inline-block;
            transform: rotate(-8deg);
            animation: pulse 2s infinite alternate;
        }

        @keyframes pulse {
            from { transform: rotate(-8deg) scale(1); }
            to { transform: rotate(-8deg) scale(1.1); }
        }

        .search-container {
            margin-bottom: 30px;
            text-align: center;
            background-color: rgba(86, 201, 221, 0.15);
            backdrop-filter: blur(10px);
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            max-width: 800px;
            margin: 0 auto 40px;
        }

        .search-container form {
            display: inline-flex;
            gap: 15px;
            flex-wrap: wrap;
            justify-content: center;
            width: 100%;
        }

        input[type="text"], select {
            padding: 14px;
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            background-color: rgba(218, 92, 134, 0.25);
            color: #fff;
            font-size: 16px;
            outline: none;
            transition: all 0.3s ease;
            min-width: 200px;
            backdrop-filter: blur(5px);
            box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        input[type="text"]::placeholder {
            color: rgba(255, 255, 255, 0.8);
        }

        input[type="text"]:focus, select:focus {
            background-color: rgba(255, 255, 255, 0.35);
            border-color: #9A48D0;
            box-shadow: 0 0 0 2px rgba(154, 72, 208, 0.3);
        }

        select {
            appearance: none;
            padding-right: 35px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='white' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 20px;
        }

        select option {
            background-color: #333;
            color: #fff;
        }

        button {
            background: linear-gradient(45deg, #FF6B6B, #9A48D0);
            border: none;
            padding: 14px 28px;
            border-radius: 12px;
            font-weight: 600;
            color: #fff;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 16px;
            box-shadow: 0 4px 15px rgba(154, 72, 208, 0.4);
            position: relative;
            overflow: hidden;
        }

        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(154, 72, 208, 0.6);
        }

        button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: 0.5s;
        }

        button:hover::before {
            left: 100%;
        }

        .film-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
            justify-content: center;
            padding: 20px 0 60px;
            max-width: 1300px;
            margin: auto;
        }

        .film-card {
            background: linear-gradient(145deg, #e668ff, #06D6A0);
            border-radius: 18px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            text-align: center;
            transition: all 0.4s ease;
            position: relative;
            z-index: 1;
        }

        .film-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(145deg, #9A48D0, #06D6A0);
            opacity: 0;
            transition: opacity 0.4s ease;
            z-index: -1;
        }

        .film-card:hover {
            transform: translateY(-12px) scale(1.03);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .film-card:hover::before {
            opacity: 1;
        }

        .film-card img {
            width: 100%;
            height: 320px;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .film-card:hover img {
            transform: scale(1.08);
        }

        .film-card h3 {
            font-size: 20px;
            margin: 20px 15px;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease;
        }

        .film-card:hover h3 {
            transform: scale(1.05);
        }

        .film-card h3 i {
            color: #fff;
            font-size: 22px;
        }

        @media (max-width: 768px) {
            header h1 {
                font-size: 36px;
            }
            
            .search-container form {
                flex-direction: column;
                align-items: center;
            }
            
            input[type="text"], select, button {
                width: 100%;
                max-width: 300px;
            }
            
            .film-container {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 20px;
            }}
.nav-bar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  background-color: #0d012b;
  padding: 15px;
  text-align: center;
  z-index: 1000;
}
.nav-bar ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  display: flex;
  justify-content: space-around;
  align-items: center;
}

.nav-bar li {
  margin-right: 20px;
  color: aqua;
}

.nav-bar a {
  color: #fff;
  text-decoration: none;
  transition: color 0.3s ease;
}

.nav-bar a:hover {
  color: #ff9a9e;
}

.nav-logo {
  font-size: 24px;
  font-weight: bold;
  margin-right: 40px;
}

.favoris-btn-nav {
  background: linear-gradient(135deg, #ff9a9e, #fad0c4);
  padding: 8px 16px;
  border-radius: 50px;
}

.favoris-btn-nav a {
  color: #fff;
}

.favoris-btn-nav:hover {
  background: linear-gradient(135deg, #fad0c4, #ff9a9e);
}

/* Bouton favoris spécifique reste inchangé */
.favoris-btn {
  position: absolute;
  top: 80px;
  right: 30px;
  padding: 12px 25px;
  background: linear-gradient(135deg, #ff9a9e, #fad0c4);
  color: #fff;
  font-weight: 700;
  border-radius: 50px;
  text-decoration: none;
  font-size: 16px;
  box-shadow: 0 8px 20px rgba(13, 15, 9, 0.2);
  transition: all 0.3s ease;
  z-index: 10;
  cursor: pointer;
  border: none;
}

.favoris-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.25);
  background: linear-gradient(135deg, #fad0c4, #ff9a9e);
}

.favoris-btn:active {
  transform: translateY(2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}
.user-dropdown {
    position: relative;
    cursor: pointer;
    color: white;
}

.user-dropdown i {
    transition: color 0.3s;
}

.user-dropdown i:hover {
    color: #ff9a9e;
}

.dropdown-menu {
    display: none;
    position: absolute;
    right: 0;
    top: 40px;
    background-color: #fff;
    color: #333;
    padding: 15px;
    border-radius: 10px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
    z-index: 1001;
    min-width: 180px;
    text-align: left;
}

.dropdown-menu p {
    margin: 0 0 10px;
    font-weight: bold;
}

.dropdown-menu button {
    background: #ff6b6b;
    border: none;
    padding: 10px 15px;
    color: white;
    border-radius: 8px;
    cursor: pointer;
    font-weight: bold;
    width: 100%;
}
.user-icon-container {
  position: relative;
  display: flex;
  align-items: center;
}

.user-icon-container .fa-user {
  font-size: 18px;
  color: #118AB2;
  margin-right: 8px;
}

.user-badge {
  position: absolute;
  top: -4px;
  left: 10px;
  font-size: 10px;
  color: gold;
}

.username-text {
  font-weight: bold;
}


.dropdown-menu button:hover {
    background: #d64545;
}
    </style>
</head>
<body>
    <header>
     <nav class="nav-bar">
      <ul>
        <li><a href="#" class="nav-logo">🎬 CineJoy</a></li>
        <li><a href="#">Accueil</a></li>
     
        <li class="user-dropdown">
            <i class="fas fa-user-circle fa-2x" id="userIcon"></i>
            <div class="dropdown-menu" id="dropdownMenu">
            <div class="user-icon-container">
  <i class="fas fa-user"></i>
  <i class="fas fa-star user-badge"></i>
                  <p>${sessionScope.utilisateur.prenom}</p>
  
</div>
            
                <form action="myController" method="post">
                    <input type="hidden" name="submitbtn" value="deconnexion">
                    <button type="submit">Se déconnecter</button>
                </form>
            </div>
        </li>
        
        <li class="favoris-btn-nav"><a href="myController?submitbtn=favoris">💖 Voir mes favoris</a></li>
      </ul>
    </nav>
        <h1><span class="logo">🎬</span> ✨Bienvenue sur CineJoy✨</h1>
        <p>Découvrez et explorez les meilleurs films et leurs adaptations littéraires</p>
        
    </header>

    <div class="search-container">
        <form action="myController" method="GET">
            <input type="text" name="query" placeholder="Rechercher un film...">
            <select name="genre">
                <option value="">Tous les genres</option>
                <option value="action">Action</option>
                <option value="drame">Drame</option>
                <option value="science-fiction">Science-Fiction</option>
                <option value="romance">Romance</option>
                <option value="comédie">Comédie</option>
                <option value="Aventure">Aventure</option>
            </select>
            <button type="submit" name ="submitbtn" value="rechercher">
                <i class="fas fa-search"></i> Rechercher
            </button>
        </form>
    </div>

    <div class="film-container">
        <c:forEach var="film" items="${requestScope.films}">
            <a href="myController?submitbtn=detailFilm&idFilm=${film.idFilmlivre}" style="text-decoration: none;">
                <div class="film-card">
                    <img src="${film.imagefilm}" alt="${film.titre}">
                    <h3><i class="fas fa-video"></i> ${film.titre}</h3>
                </div>
            </a>
        </c:forEach>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const userIcon = document.getElementById('userIcon');
            const dropdownMenu = document.getElementById('dropdownMenu');
            
            if (userIcon && dropdownMenu) {
                userIcon.addEventListener('click', function(e) {
                    e.stopPropagation();
                    if (dropdownMenu.style.display === 'block') {
                        dropdownMenu.style.display = 'none';
                    } else {
                        dropdownMenu.style.display = 'block';
                    }
                });
                
                // Fermer le menu quand on clique ailleurs sur la page
                document.addEventListener('click', function(e) {
                    if (!userIcon.contains(e.target) && !dropdownMenu.contains(e.target)) {
                        dropdownMenu.style.display = 'none';
                    }
                });
            }
        });
    </script>
</body>
</html>