<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@page import="javax.sql.DataSource" %>
<%@page import="javax.naming.InitialContext" %>
<%@page import="javax.naming.Context" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.SQLException" %>
<%@ page import="javax.naming.NamingException" %>

<%@include file="datasource-config.jsp" %>

<%
    String DATA_SOURCE_INITIAL_SQL = application.getRealPath("/") + "/init-datasource.sql";

    Connection connection = null;

    try {
        Context initContext = new InitialContext();
        Context envContext = (Context)initContext.lookup("java:/comp/env");
        DataSource dataSource = (DataSource)envContext.lookup(DATASOURCE_NAME);

        connection = dataSource.getConnection();
        checkInitDB(connection);
    } catch (SQLException e) {
        if (e.getMessage().contains("Table") && e.getMessage().contains("doesn't exist")) {
            initDB(connection, DATA_SOURCE_INITIAL_SQL, out);
        } else {
            out.print("<script>console.log(" + e.getMessage() + ");</script>");
        }
    } catch (NamingException e) {
        response.sendRedirect("datasource-error.jsp");
    }
%>


<%!
    /**
     * Checks if Database already initialized. Try to get first record and if table doesn't exist exception thrown.
     *
     * @param connection
     *        connection statement.
     * @throws SQLException
     */
    public void checkInitDB(Connection connection) throws SQLException {
        Statement statement = null;
        try {
            statement = connection.createStatement();
            String sql = "SELECT * FROM `employees` ORDER BY `id` LIMIT 0, 1";
            statement.executeQuery(sql);
        } finally {
            if (statement != null) {
                statement.close();
            }
        }
    }
%>

<%!
    /**
     * Initialize Database from sql dump.
     *
     * @param connection
     *        connection statement.
     * @param sqlPath
     *        path to sql dump.
     * @param out
     *        JspWriter object to write error messages to javascript console.
     * @throws Exception
     */
    public void initDB(Connection connection, String sqlPath, JspWriter out) throws Exception {
        BufferedReader sqlReader = null;

        try {
            sqlReader = new BufferedReader(new FileReader(sqlPath));
            StringBuilder sqlContent = new StringBuilder();
            char[] buf = new char[1024];
            int numRead;
            while ((numRead = sqlReader.read(buf)) != -1) {
                String readData = String.valueOf(buf, 0, numRead);
                sqlContent.append(readData);
                buf = new char[1024];
            }

            Statement statement = connection.createStatement();
            String[] queries = sqlContent.toString().split(";");
            for (String query : queries) {
                String sq = query.trim();
                if (sq.isEmpty()) {
                    continue;
                }

                statement.addBatch(sq);
            }
            statement.executeBatch();
            statement.close();
        } catch (Exception e) {
            out.print("<script>console.log(" + e.getMessage() + ");</script>");
        } finally {
            if (sqlReader != null) {
                try {
                    sqlReader.close();
                } catch (IOException e) {
                }
            }
        }
    }
%>