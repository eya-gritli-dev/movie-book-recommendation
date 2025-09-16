<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

    <title>Modifier Film/Livre - CinéLivre</title>

    <style>

        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        

        * {

            margin: 0;

            padding: 0;

            box-sizing: border-box;

            font-family: 'Poppins', sans-serif;

        }

        

        body {

            background-color: #f8f0ff;

            background-image: linear-gradient(45deg, #f8f0ff 0%, #ffeeff 100%);

            min-height: 100vh;

            padding-bottom: 80px;

        }

        

        .header {

            background: linear-gradient(135deg, #c471ed 0%, #f64f59 100%);

            color: white;

            padding: 25px;

            text-align: center;

            box-shadow: 0 4px 15px rgba(193, 123, 233, 0.4);

            animation: headerGlow 3s infinite alternate;

        }

        

        @keyframes headerGlow {

            0% {

                box-shadow: 0 4px 15px rgba(193, 123, 233, 0.4);

            }

            100% {

                box-shadow: 0 4px 25px rgba(246, 79, 89, 0.6);

            }

        }

        

        .header h1 {

            font-size: 32px;

            font-weight: 600;

            text-shadow: 1px 1px 3px rgba(0,0,0,0.2);

            letter-spacing: 1px;

        }

        

        .container {

            width: 90%;

            max-width: 900px;

            margin: 40px auto;

            background: white;

            padding: 30px;

            border-radius: 12px;

            box-shadow: 0 10px 30px rgba(193, 123, 233, 0.3);

            border: 2px solid #d6a8e6;

            transform: translateY(0);

            transition: all 0.3s ease;

        }

        

        .container:hover {

            transform: translateY(-5px);

            box-shadow: 0 15px 35px rgba(193, 123, 233, 0.5);

        }

        

        .form-title {

            color: #9c5dc4;

            text-align: center;

            margin-bottom: 30px;

            font-size: 24px;

            font-weight: 600;

            position: relative;

            padding-bottom: 10px;

        }

        

        .form-title::after {

            content: '';

            position: absolute;

            width: 100px;

            height: 3px;

            background: linear-gradient(to right, #c471ed, #f64f59);

            bottom: 0;

            left: 50%;

            transform: translateX(-50%);

            border-radius: 2px;

        }

        

        .form-group {

            display: flex;

            margin-bottom: 25px;

            align-items: center;

            position: relative;

        }

        

        .form-group label {

            width: 30%;

            color: #6a1b9a;

            font-weight: 500;

            padding-right: 15px;

            text-align: right;

            transition: all 0.3s ease;

        }

        

        .form-group input, .form-group select, .form-group textarea {

            width: 70%;

            padding: 12px 15px;

            border: 1px solid #d6a8e6;

            border-radius: 8px;

            font-size: 16px;

            background-color: #faf6ff;

            transition: all 0.3s ease;

        }

        

        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {

            outline: none;

            border-color: #c471ed;

            box-shadow: 0 0 8px rgba(196, 113, 237, 0.5);

            background-color: #fff;

        }

        

        .form-group input:focus + label, .form-group select:focus + label, .form-group textarea:focus + label {

            color: #c471ed;

        }

        

        .form-section {

            border-top: 1px solid #f0e0ff;

            padding-top: 20px;

            margin-top: 30px;

        }

        

        .form-section-title {

            color: #f64f59;

            margin-bottom: 20px;

            font-size: 18px;

            font-weight: 500;

        }

        

        .buttons {

            display: flex;

            justify-content: center;

            gap: 30px;

            margin-top: 40px;

        }

        

        .btn {

            padding: 12px 35px;

            border: none;

            border-radius: 30px;

            cursor: pointer;

            font-size: 16px;

            font-weight: 600;

            transition: all 0.3s ease;

            box-shadow: 0 4px 10px rgba(0,0,0,0.1);

            position: relative;

            overflow: hidden;

        }

        

        .btn::before {

            content: '';

            position: absolute;

            top: 0;

            left: -100%;

            width: 100%;

            height: 100%;

            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);

            transition: all 0.4s ease;

        }

        

        .btn:hover::before {

            left: 100%;

        }

        

        .btn-primary {

            background: linear-gradient(135deg, #a367dc 0%, #8e44ad 100%);

            color: white;

        }

        

        .btn-primary:hover {

            background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);

            transform: translateY(-3px);

            box-shadow: 0 7px 15px rgba(142, 68, 173, 0.3);

        }

        

        .btn-danger {

            background: linear-gradient(135deg, #f64f59 0%, #c471ed 100%);

            color: white;

        }

        

        .btn-danger:hover {

            background: linear-gradient(135deg, #f64f59 0%, #c471ed 70%);

            transform: translateY(-3px);

            box-shadow: 0 7px 15px rgba(246, 79, 89, 0.3);

        }

        

        .footer {

            background: linear-gradient(135deg, #a367dc 0%, #8e44ad 100%);

            color: white;

            text-align: center;

            padding: 20px;

            position: fixed;

            bottom: 0;

            width: 100%;

            font-size: 14px;

            box-shadow: 0 -4px 15px rgba(193, 123, 233, 0.4);

        }

        

        .footer a {

            color: #fff;

            text-decoration: none;

            font-weight: 600;

        }

        

        /* Message d'alerte pour les notifications */

        .alert {

            padding: 15px;

            margin-bottom: 20px;

            border-radius: 8px;

            animation: fadeIn 0.5s;

        }

        

        @keyframes fadeIn {

            from { opacity: 0; transform: translateY(-10px); }

            to { opacity: 1; transform: translateY(0); }

        }

        

        .alert-success {

            background-color: #e1f5fe;

            color: #0277bd;

            border: 1px solid #b3e5fc;

        }

        

        .alert-danger {

            background-color: #ffebee;

            color: #c62828;

            border: 1px solid #ffcdd2;

        }

        

        /* Style pour les boutons radio */

        .radio-group {

            display: flex;

            gap: 20px;

            margin-left: 30%;

        }

        

        .radio-option {

            display: flex;

            align-items: center;

            cursor: pointer;

        }

        

        .radio-option input[type="radio"] {

            width: auto;

            margin-right: 8px;

            cursor: pointer;

        }

        

        .radio-option label {

            width: auto;

            text-align: left;

            cursor: pointer;

        }

        

        /* Style pour la section livre */

        .livre-section {

            transition: all 0.3s ease;

            overflow: hidden;

        }

        

        .hidden {

            max-height: 0;

            opacity: 0;

            margin: 0;

            padding: 0;

            pointer-events: none;

        }

        

        /* Responsive */

        @media (max-width: 768px) {

            .form-group {

                flex-direction: column;

                align-items: flex-start;

            }

            

            .form-group label {

                width: 100%;

                text-align: left;

                margin-bottom: 8px;

            }

            

            .form-group input, .form-group select, .form-group textarea {

                width: 100%;

            }

            

            .radio-group {

                margin-left: 0;

            }

        }

    </style>

</head>

<body>

    <div class="header">

        <h1>✨ Modifier Film/Livre ✨</h1>

    </div>

    

    <div class="container">

        <!-- Message d'alerte si nécessaire -->

        <c:if test="${not empty message}">

            <div class="alert alert-${status}">

                ${message}

            </div>

        </c:if>

        

        <h2 class="form-title">Détails du Film/Livre</h2>

        

        <form action="myController" method="POST">

            <input type="hidden" name="id_filmlivre" value="${film.idFilmlivre}" />

            

            <div class="form-group">

                <label for="titre">Titre du Film:</label>

                <input type="text" id="titre" name="titre" value="${film.titre}" required />

            </div>

            

            <div class="form-group">

                <label for="genre">Genre:</label>

                <input type="text" id="genre" name="genre" value="${film.genre}" required />

            </div>

            

            <div class="form-group">

                <label for="anneesortie">Année de sortie:</label>

                <input type="text" id="anneesortie" name="anneesortie" value="${film.anneesortie}" required />

            </div>

            

            <div class="form-group">

                <label for="auteurfilm">Réalisateur:</label>

                <input type="text" id="auteurfilm" name="auteurfilm" value="${film.auteurfilm}" required />

            </div>

            

            <div class="form-group">

                <label for="acteurs">Acteurs:</label>

                <input type="text" id="acteurs" name="acteurs" value="${film.acteurs}" required />

            </div>

            

            <div class="form-group">

                <label for="descriptionlfilm">Description du film:</label>

                <textarea id="descriptionlfilm" name="descriptionlfilm" rows="4">${film.descriptionlfilm}</textarea>

            </div>

            

            <div class="form-group">

                <label for="lienfilm">Lien du film:</label>

                <input type="text" id="lienfilm" name="lienfilm" value="${film.lienfilm}" />

            </div>

            

            <div class="form-group">

                <label for="imagefilm">Image du film:</label>

                <input type="text" id="imagefilm" name="imagefilm" value="${film.imagefilm}" />

            </div>

            

            <div class="form-section">

                <h3 class="form-section-title">Informations sur le livre associé</h3>

                

                <div class="form-group">

                    <label>Disponibilité du livre:</label>

                    <div class="radio-group">

                        <div class="radio-option">

                            <input type="radio" id="dispo_disponible" name="dispolivre" value="Disponible" ${film.dispolivre == 'Disponible' ? 'checked' : ''} />

                            <label for="dispo_disponible">Disponible</label>

                        </div>

                        <div class="radio-option">

                            <input type="radio" id="dispo_non" name="dispolivre" value="indisponible" ${film.dispolivre == 'indisponible' ? 'checked' : ''} />

                            <label for="dispo_non">Non disponible</label>

                        </div>

                    </div>

                </div>

                

                <div id="livre-section" class="livre-section ${film.dispolivre == 'Non disponible' ? 'hidden' : ''}">

                    <div class="form-group">

                        <label for="titrelivre">Titre du livre:</label>

                        <input type="text" id="titrelivre" name="titrelivre" value="${film.titrelivre}" />

                    </div>

                    

                    <div class="form-group">

                        <label for="auteurlivre">Auteur du livre:</label>

                        <input type="text" id="auteurlivre" name="auteurlivre" value="${film.auteurlivre}" />

                    </div>

                    

                    <div class="form-group">

                        <label for="descriptionlivre">Description du livre:</label>

                        <textarea id="descriptionlivre" name="descriptionlivre" rows="4">${film.descriptionlivre}</textarea>

                    </div>

                    

                    <div class="form-group">

                        <label for="lienlivre">Lien du livre:</label>

                        <input type="text" id="lienlivre" name="lienlivre" value="${film.lienlivre}" />

                    </div>

                </div>

            </div>

            

            <div class="buttons">

                <button type="submit" class="btn btn-primary" name="submitbtn" value="validerlamodif">Enregistrer</button>

                <button type="submit" class="btn btn-danger" name="submitbtn" value="annuler">Annuler</button>

            </div>

        </form>

    </div>

    

    <div class="footer">

        <p>&copy; 2025 - CinéLivre | <a href="#">Conditions d'utilisation</a> | <a href="#">Politique de confidentialité</a></p>

    </div>

    

    <script>

        // JavaScript pour afficher/masquer les champs du livre selon la disponibilité

        document.addEventListener('DOMContentLoaded', function() {

            const livreSection = document.getElementById('livre-section');

            const radioBoutons = document.querySelectorAll('input[name="dispolivre"]');

            

            // Fonction pour afficher/masquer les champs du livre

            function toggleLivreSection() {

                const dispoNonSelected = document.getElementById('dispo_non').checked;

                

                if (dispoNonSelected) {

                    livreSection.classList.add('hidden');

                    // Vider les champs du livre

                    document.getElementById('titrelivre').value = '';

                    document.getElementById('auteurlivre').value = '';

                    document.getElementById('descriptionlivre').value = '';

                    document.getElementById('lienlivre').value = '';

                } else {

                    livreSection.classList.remove('hidden');

                }

            }

            

            // Attacher le gestionnaire d'événements à tous les boutons radio

            radioBoutons.forEach(radio => {

                radio.addEventListener('change', toggleLivreSection);

            });

            

            // Vérifier l'état initial

            toggleLivreSection();

        });

    </script>

</body>

</html>