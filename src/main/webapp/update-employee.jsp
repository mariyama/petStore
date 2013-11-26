<%@page import="java.net.URLDecoder" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@include file="init-datasource.jsp" %>
<%

    String employeeId = request.getParameter("id");
    String firstName = request.getParameter("first_name");
    String lastName = request.getParameter("last_name");
    String salary = request.getParameter("salary");
    String departmentId = request.getParameter("department_id");

    firstName = URLDecoder.decode(firstName, "UTF-8");
    lastName = URLDecoder.decode(lastName, "UTF-8");
    salary = URLDecoder.decode(salary, "UTF-8");
    departmentId = URLDecoder.decode(departmentId, "UTF-8");

    String sql = "UPDATE `employees` SET `first_name`='" + firstName + "', `last_name`='" + lastName + "', `salary`=" + salary +
                 ", `department_id`=" + departmentId + " WHERE `id`=" + employeeId;

    try {
        Statement statement = connection.createStatement();
        statement.executeUpdate(sql);
        statement.close();

        if (!connection.isClosed()) {
            connection.close();
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    response.sendRedirect("employees.jsp");

%>
