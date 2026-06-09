<%@ WebHandler Language="C#" Class="GetGames" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Web.Script.Serialization;

public class GetGames : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        context.Response.Cache.SetNoStore();
        context.Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
        
        try
        {
            List<Dictionary<string, object>> games = new List<Dictionary<string, object>>();
            string connStr = ConfigurationManager.ConnectionStrings["CyborgConnectionString"].ConnectionString;
            
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM games ORDER BY id ASC", conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var game = new Dictionary<string, object>();
                            game["id"] = reader["id"];
                            game["title"] = reader["title"].ToString();
                            game["category"] = reader["category"].ToString();
                            game["badge"] = reader["badge"].ToString();
                            game["image_url"] = reader["image_url"].ToString();
                            game["description"] = reader["description"].ToString();
                            
                            // tags are stored as comma-separated
                            string tagsStr = reader["tags"].ToString();
                            string[] tags = tagsStr.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                            for (int i = 0; i < tags.Length; i++) tags[i] = tags[i].Trim();
                            game["tags"] = tags;
                            
                            games.Add(game);
                        }
                    }
                }
            }
            
            JavaScriptSerializer js = new JavaScriptSerializer();
            context.Response.Write(js.Serialize(games));
        }
        catch (Exception ex)
        {
            context.Response.StatusCode = 500;
            context.Response.Write("{\"error\": \"" + ex.Message.Replace("\"", "\\\"") + "\"}");
        }
    }

    public bool IsReusable { get { return false; } }
}
