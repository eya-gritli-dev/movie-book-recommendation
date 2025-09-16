package mvcModel;

import entities.Utilisateur;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Stateless
public class UserService {
    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void registerUser(Utilisateur user) {
        System.out.println("🔹 Tentative d'enregistrement de : " + user.getAdressemail());
        em.persist(user);
        System.out.println("✅ Utilisateur enregistré avec succès !");
    }
    public Utilisateur findUserByEmailAndPassword(String email, String password) {
        try {
            return em.createQuery(
                "SELECT u FROM Utilisateur u WHERE u.adressemail = :email AND u.motdepasse = :password", Utilisateur.class)
                .setParameter("email", email)
                .setParameter("password", password) // Attention : mot de passe en clair
                
                .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }


    
}
