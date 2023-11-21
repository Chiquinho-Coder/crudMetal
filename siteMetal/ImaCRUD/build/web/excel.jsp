<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.io.BufferedReader" %>
<%@page import="java.io.FileReader" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro via Excel</title>
    </head>
    <body>
        <%
            String sql = "";
            PreparedStatement st;
            try {
                //Conecta ao banco de dados chamado banco
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/bancoIma", "root", "@Pedro2003456");
                //Ler o arquivo Excel
                FileReader arquivo = new FileReader("c:\\siteMetal\\ImaCRUD\\produtos.csv");
                BufferedReader br = new BufferedReader(arquivo);
                String linha;
                //Se a linha lida do arquivo produtos.csv não estiver nula
                while ((linha = br.readLine()) != null) {
                    //Pegam os valores da linha do arquivo excel e joga em variáveis
                    String[] dados = linha.split(",");
                    //limpa o valor contido em dados[0] de caracteres ocultos
                    String cod = dados[0].replaceAll("[^0-9]", "");
                    int c = Integer.parseInt(cod);
                    String n = dados[1];
                    String m = dados[2];
                    double p = Double.parseDouble(dados[3]);
                    //Busca pelo produto antes de inserir na tabela
                    sql = "SELECT * FROM detect WHERE codigo = ?";
                    st = conecta.prepareStatement(sql);
                    st.setInt(1, c);
                    ResultSet resultado = st.executeQuery(); //Executa o select
                    if (!resultado.next()) { //se não encontrou o produto na tabela                    
                        //Prepara o comando insert para inserir os dados na tabela
                        sql = "INSERT INTO detect VALUES(?,?,?,?)";
                        st = conecta.prepareStatement(sql);
                        st.setInt(1, c);
                        st.setString(2, n);
                        st.setString(3, m);
                        st.setDouble(4, p);
                        st.executeUpdate(); //Executa o comando insert
                        out.print("O produto <b>" + c + "</b> foi cadastrado com sucesso <br>");
                    } else {
                        out.print("O produto <b>" + c + "</b> já está cadastrado <br>");
                    }
                }
                br.close();
            } catch (Exception erro) {
                out.print("Entre em contato com o suporte e informe o erro: " + erro.getMessage());
            }
        %>    
    </body>
</html>
