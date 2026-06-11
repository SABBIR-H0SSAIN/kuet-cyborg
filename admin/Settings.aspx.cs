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
                        gvStats.DataSource = dt;
                        gvStats.DataBind();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("BindStatsGrid Error: " + ex.Message);
            ShowStatusMessage("Error binding statistics grid: " + ex.Message, false);
        }
    }



    protected void btnCloseModal_Click(object sender, EventArgs e)
    {
        pnlModal.Visible = false;
    }

    protected void gvStats_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditStat")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            LoadStatForEdit(id);
        }
    }

    private void LoadStatForEdit(int id)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = "SELECT id, icon, target, label FROM achievements WHERE id = @Id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            litModalTitle.Text = "Edit Battle Stat";
                            hfStatId.Value = reader["id"].ToString();
                            txtTarget.Text = reader["target"].ToString();
                            txtLabel.Text = reader["label"].ToString();
                            pnlModal.Visible = true;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("LoadStatForEdit Error: " + ex.Message);
            ShowStatusMessage("Error loading stat for edit: " + ex.Message, false);
        }
    }



    protected void btnSaveStat_Click(object sender, EventArgs e)
    {
        int target = Convert.ToInt32(txtTarget.Text);
        string label = txtLabel.Text.Trim();
        string idStr = hfStatId.Value;

        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query;
                if (string.IsNullOrEmpty(idStr))
                {
                    query = "INSERT INTO achievements (target, label) VALUES (@Target, @Label)";
                }
                else
                {
                    query = "UPDATE achievements SET target = @Target, label = @Label WHERE id = @Id";
                }

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Target", target);
                    cmd.Parameters.AddWithValue("@Label", label);
                    if (!string.IsNullOrEmpty(idStr))
                    {
                        cmd.Parameters.AddWithValue("@Id", Convert.ToInt32(idStr));
                    }
                    cmd.ExecuteNonQuery();
                }
            }
            pnlModal.Visible = false;
            BindStatsGrid();
            ShowStatusMessage("Battle stat saved successfully!", true);
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("SaveStat Error: " + ex.Message);
            ShowStatusMessage("Error saving battle stat: " + ex.Message, false);
        }
    }
}
