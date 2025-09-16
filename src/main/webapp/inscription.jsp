<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - CineJoy</title>
    
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
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 450px;
            text-align: center;
            color: var(--dark-color);
        }

        .form-container h2 {
            margin-bottom: 20px;
            font-size: 26px;
            color: var(--primary-color);
        }

        .admin-icon {
            font-size: 50px;
            color: #7873f5;
            margin-bottom: 20px;
        }

        .form-control:focus {
            border-color: var(--accent-color);
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
    }

    .btn-shiny:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 25px rgba(0, 0, 0, 0.2);
    }

    .btn-shiny:active {
      transform: translateY(1px);
    }

    .btn-shiny::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 70%;
      height: 100%;
      background: linear-gradient(
        120deg,
        transparent,
        rgba(255, 255, 255, 0.6),
        transparent
      );
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
   .form-label{
    color :#8b025e
    }
    </style>
</head>
<body>

<div class="form-container">
    <i class="fas fa-user-shield admin-icon"></i>
    <h2>🌟 Inscription - CineJoy 🌟</h2>

    <form action="myController" method="POST" class="text-start">

        <div class="mb-3">
            <input type="text" name="nom" class="form-control" placeholder="Nom" required>
        </div>

        <div class="mb-3">
            <input type="text" name="prenom" class="form-control" placeholder="Prénom" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Date de naissance :</label>
            <input type="date" name="date" class="form-control" required>
        </div>

        <div class="mb-3">
            <input type="email" name="email" class="form-control" placeholder="exemple@email.com" required>
        </div>

        <div class="mb-4">
            <input type="password" name="motdepasse" class="form-control" placeholder="Mot de passe" required>
        </div>
        <button type="submit" name="submitbtn" value="inscrire" class="btn btn-submit btn-shiny rainbow-btn">
    		S'inscrire
		</button>

    </form>
</div>
a
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>