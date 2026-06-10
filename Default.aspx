<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<!DOCTYPE html>
<html lang="en">

<head runat="server">
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Cyborg</title>
  <meta name="description"
    content="Cyborg is the premier esports gaming club of KUET. We game, therefore we are. Join the elite squad of competitive gamers." />
  <meta name="keywords" content="esports, gaming club, KUET, Cyborg, competitive gaming, university esports" />
  <link rel="stylesheet" href="styles/base.css" />
  <link rel="stylesheet" href="styles/components.css" />
  <link rel="stylesheet" href="styles/sections/hero.css" />
  <link rel="stylesheet" href="styles/sections/about.css" />
  <link rel="stylesheet" href="styles/sections/achievements.css" />
  <link rel="stylesheet" href="styles/sections/games.css" />
  <link rel="stylesheet" href="styles/sections/team.css" />
  <link rel="stylesheet" href="styles/sections/events.css" />
  <link rel="stylesheet" href="styles/sections/gallery.css" />
  <link rel="stylesheet" href="styles/sections/community.css" />
  <link rel="stylesheet" href="styles/sections/contact.css" />
  <link rel="stylesheet" href="styles/sections/footer.css" />
  <link rel="stylesheet" href="styles/sections/about-logo.css?v=2" />
  <link rel="stylesheet" href="styles/sections.css" />
  <link rel="icon" type="image/png" href="assets/logos/cybrog-logo-rounded.png" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <style>
    /* FORCE SYSTEM CURSOR — overrides all external CSS including cached files */
    *, *::before, *::after,
    html, body, div, canvas, section, nav, header, footer,
    a, button, span, p, h1, h2, h3, h4, h5, h6,
    input, select, textarea, label, img, ul, li, form {
      cursor: auto !important;
    }
  </style>
</head>

<body>

  <form id="mainForm" runat="server">

    <!-- Loading Screen -->
    <div class="loader-screen" id="loader">
      <div class="loader-logo">
        <img src="assets/logos/cybrog-logo.jpg" alt="Cyborg Logo" class="loader-logo-img" />
        CYBORG
      </div>
      <div class="loader-bar-container">
        <div class="loader-bar"></div>
      </div>
      <div class="loader-text">INITIALIZING SYSTEM...</div>
    </div>

    <!-- Navbar -->
    <nav class="navbar" id="navbar">
      <div class="nav-container">
        <a href="#hero" class="nav-logo">
          <img src="assets/logos/cybrog-logo.jpg" alt="Cyborg Logo" class="nav-logo-img" />
          CYBORG
        </a>
        <div class="nav-links" id="navLinks">
          <a href="#about">About</a>
          <a href="#achievements">Stats</a>
          <a href="#games">Games</a>
          <a href="#team">Team</a>
          <a href="#events">Events</a>
          <a href="#gallery">Gallery</a>
          <a href="#community">Community</a>
          <a href="#contact">Join</a>
        </div>
        <div class="hamburger" id="hamburger">
          <span></span>
          <span></span>
          <span></span>
        </div>
      </div>
    </nav>

    <!-- Hero Section -->
    <section id="hero">
      <canvas id="hero-canvas"></canvas>
      <div class="hero-grid-overlay"></div>
      <div class="hero-gradient-overlay"></div>

      <div class="hero-scanline"></div>

      <div class="hero-content hero-split">
        <!-- LEFT: Content -->
        <div class="hero-left">

          <h1 class="hero-title">
            <span class="line">We Game,</span>
            <span class="line"><span class="highlight">Therefore We Are.</span></span>
          </h1>
          <p class="hero-subtitle">
            <span id="typed-text"></span><span class="cursor"></span>
          </p>
          <div class="hero-cta-group">
            <a href="#contact" class="btn-neon btn-primary">ENTER THE LOBBY</a>
            <a href="#achievements" class="btn-neon btn-outline">View Achievements</a>
          </div>


        </div>

        <!-- RIGHT: Logo Visual -->
        <div class="hero-right">
          <div class="hero-logo-frame">
            <div class="logo-ring logo-ring-1"></div>
            <div class="logo-ring logo-ring-2"></div>
            <div class="logo-ring logo-ring-3"></div>
            <img src="assets/logos/cybrog-logo.jpg" alt="Cyborg Logo" class="hero-logo-img" />
            <div class="logo-pulse"></div>
          </div>
        </div>
      </div>

      <div class="hero-scroll-indicator">
        <span>Scroll</span>
        <div class="scroll-arrow"></div>
      </div>
    </section>

    <!-- About Section -->
    <section id="about">
      <div class="container">
        <div class="about-grid">
          <div class="about-visual reveal-left">
            <div class="about-logo-box">
              <div class="about-logo-ring"></div>
              <div class="about-logo-corners"></div>
              <img src="assets/logos/cybrog-logo.jpg" alt="Cyborg Logo" class="about-logo-img" />
              <div class="about-logo-glow"></div>
            </div>
          </div>
          <div class="about-text reveal-right">
            <span class="section-tag">// who we are</span>
            <h3>More Than a Club. <span>A Brotherhood.</span></h3>
            <div class="about-desc-wrapper">
              <p>
                Cyborg &mdash; Cyber Gaming Club of KUET is more than just a gaming club. We are a community of
                passionate gamers, strategists, and competitors united by our love for the game. Founded at
                Khulna University of Engineering &amp; Technology, we represent the cutting edge of university esports.
              </p>
              <p>
                From late-night scrimmages to championship stages, we train hard, play harder, and build
                lifelong bonds through the fires of competition. Whether it's FPS, MOBA, Battle Royale,
                or Mobile Esports &mdash; Cyborg dominates.
              </p>
            </div>
            <div class="about-stats-row">
              <div class="about-stat">
                <span class="stat-num">2011</span>
                <span class="stat-label">Founded</span>
              </div>
              <div class="about-stat">
                <span class="stat-num">500+</span>
                <span class="stat-label">Members</span>
              </div>
              <div class="about-stat">
                <span class="stat-num">#100+</span>
                <span class="stat-label">Battle Won</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Achievements Section -->
    <section id="achievements">
      <div class="container">
        <div class="section-header reveal">
          <span class="section-tag">// our record</span>
          <h2 class="section-title">Battle <span>Statistics</span></h2>
          <div class="section-line"></div>
        </div>
        <div class="achievements-grid">
        </div>
      </div>
    </section>

    <!-- Games Section -->
    <section id="games">
      <div class="container">
        <div class="section-header reveal">
          <span class="section-tag">// our arsenal</span>
          <h2 class="section-title">Games We <span>Dominate</span></h2>
          <div class="section-line"></div>
          <p class="section-desc">From tactical FPS to intense mobile battles, Cyborg competes across every major title.
          </p>
        </div>
          <div class="games-tabs reveal">
            <button type="button" class="game-tab active" data-filter="all">All Games</button>
            <button type="button" class="game-tab" data-filter="pc">PC</button>
            <button type="button" class="game-tab" data-filter="mobile">Mobile</button>
            <button type="button" class="game-tab" data-filter="esports">Esports</button>
          </div>
        <div class="games-grid">
          <asp:Repeater ID="rptGames" runat="server">
            <ItemTemplate>
              <div class="game-card reveal" data-category='<%# Eval("category") %>'>
                <div class="game-card-image" style="background-image: url('<%# Eval("image_url") %>')"></div>
                <span class="game-card-badge"><%# Eval("badge") %></span>
                <div class="game-card-body">
                  <h4><%# Eval("title") %></h4>
                  <p><%# Eval("description") %></p>
                </div>
                <div class="game-card-footer">
                  <%# GetTagsHtml(Eval("tags")) %>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
      </div>
    </section>

    <!-- Team Section -->
    <section id="team">
      <div class="container">
        <div class="section-header reveal">
          <span class="section-tag">// the roster</span>
          <h2 class="section-title">Meet the <span>Squad</span></h2>
          <div class="section-line"></div>
          <p class="section-desc">The masterminds and warriors behind Cyborg's dominance.</p>
        </div>
        <div class="team-grid"></div>
      </div>
    </section>

    <!-- Events Section -->
    <section id="events">
      <div class="container">
        <div class="section-header reveal">
          <span class="section-tag">// battle log</span>
          <h2 class="section-title">Events &amp; <span>Tournaments</span></h2>
          <div class="section-line"></div>
        </div>
        <div class="events-timeline">
          <asp:Repeater ID="rptEvents" runat="server">
            <ItemTemplate>
              <div class="event-item reveal-<%# Eval("alignment") %>">
                <div class="event-dot"></div>
                <div class="event-content">
                  <span class="event-date"><%# Eval("event_date") %></span>
                  <span class="event-status <%# Eval("status") %>"><%# Eval("status") %></span>
                  <h4><%# Eval("title") %></h4>
                  <p><%# Eval("description") %></p>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
      </div>
    </section>

    <!-- Gallery Section -->
    <section id="gallery">
      <div class="container">
        <div class="section-header reveal">
          <span class="section-tag">// highlights</span>
          <h2 class="section-title">Battle <span>Gallery</span></h2>
          <div class="section-line"></div>
        </div>
        <div class="gallery-grid" id="galleryGrid"></div>
      </div>
    </section>

    <!-- Community Section -->
    <section id="community">
      <div class="container">
        <div class="section-header reveal">
          <span class="section-tag">// connect</span>
          <h2 class="section-title">Join the <span>Network</span></h2>
          <div class="section-line"></div>
        </div>
        <div class="community-grid">
          <div class="community-card reveaonl">
            <span class="community-icon"><i class="fab fa-discord"></i></span>
            <h4>Discord Server</h4>
            <p>Join 200+ gamers in our active Discord community. Voice chat, scrims, memes, and more.</p>
            <a href="#" class="community-link">Join Server →</a>
          </div>
          <div class="community-card reveal">
            <span class="community-icon"><i class="fab fa-facebook-f"></i></span>
            <h4>Facebook Page</h4>
            <p>Follow us for event announcements, highlights, and behind-the-scenes content.</p>
            <a href="#" class="community-link">Follow Us →</a>
          </div>
          <div class="community-card reveal">
            <span class="community-icon"><i class="fab fa-instagram"></i></span>
            <h4>Instagram</h4>
            <p>Reels, stories, and tournament highlights. See Cyborg in action.</p>
            <a href="#" class="community-link">Follow Us →</a>
          </div>
          <div class="community-card reveal">
            <span class="community-icon"><i class="fab fa-youtube"></i></span>
            <h4>YouTube Channel</h4>
            <p>Watch tournament VODs, gameplay highlights, and behind-the-scenes content.</p>
            <a href="#" class="community-link">Subscribe →</a>
          </div>
        </div>
        <div class="community-cta reveal">
          <h3>Ready to Level Up?</h3>
          <p>Cyborg isn't just a club &mdash; it's a movement. Be part of KUET's most elite gaming community.</p>
          <a href="#contact" class="btn-neon btn-primary">ENTER THE LOBBY</a>
        </div>
      </div>
    </section>

    <!-- Contact Section -->
    <section id="contact">
      <div class="container">
        <div class="section-header reveal">
          <span class="section-tag">// recruit</span>
          <h2 class="section-title">Join the <span>Squad</span></h2>
          <div class="section-line"></div>
        </div>
        <div class="contact-wrapper">
          <div class="contact-info reveal-left">
            <h3>Recruitment Open</h3>
            <p>
              Think you've got what it takes? Fill out the form and our team will
              reach out. All skill levels welcome — from casuals to sweats.
            </p>
            <div class="contact-detail">
              <div class="contact-detail-icon"><i class="fas fa-map-marker-alt"></i></div>
              <span>KUET Campus, Khulna, Bangladesh</span>
            </div>
            <div class="contact-detail">
              <div class="contact-detail-icon"><i class="fas fa-envelope"></i></div>
              <span>cyborg@kuet.club</span>
            </div>
            <div class="contact-detail">
              <div class="contact-detail-icon"><i class="fab fa-discord"></i></div>
              <span>discord.gg/cyborg-kuet</span>
            </div>
            <div class="contact-detail">
              <div class="contact-detail-icon"><i class="fas fa-clock"></i></div>
              <span>Responses within 48 hours</span>
            </div>
          </div>

          <!-- ASP.NET Web Forms contact form -->
          <div class="contact-form reveal-right">
            <h4 class="form-header">Player Registration</h4>
            <p class="form-subheader">// Initialize recruitment protocol</p>
            <div class="form-group">
              <label for="txtName">Player Name</label>
              <asp:TextBox ID="txtName" runat="server" placeholder="Enter your IGN or real name" CssClass="aspx-input" />
              <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                ErrorMessage="Player name is required." CssClass="field-validation-error" Display="Dynamic" />
            </div>
            <div class="form-group">
              <label for="txtDepartment">Department</label>
              <asp:TextBox ID="txtDepartment" runat="server" placeholder="e.g. CSE, EEE, ME" CssClass="aspx-input" />
              <asp:RequiredFieldValidator ID="rfvDept" runat="server" ControlToValidate="txtDepartment"
                ErrorMessage="Department is required." CssClass="field-validation-error" Display="Dynamic" />
            </div>
            <div class="form-group">
              <label for="ddlGame">Primary Game</label>
              <asp:DropDownList ID="ddlGame" runat="server" CssClass="aspx-select">
                <asp:ListItem Value="" Text="Select your main game" />
                <asp:ListItem Value="valorant" Text="Valorant" />
                <asp:ListItem Value="pubg-mobile" Text="PUBG Mobile" />
                <asp:ListItem Value="cs2" Text="CS2" />
                <asp:ListItem Value="lol" Text="League of Legends" />
                <asp:ListItem Value="dota2" Text="Dota 2" />
                <asp:ListItem Value="free-fire" Text="Free Fire" />
                <asp:ListItem Value="other" Text="Other" />
              </asp:DropDownList>
              <asp:RequiredFieldValidator ID="rfvGame" runat="server" ControlToValidate="ddlGame"
                InitialValue="" ErrorMessage="Please select a game." CssClass="field-validation-error" Display="Dynamic" />
            </div>
            <div class="form-group">
              <label for="txtMessage">Why Cyborg?</label>
              <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="3"
                placeholder="Tell us why you want to join the squad..." CssClass="aspx-input" />
            </div>
            <asp:Button ID="btnSubmit" runat="server" Text="⚡ Submit Application"
              CssClass="form-submit" OnClick="btnSubmit_Click" UseSubmitBehavior="true" />
            <asp:Label ID="lblResponse" runat="server" CssClass="form-response" Visible="false"
              Text="✅ Application received! We'll contact you on Discord." />
          </div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
      <div class="container">
        <div class="footer-grid">
          <div class="footer-brand">
            <div class="footer-logo-wrap">
              <img src="assets/logos/cybrog-logo.jpg" alt="Cyborg Logo" class="footer-logo-img" />
              <h3>Cyborg</h3>
            </div>
            <p>The premier esports club of KUET. Building champions, one game at a time.</p>
          </div>
          <div class="footer-group">
            <h4>Navigate</h4>
            <a href="#about">About</a>
            <a href="#achievements">Stats</a>
            <a href="#games">Games</a>
            <a href="#team">Team</a>
          </div>
          <div class="footer-group">
            <h4>Connect</h4>
            <a href="#"><i class="fab fa-discord"></i> Discord</a>
            <a href="#"><i class="fab fa-facebook-f"></i> Facebook</a>
            <a href="#"><i class="fab fa-instagram"></i> Instagram</a>
            <a href="#"><i class="fab fa-youtube"></i> YouTube</a>
          </div>
          <div class="footer-group">
            <h4>More</h4>
            <a href="#events">Events</a>
            <a href="#gallery">Gallery</a>
            <a href="#contact">Join</a>
          </div>
        </div>
        <div class="footer-bottom">
          <p>&copy; <%= DateTime.Now.Year %> Cyborg &mdash; Cyber Gaming Club of KUET</p>
        </div>
      </div>
    </footer>

    <!-- Lightbox -->
    <div class="lightbox" id="lightbox">
      <div class="lightbox-close" id="lightboxClose">✕</div>
      <div class="lightbox-nav lightbox-prev" id="lightboxPrev">‹</div>
      <div class="lightbox-nav lightbox-next" id="lightboxNext">›</div>
      <img src="" alt="Gallery Image" id="lightboxImg" />
    </div>

    <script src="scripts/config.js?v=2"></script>
    <script src="scripts/main.js?v=2"></script>
    <script src="scripts/modules/particles.js"></script>
    <script src="scripts/modules/gallery.js"></script>


    <!-- Fix ASP.NET WebForms postback anchor scroll jump -->
    <script>
      // Preserve smooth scroll on PostBack (form submit scrolls back to #contact)
      window.addEventListener('load', function () {
        var response = document.getElementById('<%= lblResponse.ClientID %>');
        if (response && response.style.display !== 'none') {
          response.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
      });
    </script>

  </form>
</body>

</html>

<!-- touch -->
