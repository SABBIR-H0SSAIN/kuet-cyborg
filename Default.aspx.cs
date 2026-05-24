using System;
using System.Web.UI;

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
            // Here you can save to a database, send an email, etc.
            // For now, simply show the confirmation message.
            string playerName = txtName.Text.Trim();
            string department = txtDepartment.Text.Trim();
            string game = ddlGame.SelectedValue;
            string message = txtMessage.Text.Trim();

            // Clear the form fields
            txtName.Text = string.Empty;
            txtDepartment.Text = string.Empty;
            ddlGame.SelectedIndex = 0;
            txtMessage.Text = string.Empty;

            // Show success message
            lblResponse.Visible = true;
        }
    }
}