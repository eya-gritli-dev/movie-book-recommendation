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

    <title>Confirmation de suppression</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>

        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap');

        

        :root {

            --primary: #9c27b0;

            --primary-light: #ba68c8;

            --primary-dark: #7b1fa2;

            --secondary: #f3e5f5;

            --danger: #e53935;

            --danger-dark: #c62828;

            --text-dark: #4a148c;

            --text-light: #f8f1ff;

        }

        

        * {

            box-sizing: border-box;

            margin: 0;

            padding: 0;

        }

        

        body {

            font-family: 'Poppins', sans-serif;

            display: flex;

            justify-content: center;

            align-items: center;

            min-height: 100vh;

            margin: 0;

            background: 

                linear-gradient(rgba(156, 39, 176, 0.7), rgba(123, 31, 162, 0.8)),

                url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;

            background-size: cover;

            position: relative;

            overflow: hidden;

            color: var(--text-light);

        }

        

        body::before {

            content: "";

            position: absolute;

            top: 0;

            left: 0;

            width: 100%;

            height: 100%;

            background: radial-gradient(circle at 20% 30%, transparent 0%, rgba(0,0,0,0.7) 100%);

            z-index: -1;

        }

        

        .delete-box {

            background: rgba(255, 255, 255, 0.15);

            backdrop-filter: blur(10px);

            -webkit-backdrop-filter: blur(10px);

            border-radius: 20px;

            padding: 2.5rem;

            width: 450px;

            max-width: 95%;

            text-align: center;

            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);

            border: 1px solid rgba(255, 255, 255, 0.18);

            transform: translateY(0);

            animation: float 6s ease-in-out infinite;

            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);

        }

        

        .delete-box:hover {

            transform: translateY(-5px);

            box-shadow: 0 12px 40px rgba(31, 38, 135, 0.5);

        }

        

        @keyframes float {

            0% { transform: translateY(0px); }

            50% { transform: translateY(-10px); }

            100% { transform: translateY(0px); }

        }

        

        h2 {

            color: white;

            margin-bottom: 1.8rem;

            font-weight: 600;

            font-size: 1.8rem;

            text-shadow: 0 2px 4px rgba(0,0,0,0.3);

            letter-spacing: 0.5px;

            display: flex;

            align-items: center;

            justify-content: center;

            gap: 10px;

        }

        

        .trash-icon {

            font-size: 1.5rem;

            animation: shake 0.5s ease-in-out infinite alternate;

            color: var(--danger);

        }

        

        @keyframes shake {

            0% { transform: rotate(-5deg); }

            100% { transform: rotate(5deg); }

        }

        

        .film-details {

            background: rgba(255, 255, 255, 0.2);

            padding: 1.5rem;

            border-radius: 15px;

            margin-bottom: 2rem;

            text-align: left;

            color: white;

            border-left: 4px solid var(--primary-light);

            transition: transform 0.3s ease;

        }

        

        .film-details:hover {

            transform: scale(1.02);

        }

        

        .film-details p {

            margin: 0.7rem 0;

            font-size: 1rem;

            line-height: 1.6;

        }

        

        .film-details strong {

            color: var(--primary-light);

            font-weight: 500;

            display: inline-block;

            min-width: 120px;

        }

        

        .btn-group {

            display: flex;

            gap: 1rem;

            justify-content: center;

        }

        

        .btn {

            border: none;

            padding: 0.8rem 1.8rem;

            border-radius: 50px;

            font-size: 1rem;

            font-weight: 500;

            cursor: pointer;

            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);

            flex: 1;

            display: flex;

            align-items: center;

            justify-content: center;

            min-width: 120px;

            box-shadow: 0 4px 6px rgba(0,0,0,0.1);

        }

        

        .btn-delete {

            background: var(--danger);

            color: white;

            gap: 8px;

        }

        

        .btn-delete:hover {

            background: var(--danger-dark);

            transform: translateY(-2px);

            box-shadow: 0 6px 12px rgba(229, 57, 53, 0.3);

        }

        

        .btn-cancel {

            background: rgba(255, 255, 255, 0.2);

            color: white;

            border: 1px solid rgba(255, 255, 255, 0.3);

            text-decoration: none;

        }

        

        .btn-cancel:hover {

            background: rgba(255, 255, 255, 0.3);

            transform: translateY(-2px);

        }

        

        .warning-message {

            background: rgba(229, 57, 53, 0.2);

            padding: 12px;

            border-radius: 8px;

            margin-bottom: 1.5rem;

            display: flex;

            align-items: center;

            justify-content: center;

            gap: 8px;

            border: 1px solid rgba(229, 57, 53, 0.4);

            animation: pulse 2s infinite;

        }

        

        @keyframes pulse {

            0% { opacity: 0.8; }

            50% { opacity: 1; }

            100% { opacity: 0.8; }

        }

        

        .film-poster {

            width: 100%;

            max-height: 200px;

            object-fit: cover;

            border-radius: 10px;

            margin-bottom: 1.5rem;

            box-shadow: 0 4px 15px rgba(0,0,0,0.2);

            transition: transform 0.3s ease;

        }

        

        .film-poster:hover {

            transform: scale(1.03);

        }

    </style>

</head>

<body>

    <div class="delete-box">

        <h2>

            <i class="fas fa-trash-alt trash-icon"></i>

            Confirmer la suppression

        </h2>

        

        <div class="warning-message">

            <i class="fas fa-exclamation-triangle"></i>

            Cette action est irreversible !

        </div>

        

        

        <div class="film-details">

            <p><strong>Titre :</strong> ${film.titre}</p>

            <p><strong>Genre :</strong> ${film.genre}</p>

            <p><strong>Année :</strong> ${film.anneesortie}</p>

        </div>

        

        <form action="myController" method="post">

            <input type="hidden" name="id" value="${film.idFilmlivre}" />

            <div class="btn-group">

                <button type="submit" name="submitbtn" value="annuler" class="btn btn-delete">

                    <i class="fas fa-trash-alt"></i> Annuler

                </button>
                

                <button type="submit" name="submitbtn" value="validerlasupp" class="btn btn-delete">

                    <i class="fas fa-trash-alt"></i> Supprimer

                </button>

            </div>

        </form>

    </div>

</body>

</html>