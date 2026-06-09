<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GamesManagement.aspx.cs" Inherits="admin_GamesManagement" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Games Management - KUET Cyborg</title>
    <link href="../styles/admin.css" rel="stylesheet" />
    <style>
        .nav-item { display: flex; align-items: center; }
        .action-btn { display: inline-flex; align-items: center; justify-content: center; width: 28px; height: 28px; padding: 0; border-radius: 6px; }
        .action-btn svg { width: 16px; height: 16px; }
        .form-row { display: flex; gap: 1rem; margin-bottom: 1rem; }
        .form-row .form-group { flex: 1; margin-bottom: 0; }
        .modal-bg { position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.7); display: flex; align-items: center; justify-content: center; z-index: 1000; }
        .modal-content { background: var(--card-bg); padding: 2rem; border-radius: 12px; width: 100%; max-width: 600px; border: 1px solid var(--border-color); backdrop-filter: blur(12px); }
        .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; }
        .modal-header h3 { margin: 0; color: white; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="sidebar-logo">KUET Cyborg</div>
                <nav>
                    <a href="AdminPanel.aspx" class="nav-item">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" style="width: 1.25rem; height: 1.25rem; display: inline-block; vertical-align: text-bottom; margin-right: 0.5rem;"><path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z" /></svg>
                        Form Responses
                    </a>
                    <a href="GamesManagement.aspx" class="nav-item active">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" style="width: 1.25rem; height: 1.25rem; display: inline-block; vertical-align: text-bottom; margin-right: 0.5rem;"><path stroke-linecap="round" stroke-linejoin="round" d="M14.25 6.087c0-.355.186-.676.401-.959.221-.29.349-.634.349-1.003 0-1.036-1.007-1.875-2.25-1.875s-2.25.84-2.25 1.875c0 .369.128.713.349 1.003.215.283.401.604.401.959v0a1.5 1.5 0 01-1.5 1.5H8.25m5.25 0h.75m-6 0h.75m1.5 0H8.25M8.25 6.087v0a1.5 1.5 0 00-1.5-1.5M15.75 6.087v0a1.5 1.5 0 011.5-1.5M6 18h12a2.25 2.25 0 002.25-2.25V10.5a2.25 2.25 0 00-2.25-2.25H6a2.25 2.25 0 00-2.25 2.25v5.25A2.25 2.25 0 006 18z" /></svg>
                        Games Management
                    </a>
                </nav>
                <div class="sidebar-footer">
                    <asp:LinkButton ID="lnkLogout" runat="server" CssClass="logout-btn" OnClick="lnkLogout_Click">Logout</asp:LinkButton>
                </div>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                <div class="page-header">
                    <h1 class="page-title">Games Management</h1>
                    <asp:Button ID="btnAdd" runat="server" Text="+ Add Game" CssClass="btn btn-primary" style="width: auto;" OnClick="btnAdd_Click" />
                </div>

                <div class="grid-container glass">
                    <asp:GridView ID="gvGames" runat="server" AutoGenerateColumns="false" 
                        CssClass="styled-table" GridLines="None" 
                        OnRowCommand="gvGames_RowCommand" DataKeyNames="id">
                        <Columns>
                            <asp:TemplateField HeaderText="Image">
                                <ItemTemplate>
                                    <img src='<%# Eval("image_url") %>' alt="" style="width: 60px; height: 35px; object-fit: cover; border-radius: 4px;" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="title" HeaderText="Title" />
                            <asp:BoundField DataField="category" HeaderText="Category" />
                            <asp:BoundField DataField="badge" HeaderText="Badge" />
                            <asp:BoundField DataField="tags" HeaderText="Tags" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" 
                                        CommandName="EditGame" CommandArgument='<%# Eval("id") %>' 
                                        CssClass="action-btn btn-success" ToolTip="Edit Game">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L6.832 19.82a4.5 4.5 0 01-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 011.13-1.897L16.863 4.487zm0 0L19.5 7.125" /></svg>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" 
                                        CommandName="DeleteGame" CommandArgument='<%# Eval("id") %>' 
                                        CssClass="action-btn btn-danger" ToolTip="Delete Game"
                                        OnClientClick="return confirm('Are you sure you want to delete this game?');">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" /></svg>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <!-- Edit/Add Modal -->
                <asp:Panel ID="pnlModal" runat="server" CssClass="modal-bg" Visible="false">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3><asp:Literal ID="litModalTitle" runat="server" Text="Add Game"></asp:Literal></h3>
                            <asp:LinkButton ID="btnCloseModal" runat="server" OnClick="btnCloseModal_Click" style="color:var(--text-muted); text-decoration:none;">✕</asp:LinkButton>
                        </div>
                        <asp:HiddenField ID="hfGameId" runat="server" />
                        <div class="form-row">
                            <div class="form-group">
                                <label>Title</label>
                                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>Category (e.g. pc esports)</label>
                                <asp:TextBox ID="txtCategory" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label>Badge (e.g. PC)</label>
                                <asp:TextBox ID="txtBadge" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>Tags (comma separated)</label>
                                <asp:TextBox ID="txtTags" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Image URL</label>
                            <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Description</label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnSave" runat="server" Text="Save Game" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                    </div>
                </asp:Panel>

            </main>
        </div>
    </form>
</body>
</html>
