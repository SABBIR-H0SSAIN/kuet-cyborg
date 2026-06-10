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
        // Generate rounded favicon if it doesn't exist
        try
        {
            string physicalPath = Server.MapPath("~/assets/logos/cybrog-logo.jpg");
            string targetPath = Server.MapPath("~/assets/logos/cybrog-logo-rounded.png");
            if (!System.IO.File.Exists(targetPath) && System.IO.File.Exists(physicalPath))
            {
                using (var srcImage = System.Drawing.Image.FromFile(physicalPath))
                {
                    int minSize = Math.Min(srcImage.Width, srcImage.Height);
                    using (var destImage = new System.Drawing.Bitmap(minSize, minSize))
                    {
                        using (var g = System.Drawing.Graphics.FromImage(destImage))
                        {
                            g.Clear(System.Drawing.Color.Transparent);
                            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
                            using (var path = new System.Drawing.Drawing2D.GraphicsPath())
                            {
                                path.AddEllipse(0, 0, minSize, minSize);
                                g.SetClip(path);
                                g.DrawImage(srcImage, new System.Drawing.Rectangle(0, 0, minSize, minSize), new System.Drawing.Rectangle((srcImage.Width - minSize) / 2, (srcImage.Height - minSize) / 2, minSize, minSize), System.Drawing.GraphicsUnit.Pixel);
                            }
                        }
                        destImage.Save(targetPath, System.Drawing.Imaging.ImageFormat.Png);
                    }
                }
            }
        }
        catch (Exception)
        {
            // Fail silently if permissions or GDI issues prevent generation
        }

        // On initial load, ensure response label is hidden
        if (!IsPostBack)
        {
            lblResponse.Visible = false;
            BindGames();
            BindEvents();
            BindGallery();
        }
    }

    private void BindGames()
    {
        try
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CyborgConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM games ORDER BY id ASC", connection))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        rptGames.DataSource = dt;
                        rptGames.DataBind();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("BindGames Error: " + ex.Message);
        }
    }

    private void BindEvents()
    {
        try
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CyborgConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM events ORDER BY id ASC", connection))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        rptEvents.DataSource = dt;
                        rptEvents.DataBind();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("BindEvents Error: " + ex.Message);
        }
    }

    private void BindGallery()
    {
        try
        {
            string connectionString = ConfigurationManager.ConnectionStrings["CyborgConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM gallery ORDER BY id ASC", connection))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        rptGallery.DataSource = dt;
                        rptGallery.DataBind();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("BindGallery Error: " + ex.Message);
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

    protected string GetTagsHtml(object tagsObj)
    {
        if (tagsObj == null || tagsObj == DBNull.Value) return "";
        string tagsStr = tagsObj.ToString();
        string[] tags = tagsStr.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
        string html = "";
        foreach (string tag in tags)
        {
            html += $"<span class=\"game-tag\">{tag.Trim()}</span>";
        }
        return html;
    }
}