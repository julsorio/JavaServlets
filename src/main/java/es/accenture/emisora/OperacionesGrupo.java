package es.accenture.emisora;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OperacionesGrupo {

	public static List<Grupo> obtenerListadoGrupo() {
		List<Grupo> lista = new ArrayList<>();

		Connection conexion = DBUtilidades.abrirConexionBD();

		String query = "SELECT grupoId,nombre,origen,creacion,genero FROM grupos";

		Statement statement = null;
		ResultSet resultSet = null;

		try {
			statement = conexion.createStatement();
			resultSet = statement.executeQuery(query);

			if (resultSet != null) {

				while (resultSet.next()) {
					Grupo grupo = new Grupo();
					grupo.setId(resultSet.getInt("grupoId"));
					grupo.setNombre(resultSet.getString("nombre"));
					grupo.setOrigen(resultSet.getString("origen"));
					grupo.setCreacion(resultSet.getInt("creacion"));
					grupo.setGenero(resultSet.getString("genero"));

					lista.add(grupo);
				}
			}

			resultSet.close();
			statement.close();
		} catch (Exception e) {
			System.out.println("Ha ocurrido un error al ejecutar consulta/obtener resultado");
		}

		DBUtilidades.cerrarConexionBD();

		return lista;
	}

	public static Grupo obtenerDetalleGrupo(String idGrupo) {
		Grupo grupo = new Grupo();
		
		Connection conexion = DBUtilidades.abrirConexionBD();

		String query = "SELECT grupoId,nombre,origen,creacion,genero FROM grupos WHERE grupoId = ?";

		PreparedStatement statement = null;
		ResultSet resultSet = null;

		try {
			statement = conexion.prepareStatement(query);
			statement.setInt(1, Integer.parseInt(idGrupo));
			resultSet = statement.executeQuery();

			if (resultSet != null) {

				while (resultSet.next()) {
					grupo.setId(resultSet.getInt("grupoId"));
					grupo.setNombre(resultSet.getString("nombre"));
					grupo.setOrigen(resultSet.getString("origen"));
					grupo.setCreacion(resultSet.getInt("creacion"));
					grupo.setGenero(resultSet.getString("genero"));
				}
			}

			resultSet.close();
			statement.close();
		} catch (Exception e) {
			System.out.println("Ha ocurrido un error al ejecutar consulta/obtener resultado");
		}

		DBUtilidades.cerrarConexionBD();
		
		return grupo;
	}
}
