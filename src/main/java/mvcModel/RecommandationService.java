package mvcModel;

import entities.Recommandation;
import entities.Utilisateur;

import java.util.List;

import entities.Filmslivre;


import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.Transactional;

@Stateless
public class RecommandationService {
    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void ajouterFavori(int idUser, int idFilmLivre) {
    	try {
        Utilisateur user = em.find(Utilisateur.class, idUser);
        Filmslivre film = em.find(Filmslivre.class, idFilmLivre);

        Recommandation reco = new Recommandation();
        reco.setFilmslivre(film);       
        reco.setUtilisateur(user);      
        reco.setFavoris("oui");
        reco.setNote(0); // Ajouter cette ligne pour définir une note par défaut
        // Si vous avez aussi un champ commentaire qui ne peut pas être null
        reco.setCommentaire("");

        em.persist(reco);
        if (reco.getCommentaire() == null) {
            reco.setCommentaire("");
        }
        
        // Debug pour vérifier les valeurs avant insertion
        System.out.println("Ajout recommandation - Film: "  + 
                          ", User: " + user.getIduser() + 
                          ", Note: " + reco.getNote());
        
        em.persist(reco);
        em.flush(); // Forcer l'exécution immédiate
        
        System.out.println("Recommandation enregistrée avec succès");
    } catch (Exception e) {
        System.err.println("Erreur lors de l'ajout du favori: " + e.getMessage());
        e.printStackTrace();
        throw e; // Relancer l'exception pour la gestion d'erreur plus haut
    }
}
    public List<Filmslivre> recupererFavoris(int idUser) {
        TypedQuery<Filmslivre> query = em.createQuery(
            "SELECT r.filmslivre FROM Recommandation r WHERE r.utilisateur.iduser = :id AND r.favoris = 'oui'",
            Filmslivre.class
        );
        query.setParameter("id", idUser);
        return query.getResultList();
    }
    public void supprimerFavori(int idUser, int idFilmLivre) {
        try {
            // Simplifions au maximum la requête JPQL
            		TypedQuery<Recommandation> query = em.createQuery(
            			    "SELECT r FROM Recommandation r WHERE r.utilisateur.iduser = :idUser AND r.filmslivre.idFilmlivre = :idFilmLivre",
            			    Recommandation.class);

            query.setParameter("idUser", idUser);
            query.setParameter("idFilmLivre", idFilmLivre);
            
            List<Recommandation> resultats = query.getResultList();
            
            for (Recommandation recommandation : resultats) {
                em.remove(recommandation);
            }
            
            
        } catch (Exception e) {
            System.out.println("Erreur détaillée: " + e.getMessage());
            e.printStackTrace();
        }
    }
    }