package es.accenture.emisora;

public class Grupo {
	private int id;
	private String nombre;
	private String origen;
	private int creacion;
	private String genero;
	
	public Grupo() {
		// TODO Auto-generated constructor stub
	}
	
	public Grupo(int id, String nombre, String origen, int creacion, String genero) {
		this.id = id;
		this.nombre = nombre;
		this.origen = origen;
		this.creacion = creacion;
		this.genero = genero;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getOrigen() {
		return origen;
	}

	public void setOrigen(String origen) {
		this.origen = origen;
	}

	public int getCreacion() {
		return creacion;
	}

	public void setCreacion(int creacion) {
		this.creacion = creacion;
	}

	public String getGenero() {
		return genero;
	}

	public void setGenero(String genero) {
		this.genero = genero;
	}

	
	
	
}
