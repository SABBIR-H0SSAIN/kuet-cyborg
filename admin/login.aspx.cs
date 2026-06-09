using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

public partial class admin_login : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblError.Visible = false;
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string user = txtUsername.Text.Trim();
        string pass = txtPassword.Text.Trim();

        string connString = ConfigurationManager.ConnectionStrings["CyborgConnectionString"].ConnectionString;
        bool isAuthenticated = false;

        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = "SELECT COUNT(1) FROM admins WHERE username = @Username AND password = @Password";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", user);
                    cmd.Parameters.AddWithValue("@Password", pass);
                    
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    if (count > 0)
                    {
                        isAuthenticated = true;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Login Error: " + ex.Message);
            lblError.Text = "A database error occurred during login.";
            lblError.Visible = true;
            return;
        }

        if (isAuthenticated)
        {
            Session["AdminAuth"] = true;
            Response.Redirect("AdminPanel.aspx");
        }
        else
        {
            lblError.Text = "Invalid username or password.";
            lblError.Visible = true;
        }
    }
}
