using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Settings : Page
{
    private string connString = ConfigurationManager.ConnectionStrings["CyborgConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminAuth"] == null || (bool)Session["AdminAuth"] == false)
        {
            Response.Redirect("login.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadSocialLinks();
            BindStatsGrid();
        }
    }

    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("login.aspx");
    }

    private void ShowStatusMessage(string message, bool isSuccess)
    {
        lblStatus.Visible = true;
        lblStatus.Text = message;
        lblStatus.CssClass = isSuccess ? "alert-success" : "alert-error";
    }

    private void LoadSocialLinks()
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = "SELECT setting_key, setting_value FROM settings";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string key = reader["setting_key"].ToString();
                            string val = reader["setting_value"].ToString();
                            if (key == "DiscordUrl") txtDiscord.Text = val;
                            else if (key == "FacebookUrl") txtFacebook.Text = val;
                            else if (key == "InstagramUrl") txtInstagram.Text = val;
                            else if (key == "YoutubeUrl") txtYoutube.Text = val;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("LoadSocialLinks Error: " + ex.Message);
            ShowStatusMessage("Error loading social links from database: " + ex.Message, false);
        }
    }

    protected void btnSaveSocials_Click(object sender, EventArgs e)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = "UPDATE settings SET setting_value = @Val WHERE setting_key = @Key";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add("@Key", SqlDbType.VarChar);
                    cmd.Parameters.Add("@Val", SqlDbType.NVarChar);

                    // Update Discord
                    cmd.Parameters["@Key"].Value = "DiscordUrl";
                    cmd.Parameters["@Val"].Value = txtDiscord.Text.Trim();
                    cmd.ExecuteNonQuery();

                    // Update Facebook
                    cmd.Parameters["@Key"].Value = "FacebookUrl";
                    cmd.Parameters["@Val"].Value = txtFacebook.Text.Trim();
                    cmd.ExecuteNonQuery();

                    // Update Instagram
                    cmd.Parameters["@Key"].Value = "InstagramUrl";
                    cmd.Parameters["@Val"].Value = txtInstagram.Text.Trim();
                    cmd.ExecuteNonQuery();

                    // Update YouTube
                    cmd.Parameters["@Key"].Value = "YoutubeUrl";
                    cmd.Parameters["@Val"].Value = txtYoutube.Text.Trim();
                    cmd.ExecuteNonQuery();
                }
            }
            ShowStatusMessage("Social links saved successfully!", true);
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("SaveSocials Error: " + ex.Message);
            ShowStatusMessage("Error saving social links: " + ex.Message, false);
        }
    }

    private void BindStatsGrid()
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT id, icon, target, label FROM achievements ORDER BY id ASC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        rptStats.DataSource = dt;
                        rptStats.DataBind();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("BindStatsGrid Error: " + ex.Message);
            ShowStatusMessage("Error binding statistics: " + ex.Message, false);
        }
    }

    protected void btnSaveStats_Click(object sender, EventArgs e)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                foreach (RepeaterItem item in rptStats.Items)
                {
                    HiddenField hfStatId = (HiddenField)item.FindControl("hfStatId");
                    TextBox txtTarget = (TextBox)item.FindControl("txtTarget");

                    if (hfStatId != null && txtTarget != null && !string.IsNullOrEmpty(hfStatId.Value))
                    {
                        int id = Convert.ToInt32(hfStatId.Value);
                        int target = Convert.ToInt32(txtTarget.Text);

                        string query = "UPDATE achievements SET target = @Target WHERE id = @Id";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@Target", target);
                            cmd.Parameters.AddWithValue("@Id", id);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
            ShowStatusMessage("Battle statistics saved successfully!", true);
            BindStatsGrid();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("SaveStats Error: " + ex.Message);
            ShowStatusMessage("Error saving battle statistics: " + ex.Message, false);
        }
    }
}
