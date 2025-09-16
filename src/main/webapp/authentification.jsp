<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - CineJoy</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background: linear-gradient(#9b0487, #8360c3);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }

        .form-container {
            background: white;
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0px 12px 30px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 550px;
            text-align: center;
            color: #333;
        }

        h2 {
            font-size: 2.8rem;
            margin-bottom: 15px;
            background: linear-gradient(to right, #ff6ec4, #7873f5, #5ee7df);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 800;
            animation: pulseGlow 2s infinite;
        }

        .sub-title {
            font-style: italic;
            font-size: 1.2rem;
            color: #5e2750;
            margin-bottom: 30px;
        }

        .admin-icon {
            font-size: 60px;
            color: #7873f5;
            margin-bottom: 10px;
        }

        .form-control:focus {
            border-color: #ee6c4d;
            box-shadow: 0 0 0 0.25rem rgba(238, 108, 77, 0.25);
        }

        .btn-shiny {
            padding: 16px 32px;
            font-size: 1.4rem;
            font-weight: 700;
            color: white;
            text-align: center;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            background-size: 200% 200%;
            animation: gradientMove 4s ease infinite;
            margin-top: 25px;
        }

        .btn-shiny:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.2);
        }

        .btn-shiny::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 70%;
            height: 100%;
            background: linear-gradient(120deg, transparent, rgba(255, 255, 255, 0.6), transparent);
            transform: skewX(-25deg);
            transition: 0.5s;
        }

        .btn-shiny:hover::before {
            left: 150%;
        }

        .rainbow-btn {
            background: linear-gradient(270deg, #ff6ec4, #7873f5, #5ee7df);
            background-size: 200% 200%;
        }

        @keyframes gradientMove {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        @keyframes pulseGlow {
            0%, 100% { text-shadow: 0 0 10px rgba(255,255,255,0.5); }
            50% { text-shadow: 0 0 20px rgba(255,255,255,0.9); }
        }

        .form-label {
            color: #8b025e;
        }

        .btn-login {
            background: transparent;
            border: none;
            color: white;
            font-weight: bold;
        }

        .btn-login:focus {
            outline: none;
            box-shadow: none;
        }

        .error-message {
            color: red;
            font-weight: bold;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <i class="fas fa-user-shield admin-icon"></i>
        <h2>Connexion à CineJoy</h2>
        <div class="sub-title">
            Connectez-vous pour explorer les adaptations littéraires les plus vibrantes,<br>
            et plongez dans un univers cinématographique magique...
        </div>

        <% if (request.getAttribute("message") != null) { %>
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> 
                <%= request.getAttribute("message") %>
            </div>
        <% } %>

        <form action="myController" method="POST">
            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                    <input type="email" class="form-control" name="mail1" placeholder="Adresse Gmail" required>
                </div>
            </div>
            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" class="form-control" name="mdp1" placeholder="Mot de passe" required>
                </div>
            </div>

            <div class="btn-shiny rainbow-btn">
                <button type="submit" class="btn btn-login" name="submitbtn" value="Se Connecter">
                    <i class="fas fa-sign-in-alt"></i> Se Connecter
                </button>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
