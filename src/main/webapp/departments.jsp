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
            print_menu_item(request, out, "Employees", "employees.jsp", false);
            print_menu_item(request, out, "Departments", "departments.jsp", true);
            print_menu_item(request, out, "New employee", "employee.jsp", false);
        %>
    </div>
</div>
<div class="content">
    <div class="content-inner">

        <%

            try {
                Statement statement = connection.createStatement();
                String sql = "SELECT * FROM `departments` ORDER BY `id`";
                ResultSet resultSet = statement.executeQuery(sql);

        %>
        <table class="departments-table">
            <tr class="departments-table-header">
                <th>ID</th>
                <th>Name</th>
                <th>Manager</th>
            </tr>
            <%

                while (resultSet.next()) {
            %>
            <tr class="departments-table-row">
                <td class="departments-table-id"><%= resultSet.getString("id") %>
                </td>
                <td class="departments-table-name"><%= resultSet.getString("name") %>
                </td>
                <td class="departments-table-manager"><%= resultSet.getString("manager_id") %>
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
