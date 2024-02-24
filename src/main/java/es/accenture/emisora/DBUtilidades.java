package es.accenture.emisora;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtilidades {
	private static Connection conexionDB;

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

	public static void cerrarConexionBD() {
		try {
			conexionDB.close();
			conexionDB = null;
		} catch (Exception e) {
			System.out.println("Ha ocurrido un error al cerrar la conexion con la bd");
		}
	}

}
