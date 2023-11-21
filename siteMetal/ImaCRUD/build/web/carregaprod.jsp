<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Alteração de produtos</title>
    </head>
    <body>
        <%
            //Recebe o código do produto a alterar
            int c;
            c = Integer.parseInt(request.getParameter("codigo"));
            //Fazer a conexão com o Banco de Dados
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/bancoima", "root", "Pedro2003456");
            //Buscar o produto pelo código recebido
            st = conecta.prepareStatement("SELECT * FROM detect WHERE codigo = ?");
            st.setInt(1, c);
            ResultSet resultado = st.executeQuery(); //Executa o SELECT
            //Verifica se o produto de código informado foi encontrado
            if (!resultado.next()) { //se não encontrou o produto
                out.print("Este produto não foi encontrado");
            } else { //se encontrou o produto
        %>
        <form method="post" action="alterar_produtos.jsp">
            <p>
                <label for="codigo">Código:</label>
                <input type="number" name="codigo" id="codigo" value="<%= resultado.getString("codigo") %>" readonly>
            </p>
            <p>
                <label for="nome">Nome do produto:</label>
                <input type="text" name="nome" id="nome" size="70" value="<%= resultado.getString("nome") %>">
            </p>  
            <p>
                <label for="marca">Marca:</label>
                <input type="text" name="marca" id="marca" value="<%= resultado.getString("marca") %>">
            </p> 
            <p>
                <label for="preco">Preço:</label>
                <input type="number" step="0.1" name="preco" id="preco" value="<%= resultado.getString("preco") %>">
            </p>              
            <p>
                <input type="submit" value="Salvar Alterações">   
            </p>
        </form>    
        <%
            }
        %>    
    </body>
</html>
