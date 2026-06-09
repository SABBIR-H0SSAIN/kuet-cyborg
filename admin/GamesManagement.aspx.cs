using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_GamesManagement : Page
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
            BindGrid();
        }
    }

    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("login.aspx");
    }

    private void BindGrid()
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM games ORDER BY id DESC", conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvGames.DataSource = dt;
                        gvGames.DataBind();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Bind Error: " + ex.Message);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        hfGameId.Value = "";
        txtTitle.Text = "";
        txtCategory.Text = "";
        txtBadge.Text = "";
        txtTags.Text = "";
        txtImageUrl.Text = "";
        txtDescription.Text = "";
        litModalTitle.Text = "Add Game";
        pnlModal.Visible = true;
    }

    protected void btnCloseModal_Click(object sender, EventArgs e)
    {
        pnlModal.Visible = false;
    }

    protected void gvGames_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditGame")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            LoadGame(id);
        }
        else if (e.CommandName == "DeleteGame")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            DeleteGame(id);
            BindGrid();
        }
    }

    private void LoadGame(int id)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM games WHERE id=@Id", conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            hfGameId.Value = reader["id"].ToString();
                            txtTitle.Text = reader["title"].ToString();
                            txtCategory.Text = reader["category"].ToString();
                            txtBadge.Text = reader["badge"].ToString();
                            txtImageUrl.Text = reader["image_url"].ToString();
                            txtDescription.Text = reader["description"].ToString();
                            txtTags.Text = reader["tags"].ToString();
                            
                            litModalTitle.Text = "Edit Game";
                            pnlModal.Visible = true;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Load Error: " + ex.Message);
        }
    }

    private void DeleteGame(int id)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("DELETE FROM games WHERE id=@Id", conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.ExecuteNonQuery();
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Delete Error: " + ex.Message);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string title = txtTitle.Text.Trim();
        string category = txtCategory.Text.Trim();
        string badge = txtBadge.Text.Trim();
        string imageUrl = txtImageUrl.Text.Trim();
        string desc = txtDescription.Text.Trim();
        string tags = txtTags.Text.Trim();

        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd;
                if (string.IsNullOrEmpty(hfGameId.Value))
                {
                    // Insert
                    cmd = new SqlCommand("INSERT INTO games (title, category, badge, image_url, description, tags) VALUES (@Title, @Category, @Badge, @ImageUrl, @Desc, @Tags)", conn);
                }
                else
                {
                    // Update
                    cmd = new SqlCommand("UPDATE games SET title=@Title, category=@Category, badge=@Badge, image_url=@ImageUrl, description=@Desc, tags=@Tags WHERE id=@Id", conn);
                    cmd.Parameters.AddWithValue("@Id", Convert.ToInt32(hfGameId.Value));
                }

                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@Badge", badge);
                cmd.Parameters.AddWithValue("@ImageUrl", imageUrl);
                cmd.Parameters.AddWithValue("@Desc", desc);
                cmd.Parameters.AddWithValue("@Tags", tags);

                cmd.ExecuteNonQuery();
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Save Error: " + ex.Message);
        }

        pnlModal.Visible = false;
        BindGrid();
    }
}
