document.addEventListener('DOMContentLoaded', () => {
// Loading Screen
  const loader = document.getElementById('loader');
  window.addEventListener('load', () => {
    setTimeout(() => {
      loader.classList.add('hidden');
    }, 2200);
  });

  setTimeout(() => {
    loader.classList.add('hidden');
  }, 4000);


  renderDynamicLists();



  // Typing Effect
  const typedTextEl = document.getElementById('typed-text');
  const phrases = CONFIG.phrases || [];
  let phraseIndex = 0;
  let charIndex = 0;
  let isDeleting = false;
  let typingSpeed = 60;

  function typeEffect() {
    if (phrases.length === 0) return;
    const current = phrases[phraseIndex];

    if (!isDeleting) {
      typedTextEl.textContent = current.substring(0, charIndex + 1);
      charIndex++;

      if (charIndex === current.length) {
        isDeleting = true;
        typingSpeed = 2000; 
      } else {
        typingSpeed = 60 + Math.random() * 40;
      }
    } else {
      typedTextEl.textContent = current.substring(0, charIndex - 1);
      charIndex--;
      typingSpeed = 30;

      if (charIndex === 0) {
        isDeleting = false;
        phraseIndex = (phraseIndex + 1) % phrases.length;
        typingSpeed = 400;
      }
    }

    setTimeout(typeEffect, typingSpeed);
  }

  setTimeout(typeEffect, 2500); 



  // Navbar Effects
  const navbar = document.getElementById('navbar');
  const navLinks = document.querySelectorAll('.nav-links a');
  const sections = document.querySelectorAll('section[id]');

  function handleNavScroll() {
    if (window.scrollY > 80) {
      navbar.classList.add('scrolled');
    } else {
      navbar.classList.remove('scrolled');
    }

    // Active link tracking
    let current = '';
    sections.forEach(section => {
      const top = section.offsetTop - 120;
      if (window.scrollY >= top) {
        current = section.getAttribute('id');
      }
    });

    navLinks.forEach(link => {
      link.classList.remove('active');
      if (link.getAttribute('href') === '#' + current) {
        link.classList.add('active');
      }
    });
  }

  window.addEventListener('scroll', handleNavScroll);
  handleNavScroll();



  // Hamburger Menu
  const hamburger = document.getElementById('hamburger');
  const navLinksContainer = document.getElementById('navLinks');

  hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('active');
    navLinksContainer.classList.toggle('open');
    document.body.classList.toggle('no-scroll');
  });

  navLinksContainer.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', () => {
      hamburger.classList.remove('active');
      navLinksContainer.classList.remove('open');
      document.body.classList.remove('no-scroll');
    });
  });




  function renderDynamicLists() {
    // 1. Achievements
    const achievementsGrid = document.querySelector('.achievements-grid');
    if (achievementsGrid && CONFIG.achievements) {
      achievementsGrid.innerHTML = CONFIG.achievements.map(item => `
        <div class="achievement-card reveal">
          <span class="achievement-icon">${item.icon}</span>
          <span class="achievement-number counter" data-target="${item.target}">0</span>
          <span class="achievement-label">${item.label}</span>
        </div>
      `).join('');
    }



    // 2. Games (Rendered via Server-Side Repeater)
    // No JS fetch needed.

    // 3. Team
    const teamGrid = document.querySelector('.team-grid');
    if (teamGrid && CONFIG.team) {
      teamGrid.innerHTML = CONFIG.team.map(member => `
        <div class="team-card reveal">
          <div class="team-avatar">${member.image ? `<img src="${member.image}" alt="${member.name}" style="width: 100%; height: 100%; object-fit: cover; transform: scale(1.5); transform-origin: top;" />` : member.initials}</div>
          <h4>${member.name}</h4>
          <span class="team-role">${member.role}</span>
          <div class="team-socials">
            <a href="${member.socials.facebook}" title="Facebook"><i class="fab fa-facebook-f"></i></a>
            <a href="${member.socials.discord}" title="Discord"><i class="fab fa-discord"></i></a>
            <a href="${member.socials.linkedin}" title="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
          </div>
        </div>
      `).join('');
    }

    // 4. Events (Rendered via Server-Side Repeater)
    // No JS rendering needed.

    setupObservers();
    setupFilters();
    setupTilt();
  }



  // Observers & UI Logic
  function setupObservers() {
    const revealElements = document.querySelectorAll('.reveal, .reveal-left, .reveal-right, .reveal-scale');
    const revealObserver = new IntersectionObserver((entries) => {
      entries.forEach((entry, index) => {
        if (entry.isIntersecting) {
          setTimeout(() => {
            entry.target.classList.add('active');
          }, index * 80);
          revealObserver.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });

    revealElements.forEach(el => revealObserver.observe(el));
    window.revealObserver = revealObserver;

    const counters = document.querySelectorAll('.counter');
    let countersAnimated = false;
    const counterObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting && !countersAnimated) {
          countersAnimated = true;
          animateCounters(counters);
          counterObserver.unobserve(entry.target);
        }
      });
    }, { threshold: 0.3 });
    counters.forEach(c => counterObserver.observe(c));
  }

  function animateCounters(counters) {
    counters.forEach(counter => {
      const target = parseInt(counter.getAttribute('data-target'));
      const duration = 2000;
      const increment = target / (duration / 16);
      let current = 0;
      function updateCounter() {
        current += increment;
        if (current < target) {
          counter.textContent = Math.ceil(current) + '+';
          requestAnimationFrame(updateCounter);
        } else {
          counter.textContent = target + '+';
        }
      }
      updateCounter();
    });
  }

  function setupFilters() {
    const gameTabs = document.querySelectorAll('.game-tab');
    const gameCards = document.querySelectorAll('.game-card');
    gameTabs.forEach(tab => {
      tab.addEventListener('click', () => {
        gameTabs.forEach(t => t.classList.remove('active'));
        tab.classList.add('active');
        const filter = tab.dataset.filter;
        gameCards.forEach(card => {
          const cats = card.dataset.category || '';
          if (filter === 'all' || cats.includes(filter)) {
            card.style.display = '';
            card.style.animation = 'fadeIn 0.5s ease forwards';
          } else {
            card.style.display = 'none';
          }
        });
      });
    });

    if (!document.getElementById('fadeInStyle')) {
      const styleSheet = document.createElement('style');
      styleSheet.id = 'fadeInStyle';
      styleSheet.textContent = `@keyframes fadeIn { from { opacity: 0; transform: translateY(16px) scale(0.96); } to { opacity: 1; transform: translateY(0) scale(1); } }`;
      document.head.appendChild(styleSheet);
    }

    // Trigger active filter initially
    const activeTab = document.querySelector('.game-tab.active');
    if (activeTab) {
      activeTab.click();
    }
  }

  function setupTilt() {
    if (window.innerWidth > 768) {
      document.querySelectorAll('.game-card, .team-card, .achievement-card').forEach(card => {
        card.addEventListener('mousemove', (e) => {
          const rect = card.getBoundingClientRect();
          const x = e.clientX - rect.left;
          const y = e.clientY - rect.top;
          const centerX = rect.width / 2;
          const centerY = rect.height / 2;
          const rotateX = (y - centerY) / centerY * -5;
          const rotateY = (x - centerX) / centerX * 5;
          card.style.transform = `perspective(800px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) translateY(-8px)`;
        });
        card.addEventListener('mouseleave', () => { card.style.transform = ''; });
      });
    }
  }

});
