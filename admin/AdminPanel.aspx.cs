using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_AdminPanel : Page
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

    protected void FilterSort_Changed(object sender, EventArgs e)
    {
        BindGrid();
    }

    private void BindGrid()
    {
        string filter = ddlFilter.SelectedValue;
        string sort = ddlSort.SelectedValue;

        string query = "SELECT response_id, player_name, department, game, message, submitted_date, status FROM form_response WHERE 1=1 ";
        
        if (filter == "Pending")
        {
            query += " AND status = 'Pending' ";
        }
        else if (filter == "Completed")
        {
            query += " AND status = 'Completed' ";
        }

        if (sort == "ASC")
        {
            query += " ORDER BY submitted_date ASC ";
        }
        else
        {
            query += " ORDER BY submitted_date DESC ";
        }

        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvResponses.DataSource = dt;
                        gvResponses.DataBind();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Bind Error: " + ex.Message);
        }
    }

    protected void gvResponses_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Complete")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            UpdateStatus(id, "Completed");
            BindGrid();
        }
        else if (e.CommandName == "DeleteItem")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            DeleteRecord(id);
            BindGrid();
        }
    }

    private void UpdateStatus(int id, string status)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = "UPDATE form_response SET status = @Status WHERE response_id = @Id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.ExecuteNonQuery();
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Update Error: " + ex.Message);
        }
    }

    private void DeleteRecord(int id)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = "DELETE FROM form_response WHERE response_id = @Id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
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
}
