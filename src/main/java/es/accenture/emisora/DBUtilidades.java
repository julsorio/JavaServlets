package es.accenture.emisora;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author Andrea Ravagli
 * 
 * clase encargada de gestionar la conexion con la base de datos
 */
public class DBUtilidades {
	private static Connection conexionDB;

	/**
	 * metodo encargado de abrir una conexion con la base de datos
	 * si la conexion es null, abre una nueva de lo contrario retorna una existente
	 * @return la conexion con la base de datos
	 */
	public static Connection abrirConexionBD() {
		try {
			if (conexionDB == null || conexionDB.isClosed()) {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conexionDB = DriverManager.getConnection("jdbc:mysql://localhost:3306/musicadb2", "cravagli", "52973571");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		return conexionDB;
	}

	/**
	 * metodo encargado de cerrar la conexion con la base de datos
	 */
	public static void cerrarConexionBD() {
		try {
			conexionDB.close();
			conexionDB = null;
		} catch (Exception e) {
			System.out.println("Ha ocurrido un error al cerrar la conexion con la bd");
		}
	}

}
