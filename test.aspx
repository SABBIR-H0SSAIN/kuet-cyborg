<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Configuration" %>
<%
    try
    {
        string connStr = ConfigurationManager.ConnectionStrings["CyborgConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM games", conn))
            {
                int count = (int)cmd.ExecuteScalar();
                Response.Write("COUNT: " + count + "<br>");
            }
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM games ORDER BY id ASC", conn))
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Response.Write("GAME: " + reader["title"].ToString() + "<br>");
                    }
                }
            }
        }
    }
    catch (Exception ex)
    {
        Response.Write("ERROR: " + ex.Message);
    }
%>
