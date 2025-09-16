package mvcController;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Period;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import mvcModel.FilmService;
import mvcModel.RecommandationService;

import java.time.LocalDate;

import entities.Filmslivre;
import entities.Utilisateur;
import jakarta.inject.Inject;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mvcModel.UserService;
import java.util.List;

/**
 * Servlet implementation class myController
 */
@WebServlet("/myController")
public class myController extends HttpServlet {
	private static final long serialVersionUID = 1L;
		@Inject
	    private UserService userService;
	    @Inject
	    private FilmService filmService;
	    @Inject
	    private RecommandationService recommandationService;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public myController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String bouton = request.getParameter("submitbtn");
		if(bouton!=null && bouton.equals("detailFilm"))
		{
			String p1 = request.getParameter("idFilm");
    	    int id = Integer.parseInt(p1);
    	    Filmslivre film = filmService.getFilmById(id);
	        request.setAttribute("film", film);
	        request.getRequestDispatcher("detailFilm.jsp").forward(request, response);

    	    

		}
		else 
			if(bouton!=null && bouton.equals("rechercher"))
			{   request.setCharacterEncoding("UTF-8");
    	    List<Filmslivre> films;
	        films = filmService.getAllFilms();
    	    String recherche = request.getParameter("query");
    	    String genre = request.getParameter("genre");
    	    if ((recherche != null && !recherche.isEmpty()) || (genre != null && !genre.isEmpty())) {
    	        films = filmService.rechercherParTitreOuGenre(recherche, genre);
    	    } 
    	    request.setAttribute("films", films);
    	    request.getRequestDispatcher("accueil.jsp").forward(request, response);
    	}
			
			// Fixed controller authentication code segment
			else if (bouton != null && bouton.equals("Se Connecter")) {
			    String email = request.getParameter("mail1");
			    String password = request.getParameter("mdp1");
			    HttpSession session = request.getSession();

			    // Vérifier si c'est l'admin
			    if (email.equals("admincinejoy@gmail.com") && password.equals("admin1234eyayassminenour")) {
			        session.setAttribute("role", "admin");
			        
			        // Récupérer la liste des films pour la page consulter.jsp
			        List<Filmslivre> allFilms = filmService.getAllFilms(); 
			        request.setAttribute("films", allFilms);
			        
			        request.getRequestDispatcher("consulter.jsp").forward(request, response);
			    } else {
			        // Vérifier dans la base de données pour les utilisateurs normaux
			        Utilisateur existingUser = userService.findUserByEmailAndPassword(email, password);

			        if (existingUser != null) {
			            session.setAttribute("role", "user");
			            session.setAttribute("utilisateur", existingUser);
			            List<Filmslivre> films = filmService.getAllFilms();
					    request.setAttribute("films", films);
					    request.getRequestDispatcher("accueil.jsp").forward(request, response);
			        } 
			       
					else {
			            request.setAttribute("message", "Identifiants incorrects !");
			            request.getRequestDispatcher("authentification.jsp").forward(request, response);
			        }
			    }
			}
			else if (bouton != null && bouton.equals("deconnexion")) {
			    HttpSession session = request.getSession(false); // Ne crée pas une nouvelle session
			    if (session != null) {
			        session.invalidate();
			    }
			    response.sendRedirect("authentification.jsp");
			}
			else if (bouton!=null &&bouton.equals("modifier")) {
				 HttpSession session = request.getSession(false);
				 String role = (String) session.getAttribute("role");
				  if (role != null && role.equals("admin")) {
					

			    String id1 = request.getParameter("idFilm");

			    if (id1 != null && !id1.isEmpty()) {

			        int id = Integer.parseInt(id1);

			        
			        Filmslivre s = filmService.getFilmById(id);

			        request.setAttribute("film", s);
				    request.getRequestDispatcher("modifier.jsp").forward(request, response);


			        
			}
			    }else {
				    // Redirection avec message d'erreur
				    request.setAttribute("message", "Accès réservé à l'administrateur");
				    request.getRequestDispatcher("authentification.jsp").forward(request, response);
				}
				  }

			else if(bouton!=null && bouton.equals("validerlamodif"))

			{

		        int id = Integer.parseInt(request.getParameter("id_filmlivre"));

		        String nouvtitre = request.getParameter("titre");

		        String nouvgenre = request.getParameter("genre");

		        String nouvanneesortie = request.getParameter("anneesortie");

		        String nouvacteurs = request.getParameter("acteurs");

		        String nouvdescriptionfilm = request.getParameter("descriptionlfilm");

		        String nouvlienfilm = request.getParameter("lienfilm");

		        String nouvimagefilm = request.getParameter("imagefilm");

		        String nouvdispolivre = request.getParameter("dispolivre");

		        String nouvtitrelivre = request.getParameter("titrelivre");

		        String nouvdescriptionlivre = request.getParameter("descriptionlivre");

		        String nouvauteurlivre = request.getParameter("auteurlivre");

		        String nouvlienlivre = request.getParameter("lienlivre");

		        String nouvauteurfilm = request.getParameter("auteurfilm");



		        Filmslivre f = filmService.getFilmById(id);

		        if (f != null) {

		            f.setTitre(nouvtitre);

		            f.setGenre(nouvgenre);

		            if (nouvanneesortie != null && !nouvanneesortie.isEmpty()) {

		                f.setAnneesortie(LocalDate.parse(nouvanneesortie)); // format yyyy-MM-dd

		            }

		            f.setActeurs(nouvacteurs);

		            f.setDescriptionlfilm(nouvdescriptionfilm);

		            f.setLienfilm(nouvlienfilm);

		            f.setImagefilm(nouvimagefilm);

		            f.setDispolivre(nouvdispolivre);

		            f.setTitrelivre(nouvtitrelivre);

		            f.setDescriptionlivre(nouvdescriptionlivre);

		            f.setAuteurlivre(nouvauteurlivre);

		            f.setLienlivre(nouvlienlivre);

		            f.setAuteurfilm(nouvauteurfilm);



		            filmService.updatefilm(f); 

		            List<Filmslivre> films = filmService.getAllFilms();

		            request.setAttribute("films", films);

		            request.getRequestDispatcher("consulter.jsp").forward(request, response);


			}

			}

			else if (bouton!=null &&bouton.equals("supprimer")){
				 HttpSession session = request.getSession(false);
				 String role = (String) session.getAttribute("role");
				  if (role != null && role.equals("admin")) {
					

			    String id1 = request.getParameter("idFilm");

			    if (id1 != null && !id1.isEmpty()) {

			        int id = Integer.parseInt(id1);

			        Filmslivre s = filmService.getFilmById(id);

			        request.setAttribute("film", s);

			        request.getRequestDispatcher("supprimer.jsp").forward(request, response);

			}}else {
			    // Redirection avec message d'erreur
			    request.setAttribute("message", "Accès réservé à l'administrateur");
			    request.getRequestDispatcher("authentification.jsp").forward(request, response);
			}

			}

			else if(bouton!=null && bouton.equals("validerlasupp")) {

		    	    int id = Integer.parseInt(request.getParameter("id"));

		    	    filmService.supprimerFilm(id);  

		            List<Filmslivre> films = filmService.getAllFilms();

		            request.setAttribute("films", films);

		            request.getRequestDispatcher("consulter.jsp").forward(request, response);

		    	}

			else if (bouton != null && bouton.equals("supdufavoris")) {
			    int idFilm = Integer.parseInt(request.getParameter("idFilm"));
			    HttpSession session = request.getSession(false); // Ne crée pas une nouvelle session
			    Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

			    if (user != null) {
			        int idUser = user.getIduser();
			        recommandationService.supprimerFavori(idUser, idFilm); // <-- Changement ici
			        session.setAttribute("message", "Film supprimé des favoris avec succès");
			        request.getRequestDispatcher("accueil.jsp").forward(request, response);

			    } else {
			        session.setAttribute("message", "Veuillez vous connecter pour supprimer des favoris");
			        request.getRequestDispatcher("authentification.jsp").forward(request, response);
			    }
			}

			

				
				else
					if(bouton!=null && bouton.equals("inscrire"))
					{
						
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
				        response.sendRedirect("authentification.jsp");
				    }
					else
						if(bouton!=null && bouton.equals("Ajouter")) {
							 HttpSession session = request.getSession(false);
							 String role = (String) session.getAttribute("role");
							  if (role != null && role.equals("admin")) {
								
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

				            List<Filmslivre> films = filmService.getAllFilms();

				            request.setAttribute("films", films);

				            request.getRequestDispatcher("consulter.jsp").forward(request, response);

							  } else {
							    // Redirection avec message d'erreur
							    request.setAttribute("message", "Accès réservé à l'administrateur");
							    request.getRequestDispatcher("authentification.jsp").forward(request, response);
							}
					    }
					   
						else if(bouton!=null && bouton.equals("ajouterFavori")) {
						    int idFilm = Integer.parseInt(request.getParameter("idFilm"));
						    HttpSession session = request.getSession(false); // Ne crée pas une nouvelle session
						    Utilisateur user = (Utilisateur) session.getAttribute("utilisateur"); // Changé "user" à "utilisateur"

						    if (user != null) {
						        int idUser = user.getIduser();
						        recommandationService.ajouterFavori(idUser, idFilm);
						        // Optionnellement, ajouter un message de succès
						        session.setAttribute("message", "Film ajouté aux favoris avec succès");
						        response.sendRedirect("myController"); // Redirection vers le contrôleur
						    } else {
						        // Redirection vers la page de connexion si l'utilisateur n'est pas connecté
						        session.setAttribute("message", "Veuillez vous connecter pour ajouter aux favoris");
						        request.getRequestDispatcher("authentification.jsp").forward(request, response);
						    }
						}
						else if (bouton != null && bouton.equals("favoris")) {
						    HttpSession session = request.getSession();
						    Utilisateur user = (Utilisateur) session.getAttribute("utilisateur"); // Changé "user" à "utilisateur"

						    if (user != null) {
						        int idUser = user.getIduser();
						        System.out.println("ID utilisateur : " + idUser);

						        List<Filmslivre> listeFavoris = recommandationService.recupererFavoris(idUser);
						        System.out.println("Favoris récupérés : " + listeFavoris.size());
						        request.setAttribute("favoris", listeFavoris);

						        RequestDispatcher dispatcher = request.getRequestDispatcher("favoris.jsp");
						        dispatcher.forward(request, response);
						    } else {
						        session.setAttribute("message", "Veuillez vous connecter pour voir vos favoris");
						        request.getRequestDispatcher("authentification.jsp").forward(request, response);
						    }
						}
						else if (bouton != null && bouton.equals("annuler")) {
						    List<Filmslivre> films = filmService.getAllFilms();
						    request.setAttribute("films", films);
						    request.getRequestDispatcher("consulter.jsp").forward(request, response);
						}

						else if (bouton != null && bouton.equals("RetourFilm")) {
							 List<Filmslivre> films = filmService.getAllFilms();
							    request.setAttribute("films", films);
							    request.getRequestDispatcher("accueil.jsp").forward(request, response);
						}
		
					 else {
					    List<Filmslivre> films = filmService.getAllFilms();
					    request.setAttribute("films", films);
					    request.getRequestDispatcher("accueil.jsp").forward(request, response);
					}


	}		
	
	private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        response.getWriter().println("<html><body><h3>" + message + "</h3></body></html>");
    }

    private boolean isValidEmail(String email) {
        return email != null ;
    }

    private boolean isValidName(String name) {
        return name != null && !name.trim().isEmpty() ;
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
               password.matches(".*[A-Z].*") && password.matches(".*\\d.*"); }
    

   


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
