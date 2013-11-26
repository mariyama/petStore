<%@taglib uri="/struts-tags" prefix="s" %>
 
<html>
<head>
<title>Hello World Struts</title>
</head>
<body>
  <center><s:form action="hello" >
        <s:textfield name="userName" label="User Name" />
        <s:submit />
    </s:form></center>
</body>
</html>
