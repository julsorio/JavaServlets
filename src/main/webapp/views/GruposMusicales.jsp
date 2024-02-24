<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Grupos Musicales</title>
<style>
h1 {
	text-align: center;
}

table {
	border: 1px solid;
	width: 100%
}

table thead {
	background-color: #a18f79;
	text-align: center;
}

table tbody tr:nth-child(odd) {
	background-color: #c9bdac;
}

table tbody tr:nth-child(even) {
	background-color: #e4ded4;
}

table tbody td {
	text-align: center;
}

.contenido {
	margin: auto;
	padding: 10px;
	width: 60%;
}

</style>

<c:set value="${lista}" var="listaGrupos" />

</head>
<body>
	<h1>Grupos Musicales</h1>

	<div class="contenido">
		<table>
		<thead>
			<tr>
				<th>Id</th>
				<th>Nombre</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${lista}" var="grupo">
				<tr>
					<td>${grupo.id}</td>
					<td>${grupo.nombre}</td>
					<td><a href="/JavaEEServlets/DetalleGrupo?id=${grupo.id}">Ver
							m&aacute;s</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>

</body>
</html>