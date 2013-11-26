<%@include file="init-datasource.jsp" %>

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
            print_menu_item(request, out, "Employees", "employees.jsp", true);
            print_menu_item(request, out, "Departments", "departments.jsp", false);
            print_menu_item(request, out, "New employee", "employee.jsp", false);
        %>
    </div>
</div>
<div class="content">
    <div class="content-inner">

        <script type="text/javascript">
            function ask_delete_employee(eId, eName, eLastName, eDepartment) {
                var r = confirm("Delete employee " + eName + " " + eLastName + " ?");
                if (r == true) {
                    window.location = "delete-employee.jsp?id=" + eId;
                }
            }
        </script>

        <%

            try {
                Statement statement = connection.createStatement();
                String sql = "SELECT * FROM `employees` ORDER BY `id`";
                ResultSet resultSet = statement.executeQuery(sql);

        %>
        <table class="employees-table">
            <tr class="employees-table-header">
                <th>ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Salary</th>
                <th>Department</th>
                <th>Start Date</th>
                <th>
                    <div></div>
                </th>
                <th>
                    <div></div>
                </th>
            </tr>
            <%

                while (resultSet.next()) {
                    //lastAccess = resultSet.getString("time");
            %>
            <tr class="employees-table-row">
                <td class="employees-table-id"><%= resultSet.getString("id") %>
                </td>
                <td class="employees-table-first-name"><%= resultSet.getString("first_name") %>
                </td>
                <td class="employees-table-last-name"><%= resultSet.getString("last_name") %>
                </td>
                <td class="employees-table-salary"><%= resultSet.getString("salary") %>
                </td>
                <td class="employees-table-department"><%= resultSet.getString("department_id") %>
                </td>
                <td class="employees-table-startdate"><%= resultSet.getString("start_date") %>
                </td>
                <td class="employees-table-action">
                    <img src="images/edit.png" onclick="window.location='employee.jsp?id=<%= resultSet.getString("id") %>'"/>
                </td>
                <td class="employees-table-action">
                    <img src="images/delete.png" onclick="ask_delete_employee(
                            '<%= resultSet.getString("id") %>',
                            '<%= resultSet.getString("first_name") %>',
                            '<%= resultSet.getString("last_name") %>',
                            '<%= resultSet.getString("department_id") %>');"/>
                </td>
            </tr>
            <%
                }

            %>
        </table>
        <%

                statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

        %>
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
