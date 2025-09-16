package mvcController;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Period;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import mvcModel.FilmService;
import java.time.LocalDate;

import entities.Filmslivre;
import entities.Utilisateur;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mvcModel.UserService;
import java.util.List;

@WebServlet("/controller")
public class controller extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Inject
    private UserService userService;
    @Inject
    private FilmService filmService;
   

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$");
    private static final Pattern NAME_PATTERN = Pattern.compile("^[a-zA-ZÀ-ÿ' -]+$");

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        try {
            String bouton = request.getParameter("submitbtn");
            String bouton2 = request.getParameter("btn1");
            String bt1 = request.getParameter("b14");
            String bouton3 = request.getParameter("btn3");

            if ("S'inscrire".equals(bouton)) {
                handleRegistration(request, response);
            } else if ("Se Connecter".equals(bouton2)) {
                handleLogin(request, response);
            } else if ("Ajouter".equals(bt1)) {
                handleAddFilm(request, response);
            } else if ("supprimer".equals(bouton3)) {
                handleDeleteFilm(request, response);
            }
        } catch (Exception e) {
            sendErrorResponse(response, "Une erreur est survenue : " + e.getMessage());
        }
    }
    	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	    request.setCharacterEncoding("UTF-8");
    	    List<Filmslivre> films;
	        films = filmService.getAllFilms();
    	    String recherche = request.getParameter("recherche");
    	    String genre = request.getParameter("genre");
    	    if ((recherche != null && !recherche.isEmpty()) || (genre != null && !genre.isEmpty())) {
    	        films = filmService.rechercherParTitreOuGenre(recherche, genre);
    	    } 
    	    request.setAttribute("films", films);
    	    request.getRequestDispatcher("accueil.jsp").forward(request, response);
    	}
    	private void handleFilmDetails(HttpServletRequest request, HttpServletResponse response, int filmId) throws ServletException, IOException {
    	    String idParam = request.getParameter("id");
    	    int id = Integer.parseInt(idParam);
    	    Filmslivre film = filmService.getFilmById(id);
    	    request.setAttribute("film", film);

    	    
    	    if (film != null) {
    	        // Passer l'objet film à la JSP pour l'affichage
    	        request.setAttribute("film", film);
    	        request.getRequestDispatcher("detailFilm.jsp").forward(request, response);
    	    } else {
    	        // Film introuvable, redirection vers la page d'accueil ou affichage d'un message d'erreur
    	        request.setAttribute("message", "Film introuvable");
    	        request.getRequestDispatcher("accueil.jsp").forward(request, response);
    	    }
    	 	
    	}
    private void handleAddFilm(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String titreFilm = request.getParameter("titre_film");
        String genreFilm = request.getParameter("genre_film");
        String anneeSortie = request.getParameter("annee_sortie");
        String acteursFilm = request.getParameter("acteurs_film");
        String auteurFilm = request.getParameter("auteur_film");
        String descriptionFilm = request.getParameter("description_film");
        String lienFilm = request.getParameter("lien_film");
        String imageFilm = request.getParameter("image_film");

        // Récupérer les informations sur le livre
        String disponibiliteLivre = request.getParameter("disponibilite_livre");
        String titreLivre = request.getParameter("nom_livre");
        String auteurLivre = request.getParameter("auteur_livre");
        String descriptionLivre = request.getParameter("description_livre");
        String lienLivre = request.getParameter("lien_livre");

        // Créer un objet Filmslivre avec les données reçues
        Filmslivre filmlivr = new Filmslivre();
        filmlivr.setTitre(titreFilm);
        filmlivr.setGenre(genreFilm);
        filmlivr.setActeurs(acteursFilm);
        filmlivr.setAuteurfilm(auteurFilm);
        filmlivr.setDescriptionlfilm(descriptionFilm);
        filmlivr.setLienfilm(lienFilm);
        filmlivr.setImagefilm(imageFilm);
        filmlivr.setDispolivre(disponibiliteLivre);
        filmlivr.setTitrelivre(titreLivre);
        filmlivr.setAuteurlivre(auteurLivre);
        filmlivr.setDescriptionlivre(descriptionLivre);
        filmlivr.setLienlivre(lienLivre);

        // Gestion de la date de sortie
        if (anneeSortie != null && !anneeSortie.isEmpty()) {
        	filmlivr.setAnneesortie(LocalDate.parse(anneeSortie));
        	} else {
            filmlivr.setAnneesortie(null); // Si la date est vide, on met à null
        }

        // Enregistrer le film et le livre
        filmService.registerFilm(filmlivr);
        response.sendRedirect("./ajouterfilm.html");
    }
   

    private void handleDeleteFilm(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String titre = request.getParameter("titre");
        String genre = request.getParameter("genre");
        String anneeSortieStr = request.getParameter("anneeSortie");

        LocalDate anneeSortieLocalDate = LocalDate.parse(anneeSortieStr);
        Date anneeSortieDate = Date.valueOf(anneeSortieLocalDate);

        boolean deleted = filmService.supprimerFilm(titre, genre, anneeSortieDate);

        if (deleted) {
            response.getWriter().write("<script>alert('Film supprimé avec succès'); window.location='films.jsp';</script>");
        } else {
            response.getWriter().write("<script>alert('Film introuvable ou informations incorrectes'); window.location='supprimer.html';</script>");
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String dateNaissanceStr = request.getParameter("date");
        String password = request.getParameter("motdepasse");

        if (!isValidName(nom) || !isValidName(prenom) || !isValidEmail(email) || !isValidDate(dateNaissanceStr) || !isValidPassword(password)) {
            sendErrorResponse(response, "Données invalides, veuillez vérifier les champs.");
            return;
        }

        Utilisateur user = new Utilisateur();
        user.setNom(nom);
        user.setPrenom(prenom);
        user.setAdressemail(email);
        user.setMotdepasse(password);
        user.setDatedenaissance(Date.valueOf(LocalDate.parse(dateNaissanceStr)));

        userService.registerUser(user);
        response.sendRedirect("authentification.html");
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("mail1");
        String password = request.getParameter("mdp1");

        // Valider l'utilisateur
        Utilisateur existingUser = userService.findUserByEmailAndPassword(email, password);

        if (existingUser != null) {
    
           
               request.getRequestDispatcher("accueil.jsp").forward(request, response);

        } else {
            // En cas d'identifiants incorrects
            request.setAttribute("message", "Identifiants incorrects !");
            request.getRequestDispatcher("authentification.html").forward(request, response);
        }
    }


    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        response.getWriter().println("<html><body><h3>" + message + "</h3></body></html>");
    }

    private boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    private boolean isValidName(String name) {
        return name != null && !name.trim().isEmpty() && NAME_PATTERN.matcher(name).matches();
    }

    private boolean isValidDate(String dateStr) {
        try {
            LocalDate birthDate = LocalDate.parse(dateStr);
            return Period.between(birthDate, LocalDate.now()).getYears() >= 13;
        } catch (Exception e) {
            return false;
        }
    }

    private boolean isValidPassword(String password) {
        return password != null && password.length() >= 8 && 
               password.matches(".*[A-Z].*") && password.matches(".*\\d.*");
    }

   }
