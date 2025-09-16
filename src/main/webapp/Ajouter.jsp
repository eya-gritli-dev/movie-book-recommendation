<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

  <title>Ajouter un Film - CineJoy</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

  <style>

  body {
    background: linear-gradient(120deg, #8E44AD, #FFC3A0);
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    animation: fadeIn 1s ease-in-out;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.form-container {
    background: rgba(255, 255, 255, 0.95);
    padding: 25px;
    border-radius: 16px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
    max-width: 750px; /* Augmentation de la largeur */
    width: 95%; /* Adaptation dynamique */
    border: 2px solid #9B59B6;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.form-container:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.25);
}

h2 {
    text-align: center;
    color: #6D3777;
    font-weight: bold;
}

.form-label {
    color: #6D3777;
    font-weight: bold;
}

.form-control {
    background: #FAF0E6;
    border: 1.5px solid #E1BEE7;
    border-radius: 10px;
    color: #4A148C;
    padding: 10px;
    transition: all 0.3s ease;
}

.form-control:focus {
    border-color: #AB47BC;
    box-shadow: 0 0 8px rgba(171, 71, 188, 0.3);
}

.btn-submit {
    background: linear-gradient(90deg, #9B59B6, #FF77A9);
    color: white;
    font-weight: bold;
    border: none;
    border-radius: 12px;
    padding: 10px 20px;
    transition: transform 0.2s, box-shadow 0.2s;
}

.btn-submit:hover {
    background: linear-gradient(90deg, #FF77A9, #9B59B6);
    transform: scale(1.05);
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
}

.btn-cancel {
    background: #E74C3C;
    color: white;
    font-weight: bold;
    border: none;
    border-radius: 12px;
    padding: 10px 20px;
}

.btn-cancel:hover {
    background: #C0392B;
}

textarea.form-control {
    resize: vertical;
}

.radio-options label {
    margin-right: 10px;
    font-weight: normal;
    color: #6A1B9A;
}

  </style>

</head>

<body>

  <div class="form-container">

    <h2>Ajouter un Film</h2>

    <form action="myController" method="POST">

      <div class="row g-3">

        <div class="col-md-6">

          <label class="form-label">Titre du Film</label>

          <input type="text" class="form-control" name="titre_film" placeholder="Titre du Film" required>

        </div>

        <div class="col-md-6">

          <label class="form-label">Genre</label>

          <select class="form-control" name="genre_film" required>

            <option>Choisir...</option>

            <option>Action</option>

            <option>Aventure</option>

            <option>Animation</option>

            <option>Biographie</option>

            <option>Comédie</option>

            <option>Crime</option>

            <option>Documentaire</option>

            <option>Drame</option>

            <option>Fantastique</option>

            <option>Horreur</option>

            <option>Historique</option>

            <option>Musical</option>

            <option>Mystère</option>

            <option>Policier</option>

            <option>Romance</option>

            <option>Science-Fiction</option>

            <option>Thriller</option>

            <option>Western</option>

          </select>

        </div>

        <div class="col-md-6">

          <label class="form-label">Année de Sortie</label>

          <input type="date" class="form-control" name="annee_sortie" required>

        </div>

        <div class="col-md-6">

          <label class="form-label">Acteurs Principaux</label>

          <input type="text" class="form-control" name="acteurs_film" placeholder="Nom des acteurs">

        </div>

        <div class="col-md-6">

          <label class="form-label">Auteur du Film</label>

          <input type="text" class="form-control" name="auteur_film" placeholder="Auteur du Film">

        </div>

        <div class="col-12">

          <label class="form-label">Description du Film</label>

          <textarea class="form-control" name="description_film" placeholder="Résumé du film"></textarea>

        </div>

        <div class="col-md-6">

          <label class="form-label">Lien</label>

          <input type="url" class="form-control" name="lien_film" placeholder="URL bande-annonce" required>

        </div>

        <div class="col-md-6">

          <label class="form-label">Image du Film</label>

          <input type="url" class="form-control" name="image_film" placeholder="URL image du film" required>

        </div>

      </div>



      <div class="mt-3">

        <label class="form-label">Disponibilité du Livre :</label>

        <div>

          <input type="radio" name="disponibilite_livre" id="livreOui" value="disponible" checked>

          <label for="livreOui">📚 Disponible</label>

          <input type="radio" name="disponibilite_livre" id="livreNon" value="non disponible">

          <label for="livreNon">❌ Non Disponible</label>

        </div>

      </div>



      <div id="livreInfos" class="row g-3 mt-3">

        <div class="col-md-6">

          <label class="form-label">Nom du Livre</label>

          <input type="text" class="form-control" name="nom_livre" placeholder="Nom du Livre">

        </div>

        <div class="col-md-6">

          <label class="form-label">Auteur du Livre</label>

          <input type="text" class="form-control" name="auteur_livre" placeholder="Auteur du Livre">

        </div>

        <div class="col-md-12">

          <label class="form-label">Lien du Livre</label>

          <input type="url" class="form-control" name="lien_livre" placeholder="URL du livre">

        </div>

        <div class="col-12">

          <label class="form-label">Description du Livre</label>

          <textarea class="form-control" name="description_livre" placeholder="Description du livre"></textarea>

        </div>

      </div>
      <div class="row">
	
	<div class="col">
            <input type="submit" value="Ajouter" name="submitbtn" class="btn btn-submit">

    </form></div>
    <div class="col">
         <form action="myController" method="POST">
             <input type="submit" value="annuler" name="submitbtn" class="btn btn-cancel">
            </form></div>
		
</div>
    </div>


  <script>

    document.getElementById("livreNon").addEventListener("change", function() {

      document.getElementById("livreInfos").style.display = "none";

    });

    document.getElementById("livreOui").addEventListener("change", function() {

      document.getElementById("livreInfos").style.display = "block";

    });



    // Initial state

    if (document.getElementById("livreNon").checked) {

      document.getElementById("livreInfos").style.display = "none";

    }

  </script>

</body>

</html>