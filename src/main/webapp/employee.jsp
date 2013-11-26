<%@page import="java.util.Map.Entry" %>
<%@page import="java.util.LinkedHashMap" %>
<%@include file="init-datasource.jsp" %>

<%
    // Departments
    LinkedHashMap<Integer, String> departments = new LinkedHashMap<Integer, String>();
    try {
        Statement statement = connection.createStatement();
        String sql = "SELECT * FROM `departments` ORDER BY `id`";
        ResultSet resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
            Integer id = new Integer(resultSet.getInt("id"));
            String name = resultSet.getString("name");
            departments.put(id, name);
        }
        statement.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Employee details

    String employeeId = request.getParameter("id");
    String firstName = "";
    String lastName = "";
    String salary = "";
    Integer department = null;

    if (employeeId != null) {

        try {
            Statement statement = connection.createStatement();
            String sql = "SELECT * FROM `employees` WHERE `id`=" + employeeId;
            ResultSet resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                firstName = resultSet.getString("first_name");
                lastName = resultSet.getString("last_name");
                salary = resultSet.getString("salary");
                if (resultSet.getString("department_id") != null) {
                    department = new Integer(resultSet.getString("department_id"));
                }
                break;
            }

            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Employees DB</title>
    <link href='styles.css' rel='stylesheet' type='text/css'>
</head>

<body>
<div class=header>
    <div class="head">
        <div class="head-logo"><img src="images/eyes.png"/></div>
        <div class="head-text">Employees DB</div>
    </div>
    <div class="menu">
        <%!
            public void print_menu_item(javax.servlet.http.HttpServletRequest request, javax.servlet.jsp.JspWriter out, String item,
                                        String href, boolean isActive) throws Exception {
                if (isActive) {
                    out.write("<div class=\"menu-item menu-item-active\" style=\"margin-left: 12px;\">&nbsp;&nbsp;&nbsp;" + item +
                              "&nbsp;&nbsp;&nbsp;</div>");
                } else {
                    out.write("<div class=\"menu-item\" style=\"margin-left: 12px;\" onclick=\"window.location='" + href +
                              "'\">&nbsp;&nbsp;&nbsp;" + item + "&nbsp;&nbsp;&nbsp;</div>");
                }
            }
        %>
        <%
            print_menu_item(request, out, "Employees", "employees.jsp", false);
            print_menu_item(request, out, "Departments", "departments.jsp", false);
            print_menu_item(request, out, "New employee", "employee.jsp", employeeId == null);
        %>
    </div>
</div>
<div class="content">
    <div class="content-inner">
        <br>
        <center><b>Employee details</b></center>
        <br>
        <input type="hidden" id="eId" value="<%= employeeId %>"/>
        <table border="0" class="employee-edit-table">
            <tr>
                <td class="employee-edit-table-label">First Name&nbsp;</td>
                <td class="employee-edit-table-text"><input type="text" id="eFirstName" value="<%= firstName %>"/></td>
            </tr>
            <tr>
                <td class="employee-edit-table-label">Last Name&nbsp;</td>
                <td class="employee-edit-table-text"><input type="text" id="eLastName" value="<%= lastName %>"/></td>
            </tr>
            <tr>
                <td class="employee-edit-table-label">Salary&nbsp;</td>
                <td class="employee-edit-table-text"><input type="text" id="eSalary" value="<%= salary %>"/></td>
            </tr>
            <tr>
                <td class="employee-edit-table-label">Department&nbsp;</td>
                <td class="employee-edit-table-text">
                    <select id="eDepartmentId">
                        <%
                            System.out.println("Department: " + department);
                            for (Entry<Integer, String> entry : departments.entrySet()) {
                                String selected = "";
                                if (department != null && department.intValue() == entry.getKey()) {
                                    selected = "selected='true'";
                                } else {

                                }
                        %>
                        <option value="<%= entry.getKey()%>" <%= selected%>><%= entry.getValue()%>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>
        </table>
        <br>
        <br>

        <script>

            function save_employee() {
                var eId = document.getElementById("eId").value;
                var eFirstName = document.getElementById("eFirstName").value;
                var eLastName = document.getElementById("eLastName").value;
                var eSalary = document.getElementById("eSalary").value;
                var eDepartmentId = document.getElementById("eDepartmentId").value;

                window.location =
                        "update-employee.jsp" +
                                "?id=" + encodeURIComponent(eId) +
                                "&first_name=" + encodeURIComponent(eFirstName) +
                                "&last_name=" + encodeURIComponent(eLastName) +
                                "&salary=" + encodeURIComponent(eSalary) +
                                "&department_id=" + encodeURIComponent(eDepartmentId);
            }

            function add_employee() {
                var eId = document.getElementById("eId").value;
                var eFirstName = document.getElementById("eFirstName").value;
                var eLastName = document.getElementById("eLastName").value;
                var eSalary = document.getElementById("eSalary").value;
                var eDepartmentId = document.getElementById("eDepartmentId").value;

                window.location =
                        "add-employee.jsp" +
                                "?first_name=" + encodeURIComponent(eFirstName) +
                                "&last_name=" + encodeURIComponent(eLastName) +
                                "&salary=" + encodeURIComponent(eSalary) +
                                "&department_id=" + encodeURIComponent(eDepartmentId);
            }

        </script>

        <div style="text-align: center">
            <%
                if (employeeId != null) {
            %>
            <button style="margin-left:auto; margin-right:auto; width:130px;" onclick="save_employee();">Save</button>
            <%
                } else {
            %>
            <button style="margin-left:auto; margin-right:auto; width:130px;" onclick="add_employee();">Add</button>
            <%
                }
            %>
        </div>

    </div>
</div>
<div class="footer"><a href="http://codenvy.com" target="_blank">http://codenvy.com</a></div>
</body>
</html>

<%
    try {
        if (!connection.isClosed()) {
            connection.close();
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
