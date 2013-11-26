<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@page import="java.sql.Connection" %>
<%@page import="javax.sql.DataSource" %>
<%@page import="javax.naming.InitialContext" %>
<%@page import="javax.naming.Context" %>

<%@include file="datasource-config.jsp" %>

<%

    String datasource_error = null;
    Connection connection = null;

    try {
        Context initContext = new InitialContext();
        Context envContext = (Context)initContext.lookup("java:/comp/env");
        DataSource dataSource = (DataSource)envContext.lookup(DATASOURCE_NAME);
        connection = dataSource.getConnection();
    } catch (Exception e) {
        datasource_error = "Datasource configured not properly. " + e.getMessage();
    } finally {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (Exception e) {
        }

        if (datasource_error == null) {
            response.sendRedirect("index.jsp");
        }
    }

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
</head>
<body>
<%=datasource_error %>
</body>
</html>