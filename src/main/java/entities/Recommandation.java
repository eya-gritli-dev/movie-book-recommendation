package entities;

import java.io.Serializable;
import jakarta.persistence.*;


/**
 * The persistent class for the recommandation database table.
 * 
 */
@Entity
@NamedQuery(name="Recommandation.findAll", query="SELECT r FROM Recommandation r")
public class Recommandation implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private int idrecomand;

	private String commentaire;

	private String favoris;

	private int note;

	//bi-directional many-to-one association to Utilisateur
	@ManyToOne
	@JoinColumn(name="iduser")
	private Utilisateur utilisateur;

	//bi-directional many-to-one association to Filmslivre
	@ManyToOne
	@JoinColumn(name="id_filmlivre")
	private Filmslivre filmslivre;

	public Recommandation() {
	}

	public int getIdrecomand() {
		return this.idrecomand;
	}

	public void setIdrecomand(int idrecomand) {
		this.idrecomand = idrecomand;
	}

	public String getCommentaire() {
		return this.commentaire;
	}

	public void setCommentaire(String commentaire) {
		this.commentaire = commentaire;
	}

	public String getFavoris() {
		return this.favoris;
	}

	public void setFavoris(String favoris) {
		this.favoris = favoris;
	}

	public int getNote() {
		return this.note;
	}

	public void setNote(int note) {
		this.note = note;
	}

	public Utilisateur getUtilisateur() {
		return this.utilisateur;
	}

	public void setUtilisateur(Utilisateur utilisateur) {
		this.utilisateur = utilisateur;
	}

	public Filmslivre getFilmslivre() {
		return this.filmslivre;
	}

	public void setFilmslivre(Filmslivre filmslivre) {
		this.filmslivre = filmslivre;
	}

}