<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Settings.aspx.cs" Inherits="admin_Settings" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings Management - KUET Cyborg</title>
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
        .settings-card { padding: 2rem; margin-bottom: 2rem; }
        .settings-section-title { font-size: 1.25rem; margin-top: 0; margin-bottom: 1.5rem; font-weight: 600; border-bottom: 1px solid var(--border-color); padding-bottom: 0.5rem; }
        .alert-success { background: rgba(16, 185, 129, 0.2); color: #6ee7b7; border: 1px solid rgba(16, 185, 129, 0.3); padding: 0.75rem 1rem; border-radius: 8px; margin-bottom: 1.5rem; display: block; }
        .alert-error { background: rgba(239, 68, 68, 0.2); color: #fca5a5; border: 1px solid rgba(239, 68, 68, 0.3); padding: 0.75rem 1rem; border-radius: 8px; margin-bottom: 1.5rem; display: block; }
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
                    <a href="GamesManagement.aspx" class="nav-item">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" style="width: 1.25rem; height: 1.25rem; display: inline-block; vertical-align: text-bottom; margin-right: 0.5rem;"><path stroke-linecap="round" stroke-linejoin="round" d="M14.25 6.087c0-.355.186-.676.401-.959.221-.29.349-.634.349-1.003 0-1.036-1.007-1.875-2.25-1.875s-2.25.84-2.25 1.875c0 .369.128.713.349 1.003.215.283.401.604.401.959v0a1.5 1.5 0 01-1.5 1.5H8.25m5.25 0h.75m-6 0h.75m1.5 0H8.25M8.25 6.087v0a1.5 1.5 0 00-1.5-1.5M15.75 6.087v0a1.5 1.5 0 011.5-1.5M6 18h12a2.25 2.25 0 002.25-2.25V10.5a2.25 2.25 0 00-2.25-2.25H6a2.25 2.25 0 00-2.25 2.25v5.25A2.25 2.25 0 006 18z" /></svg>
                        Games Management
                    </a>
                    <a href="EventsManagement.aspx" class="nav-item">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" style="width: 1.25rem; height: 1.25rem; display: inline-block; vertical-align: text-bottom; margin-right: 0.5rem;"><path stroke-linecap="round" stroke-linejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25m-18 0A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75m-18 0v-7.5A2.25 2.25 0 015.25 9h13.5A2.25 2.25 0 0121 11.25v7.5" /></svg>
                        Events Management
                    </a>
                    <a href="GalleryManagement.aspx" class="nav-item">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" style="width: 1.25rem; height: 1.25rem; display: inline-block; vertical-align: text-bottom; margin-right: 0.5rem;"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 15.75l5.159-5.159a2.25 2.25 0 013.182 0l5.159 5.159m-1.5-1.5l1.409-1.409a2.25 2.25 0 013.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 001.5-1.5V6a1.5 1.5 0 00-1.5-1.5H3.75A1.5 1.5 0 002.25 6v12a1.5 1.5 0 001.5 1.5zm10.5-11.25h.008v.008h-.008V8.25zm.375 0a.375 0 11-.75 0 .375 0 01.75 0z" /></svg>
                        Gallery Management
                    </a>
                    <a href="Settings.aspx" class="nav-item active">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" style="width: 1.25rem; height: 1.25rem; display: inline-block; vertical-align: text-bottom; margin-right: 0.5rem;"><path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.324.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 011.37.49l1.296 2.247a1.125 1.125 0 01-.26 1.43l-1.003.828c-.293.241-.438.613-.43.992a7.723 7.723 0 010 .255c-.008.378.137.75.43.991l1.004.827c.424.35.534.954.26 1.43l-1.298 2.247a1.125 1.125 0 01-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.47 6.47 0 01-.22.128c-.331.183-.581.495-.644.869l-.213 1.281c-.09.543-.56.94-1.11.94h-2.594c-.55 0-1.019-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 01-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 01-1.369-.49l-1.297-2.247a1.125 1.125 0 01.26-1.43l1.004-.827c.292-.24.437-.613.43-.991a6.932 6.932 0 010-.255c.007-.38-.138-.751-.43-.992l-1.004-.827a1.125 1.125 0 01-.26-1.43l1.297-2.247a1.125 1.125 0 011.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.086.22-.128.332-.183.582-.495.644-.869l.214-1.28Z" /><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /></svg>
                        Settings
                    </a>
                </nav>
                <div class="sidebar-footer">
                    <asp:LinkButton ID="lnkLogout" runat="server" CssClass="logout-btn" OnClick="lnkLogout_Click" CausesValidation="false">Logout</asp:LinkButton>
                </div>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                <div class="page-header">
                    <h1 class="page-title">Club Settings</h1>
                </div>

                <asp:Label ID="lblStatus" runat="server" Visible="false"></asp:Label>

                <!-- Social Links Card -->
                <div class="settings-card glass">
                    <h2 class="settings-section-title">Club Social Links</h2>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="txtDiscord">Discord Invite Link</label>
                            <asp:TextBox ID="txtDiscord" runat="server" CssClass="form-control" placeholder="https://discord.gg/..."></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtFacebook">Facebook Page Link</label>
                            <asp:TextBox ID="txtFacebook" runat="server" CssClass="form-control" placeholder="https://facebook.com/..."></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="txtInstagram">Instagram Profile Link</label>
                            <asp:TextBox ID="txtInstagram" runat="server" CssClass="form-control" placeholder="https://instagram.com/..."></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtYoutube">YouTube Channel Link</label>
                            <asp:TextBox ID="txtYoutube" runat="server" CssClass="form-control" placeholder="https://youtube.com/..."></asp:TextBox>
                        </div>
                    </div>
                    <div style="margin-top: 1.5rem; text-align: right;">
                        <asp:Button ID="btnSaveSocials" runat="server" Text="Save Social Links" CssClass="btn btn-primary" style="width: auto; padding: 0.75rem 2rem;" OnClick="btnSaveSocials_Click" />
                    </div>
                </div>

                <!-- Achievements Card -->
                <div class="settings-card glass">
                    <div class="page-header" style="margin-bottom:1rem; border-bottom: 1px solid var(--border-color); padding-bottom: 0.5rem;">
                        <h2 class="settings-section-title" style="border-bottom:none; margin-bottom:0; padding-bottom:0;">Battle Statistics</h2>
                    </div>

                    <div class="form-container">
                        <div class="form-row" style="flex-wrap: wrap;">
                            <asp:Repeater ID="rptStats" runat="server">
                                <ItemTemplate>
                                    <div class="form-group" style="flex: 1 1 45%; min-width: 250px;">
                                        <label><%# Eval("label") %></label>
                                        <asp:HiddenField ID="hfStatId" runat="server" Value='<%# Eval("id") %>' />
                                        <asp:TextBox ID="txtTarget" runat="server" CssClass="form-control" Text='<%# Eval("target") %>' type="number" min="0"></asp:TextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div style="margin-top: 1.5rem; text-align: right;">
                            <asp:Button ID="btnSaveStats" runat="server" Text="Save Statistics" CssClass="btn btn-primary" style="width: auto; padding: 0.75rem 2rem;" OnClick="btnSaveStats_Click" />
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </form>
</body>
</html>
