<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminPanel.aspx.cs" Inherits="admin_AdminPanel" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - KUET Cyborg</title>
    <link href="../styles/admin.css" rel="stylesheet" />
    <style>
        .nav-item {
            display: flex;
            align-items: center;
        }
        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            padding: 0;
            border-radius: 6px;
        }
        .action-btn svg {
            width: 16px;
            height: 16px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="sidebar-logo">KUET Cyborg</div>
                <nav>
                    <a href="AdminPanel.aspx" class="nav-item active">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" style="width: 1.25rem; height: 1.25rem; display: inline-block; vertical-align: text-bottom; margin-right: 0.5rem;"><path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z" /></svg>
                        Form Responses
                    </a>
                    <a href="GamesManagement.aspx" class="nav-item">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" style="width: 1.25rem; height: 1.25rem; display: inline-block; vertical-align: text-bottom; margin-right: 0.5rem;"><path stroke-linecap="round" stroke-linejoin="round" d="M14.25 6.087c0-.355.186-.676.401-.959.221-.29.349-.634.349-1.003 0-1.036-1.007-1.875-2.25-1.875s-2.25.84-2.25 1.875c0 .369.128.713.349 1.003.215.283.401.604.401.959v0a1.5 1.5 0 01-1.5 1.5H8.25m5.25 0h.75m-6 0h.75m1.5 0H8.25M8.25 6.087v0a1.5 1.5 0 00-1.5-1.5M15.75 6.087v0a1.5 1.5 0 011.5-1.5M6 18h12a2.25 2.25 0 002.25-2.25V10.5a2.25 2.25 0 00-2.25-2.25H6a2.25 2.25 0 00-2.25 2.25v5.25A2.25 2.25 0 006 18z" /></svg>
                        Games Management
                    </a>
                    <a href="EventsManagement.aspx" class="nav-item">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" style="width: 1.25rem; height: 1.25rem; display: inline-block; vertical-align: text-bottom; margin-right: 0.5rem;"><path stroke-linecap="round" stroke-linejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25m-18 0A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75m-18 0v-7.5A2.25 2.25 0 015.25 9h13.5A2.25 2.25 0 0121 11.25v7.5" /></svg>
                        Events Management
                    </a>
                    <a href="GalleryManagement.aspx" class="nav-item">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" style="width: 1.25rem; height: 1.25rem; display: inline-block; vertical-align: text-bottom; margin-right: 0.5rem;"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 15.75l5.159-5.159a2.25 2.25 0 013.182 0l5.159 5.159m-1.5-1.5l1.409-1.409a2.25 2.25 0 013.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 001.5-1.5V6a1.5 1.5 0 00-1.5-1.5H3.75A1.5 1.5 0 002.25 6v12a1.5 1.5 0 001.5 1.5zm10.5-11.25h.008v.008h-.008V8.25zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" /></svg>
                        Gallery Management
                    </a>
                </nav>
                <div class="sidebar-footer">
                    <asp:LinkButton ID="lnkLogout" runat="server" CssClass="logout-btn" OnClick="lnkLogout_Click">
                        Logout
                    </asp:LinkButton>
                </div>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                <div class="page-header">
                    <h1 class="page-title">Form Responses</h1>
                </div>

                <div class="controls-bar glass">
                    <asp:DropDownList ID="ddlFilter" runat="server" CssClass="select-control" AutoPostBack="true" OnSelectedIndexChanged="FilterSort_Changed">
                        <asp:ListItem Text="All Responses" Value="All"></asp:ListItem>
                        <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                        <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
                    </asp:DropDownList>

                    <asp:DropDownList ID="ddlSort" runat="server" CssClass="select-control" AutoPostBack="true" OnSelectedIndexChanged="FilterSort_Changed">
                        <asp:ListItem Text="Newest First" Value="DESC"></asp:ListItem>
                        <asp:ListItem Text="Oldest First" Value="ASC"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="grid-container glass">
                    <asp:GridView ID="gvResponses" runat="server" AutoGenerateColumns="false" 
                        CssClass="styled-table" GridLines="None" 
                        OnRowCommand="gvResponses_RowCommand" DataKeyNames="response_id">
                        <Columns>
                            <asp:BoundField DataField="player_name" HeaderText="Name" />
                            <asp:BoundField DataField="department" HeaderText="Department" />
                            <asp:BoundField DataField="game" HeaderText="Game" />
                            <asp:BoundField DataField="message" HeaderText="Message" />
                            <asp:BoundField DataField="submitted_date" HeaderText="Date" DataFormatString="{0:MMM dd, yyyy HH:mm}" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='<%# Eval("status").ToString() == "Completed" ? "status-badge status-completed" : "status-badge status-pending" %>'>
                                        <%# Eval("status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnComplete" runat="server" 
                                        CommandName="Complete" CommandArgument='<%# Eval("response_id") %>' 
                                        CssClass="action-btn btn-success" ToolTip="Mark as Completed"
                                        Visible='<%# Eval("status").ToString() != "Completed" %>'>
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5" /></svg>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" 
                                        CommandName="DeleteItem" CommandArgument='<%# Eval("response_id") %>' 
                                        CssClass="action-btn btn-danger" ToolTip="Delete Record"
                                        OnClientClick="return confirm('Are you sure you want to delete this response?');">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" /></svg>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div style="padding: 2rem; text-align: center; color: var(--text-muted);">
                                No form responses found matching the current criteria.
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </main>
        </div>
    </form>
</body>
</html>
