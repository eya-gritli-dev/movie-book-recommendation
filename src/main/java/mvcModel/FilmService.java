package mvcModel;

import entities.Filmslivre;
import jakarta.ejb.LocalBean;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@Stateless
@LocalBean
public class FilmService {

    @PersistenceContext(unitName = "gererfilmm")
    private EntityManager em;

    private static final Logger logger = Logger.getLogger(FilmService.class.getName());

    // Méthode pour enregistrer un film et un livre
    public void registerFilm(Filmslivre filmlivr) {
        try {
            if (filmlivr == null) {
                throw new IllegalArgumentException("L'objet Filmslivre est null");
            }
            em.persist(filmlivr);
            em.flush();
            logger.info("✅ Film enregistré avec succès !");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de l'enregistrement du film.", e);
        }
    }

    // Méthode pour supprimer un film
    public boolean supprimerFilm(String titre, String genre, Date anneeSortie) {
        try {
            TypedQuery<Filmslivre> query = em.createQuery(
                    "SELECT f FROM Filmslivre f WHERE f.titre = :titre AND f.genre = :genre AND f.anneesortie = :anneeSortie", 
                    Filmslivre.class);
            query.setParameter("titre", titre);
            query.setParameter("genre", genre);
            query.setParameter("anneeSortie", anneeSortie);
            Filmslivre film = query.getSingleResult();

            if (film != null) {
                em.remove(film);
                logger.info("✅ Film supprimé avec succès !");
                return true;
            }
        } catch (NoResultException e) {
            logger.log(Level.WARNING, "Aucun film trouvé avec les critères spécifiés.");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la suppression du film.", e);
        }
        return false;
    }

    public List<Filmslivre> rechercherParTitreOuGenre(String titre, String genre) {
        try {
            String jpql = "SELECT f FROM Filmslivre f WHERE 1=1";
            if (titre != null && !titre.isEmpty()) {
                jpql += " AND LOWER(f.titre) LIKE :titre";
            }
            if (genre != null && !genre.isEmpty()) {
                jpql += " AND f.genre = :genre";
            }

            TypedQuery<Filmslivre> query = em.createQuery(jpql, Filmslivre.class);
            if (titre != null && !titre.isEmpty()) {
                query.setParameter("titre", "%" + titre.toLowerCase() + "%");
            }
            if (genre != null && !genre.isEmpty()) {
                query.setParameter("genre", genre);
            }

            return query.getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche de films : " + e.getMessage());
            return new ArrayList<>();
        }
    }

    // Méthode pour récupérer tous les films
    public List<Filmslivre> getAllFilms() {
        try {
            List<Filmslivre> films = em.createQuery("SELECT f FROM Filmslivre f", Filmslivre.class).getResultList();
            return films;
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des films : " + e.getMessage());
            return null;
        }
    }




    // Méthode pour rechercher un film par titre
    public Filmslivre findFilmByTitle(String titre) {
        try {
            TypedQuery<Filmslivre> query = em.createQuery(
                    "SELECT f FROM Filmslivre f WHERE f.titre = :titre", Filmslivre.class);
            query.setParameter("titre", titre);
            return query.getSingleResult();
        } catch (NoResultException e) {
            logger.log(Level.WARNING, "Aucun film trouvé avec le titre spécifié.");
            return null;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la recherche du film.", e);
            return null;
        }
    }
    public boolean supprimerFilm(int id) {

        try {

            TypedQuery<Filmslivre> query = em.createQuery(

                    "SELECT f FROM Filmslivre f WHERE f.idFilmlivre = :id ",

                    Filmslivre.class);

            query.setParameter("id", id);

            Filmslivre film = query.getSingleResult();



            if (film != null) {

                em.remove(film);

                logger.info("✅ Film supprimé avec succès !");

                return true;

            }

        } catch (NoResultException e) {

            logger.log(Level.WARNING, "Aucun film trouvé avec les critères spécifiés.");

        } catch (Exception e) {

            logger.log(Level.SEVERE, "Erreur lors de la suppression du film.", e);

        }

        return false;

    }

    public void updatefilm(Filmslivre film) {

        if (film != null) {

            em.merge(film); // Met à jour l'entité dans la base

        }

    }


    public Filmslivre getFilmById(int id) {
        try {
            TypedQuery<Filmslivre> query = em.createQuery(
                    "SELECT f FROM Filmslivre f WHERE f.idFilmlivre = :id", Filmslivre.class);
            query.setParameter("id", id);  
            return query.getSingleResult();
        } catch (NoResultException e) {
            logger.log(Level.WARNING, "Aucun film trouvé avec l'id spécifié.");
            return null;
        }
    }

        }
