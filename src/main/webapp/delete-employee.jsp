<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@include file="init-datasource.jsp" %>

<%
    String employeeId = request.getParameter("id").trim();

    try {
        String sql = "DELETE FROM `employees` WHERE `id`=" + employeeId;
        Statement statement = connection.createStatement();
        statement.executeUpdate(sql);
        statement.close();
        response.sendRedirect("employees.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (!connection.isClosed()) {
                connection.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
