package entities;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * The persistent class for the utilisateur database table.
 * 
 */
@Entity
@Table(name = "utilisateur")
@NamedQuery(name = "Utilisateur.findAll", query = "SELECT u FROM Utilisateur u")
public class Utilisateur implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private int iduser;

	private String adressemail;

	@Temporal(TemporalType.DATE)
	private Date datedenaissance;

	private String motdepasse;

	private String nom;

	private String prenom;

	// bi-directional many-to-one association to Recommandation
	@OneToMany(mappedBy = "utilisateur")
	private List<Recommandation> recommandations;

	public Utilisateur() {
	}

	public int getIduser() {
		return this.iduser;
	}

	public void setIduser(int iduser) {
		this.iduser = iduser;
	}

	public String getAdressemail() {
		return this.adressemail;
	}

	public void setAdressemail(String adressemail) {
		this.adressemail = adressemail;
	}

	public Date getDatedenaissance() {
		return this.datedenaissance;
	}

	public void setDatedenaissance(Date datedenaissance) {
		this.datedenaissance = datedenaissance;
	}

	public String getMotdepasse() {
		return this.motdepasse;
	}

	public void setMotdepasse(String motdepasse) {
		this.motdepasse = motdepasse;
	}

	public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPrenom() {
		return this.prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public List<Recommandation> getRecommandations() {
		return this.recommandations;
	}

	public void setRecommandations(List<Recommandation> recommandations) {
		this.recommandations = recommandations;
	}

	public Recommandation addRecommandation(Recommandation recommandation) {
		getRecommandations().add(recommandation);
		recommandation.setUtilisateur(this);

		return recommandation;
	}

	public Recommandation removeRecommandation(Recommandation recommandation) {
		getRecommandations().remove(recommandation);
		recommandation.setUtilisateur(null);

		return recommandation;
	}

}