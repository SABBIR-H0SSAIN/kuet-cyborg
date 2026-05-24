using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Drawing;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // On initial load, ensure response label is hidden
        if (!IsPostBack)
        {
            lblResponse.Visible = false;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string playerName = txtName.Text.Trim();
            string department = txtDepartment.Text.Trim();
            string game = ddlGame.SelectedValue;
            string message = txtMessage.Text.Trim();

            bool isSuccess = SaveFormResponseToDatabase(playerName, department, game, message);

            if (isSuccess)
            {
                txtName.Text = string.Empty;
                txtDepartment.Text = string.Empty;
                ddlGame.SelectedIndex = 0;
                txtMessage.Text = string.Empty;

                lblResponse.Visible = true;
                lblResponse.Text = "Your response has been submitted successfully!";
                lblResponse.ForeColor = Color.LimeGreen;
            }
            else
            {
                lblResponse.Visible = true;
                lblResponse.Text = "✗ Error submitting response. Please try again.";
                lblResponse.ForeColor = Color.Red;
            }
        }
    }

    private bool SaveFormResponseToDatabase(string playerName, string department, string game, string message)
    {
        try
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CyborgConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = @"INSERT INTO form_response 
                               (player_name, department, game, message, submitted_date) 
                               VALUES (@PlayerName, @Department, @Game, @Message, @SubmittedDate)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@PlayerName", playerName);
                    command.Parameters.AddWithValue("@Department", department);
                    command.Parameters.AddWithValue("@Game", game);
                    command.Parameters.AddWithValue("@Message", message);
                    command.Parameters.AddWithValue("@SubmittedDate", DateTime.Now);

                    command.ExecuteNonQuery();
                }

                connection.Close();
            }

            return true;
        }
        catch (SqlException sqlEx)
        {
            System.Diagnostics.Debug.WriteLine("Database Error: " + sqlEx.Message);
            return false;
        }
        catch (ConfigurationErrorsException cfgEx)
        {
            System.Diagnostics.Debug.WriteLine("Configuration Error: " + cfgEx.Message);
            return false;
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("General Error: " + ex.Message);
            return false;
        }
    }
}