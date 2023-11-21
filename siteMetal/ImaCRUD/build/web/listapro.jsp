
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>Listagem de produtos</title>
        <link rel="stylesheet" href="tabela.css">
    </head>
    <body>
        <%
            try {
                //Fazer a conexão com o Banco de Dados
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/bancoIma", "root", "@Pedro2003456");
                //Listar os dados da tabela produto do banco de dados 
                st = conecta.prepareStatement("SELECT * FROM detect ORDER By codigo");
                ResultSet rs = st.executeQuery();
                %>
                <table>
                   <tr>
                       <th>Código</th>
                       <th>Nome</th>
                       <th>Marca</th>
                       <th>Preço</th>
                       <th>Exclusão</th>
                       <th>Alteração</th>                       
                   </tr>                
                <%
                while (rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getString("codigo")%></td>
                        <td><%= rs.getString("nome")%></td>
                        <td><%= rs.getString("marca")%></td>
                        <td><%= rs.getString("preco")%></td>
                        <td><a href="excpro.jsp?codigo=<%=rs.getString("codigo")%>">Excluir</a></td>
                        <td><a href="carregaprod.jsp?codigo=<%=rs.getString("codigo")%>">Alterar</a></td>
                    </tr>
               <%
               }
               %>
               </table>
               <%
        } catch (Exception x) {
            out.print("Mensagem de erro:" + x.getMessage());
        }
    %>   
</body>
</html>
