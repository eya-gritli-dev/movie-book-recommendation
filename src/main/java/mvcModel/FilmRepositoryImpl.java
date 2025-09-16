package mvcModel;

import entities.Filmslivre;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Implémentation du repository pour les films.
 */
@Stateless
public class FilmRepositoryImpl implements FilmRepository {
    
    @PersistenceContext(unitName = "gererfilmm") // Injection de l'EntityManager
    private EntityManager em;

    private static final Logger logger = Logger.getLogger(FilmRepositoryImpl.class.getName());

    @Override
    public List<Filmslivre> findAll() {
        return em.createQuery("SELECT f FROM Filmslivre f", Filmslivre.class).getResultList();
    }

    @Override
    public Filmslivre findByTitre(String titre) {
        try {
            return em.createQuery("SELECT f FROM Filmslivre f WHERE f.titre = :titre", Filmslivre.class)
                     .setParameter("titre", titre)
                     .getSingleResult();
        } catch (NoResultException e) {
            logger.log(Level.WARNING, "Aucun film trouvé avec le titre spécifié : " + titre);
            return null;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la recherche du film par titre : " + titre, e);
            return null;
        }
    }

    @Override
    public void registerFilm(Filmslivre film) {
        em.persist(film);
    }

    @Override
    public void supprimerFilm(String titre) {
        Filmslivre film = findByTitre(titre);
        if (film != null) {
            em.remove(film);
        }
    }
}