using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_GalleryManagement : Page
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
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM gallery ORDER BY id ASC", conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvGallery.DataSource = dt;
                        gvGallery.DataBind();
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
        hfGalleryId.Value = "";
        txtTitle.Text = "";
        txtImageUrl.Text = "";
        
        litModalTitle.Text = "Add Image";
        pnlModal.Visible = true;
    }

    protected void btnCloseModal_Click(object sender, EventArgs e)
    {
        pnlModal.Visible = false;
    }

    protected void gvGallery_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditGallery")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            LoadGallery(id);
        }
        else if (e.CommandName == "DeleteGallery")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            DeleteGallery(id);
            BindGrid();
        }
    }

    private void LoadGallery(int id)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM gallery WHERE id=@Id", conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            hfGalleryId.Value = reader["id"].ToString();
                            txtTitle.Text = reader["title"].ToString();
                            txtImageUrl.Text = reader["image_url"].ToString();
                            
                            litModalTitle.Text = "Edit Image";
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

    private void DeleteGallery(int id)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("DELETE FROM gallery WHERE id=@Id", conn))
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
        string imageUrl = txtImageUrl.Text.Trim();

        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd;
                if (string.IsNullOrEmpty(hfGalleryId.Value))
                {
                    // Insert
                    cmd = new SqlCommand("INSERT INTO gallery (title, image_url) VALUES (@Title, @ImageUrl)", conn);
                }
                else
                {
                    // Update
                    cmd = new SqlCommand("UPDATE gallery SET title=@Title, image_url=@ImageUrl WHERE id=@Id", conn);
                    cmd.Parameters.AddWithValue("@Id", Convert.ToInt32(hfGalleryId.Value));
                }

                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@ImageUrl", imageUrl);

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
