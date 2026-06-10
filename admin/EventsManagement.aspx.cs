using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_EventsManagement : Page
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
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM events ORDER BY id ASC", conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvEvents.DataSource = dt;
                        gvEvents.DataBind();
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
        hfEventId.Value = "";
        txtTitle.Text = "";
        txtDate.Text = "";
        ddlStatus.SelectedIndex = 0;
        ddlAlignment.SelectedIndex = 0;
        txtDescription.Text = "";
        
        litModalTitle.Text = "Add Event";
        pnlModal.Visible = true;
    }

    protected void btnCloseModal_Click(object sender, EventArgs e)
    {
        pnlModal.Visible = false;
    }

    protected void gvEvents_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditEvent")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            LoadEvent(id);
        }
        else if (e.CommandName == "DeleteEvent")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            DeleteEvent(id);
            BindGrid();
        }
    }

    private void LoadEvent(int id)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM events WHERE id=@Id", conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            hfEventId.Value = reader["id"].ToString();
                            txtTitle.Text = reader["title"].ToString();
                            txtDate.Text = reader["event_date"].ToString();
                            txtDescription.Text = reader["description"].ToString();
                            
                            string status = reader["status"].ToString().ToLower();
                            if (ddlStatus.Items.FindByValue(status) != null)
                                ddlStatus.SelectedValue = status;
                                
                            string align = reader["alignment"].ToString().ToLower();
                            if (ddlAlignment.Items.FindByValue(align) != null)
                                ddlAlignment.SelectedValue = align;
                            
                            litModalTitle.Text = "Edit Event";
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

    private void DeleteEvent(int id)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("DELETE FROM events WHERE id=@Id", conn))
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
        string eventDate = txtDate.Text.Trim();
        string status = ddlStatus.SelectedValue;
        string alignment = ddlAlignment.SelectedValue;
        string desc = txtDescription.Text.Trim();

        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd;
                if (string.IsNullOrEmpty(hfEventId.Value))
                {
                    // Insert
                    cmd = new SqlCommand("INSERT INTO events (title, event_date, status, description, alignment) VALUES (@Title, @Date, @Status, @Desc, @Align)", conn);
                }
                else
                {
                    // Update
                    cmd = new SqlCommand("UPDATE events SET title=@Title, event_date=@Date, status=@Status, description=@Desc, alignment=@Align WHERE id=@Id", conn);
                    cmd.Parameters.AddWithValue("@Id", Convert.ToInt32(hfEventId.Value));
                }

                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Date", eventDate);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@Desc", desc);
                cmd.Parameters.AddWithValue("@Align", alignment);

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
