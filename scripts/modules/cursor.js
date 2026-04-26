document.addEventListener('DOMContentLoaded', () => {
  if (window.innerWidth <= 768) return;

  const cursor = document.createElement('div');
  cursor.className = 'custom-cursor hidden';
  document.body.appendChild(cursor);

  let cursorX = window.innerWidth / 2;
  let cursorY = window.innerHeight / 2;
  let isVisible = false;

  document.addEventListener('mousemove', (e) => {
    cursorX = e.clientX;
    cursorY = e.clientY;
    if (!isVisible) {
      cursor.classList.remove('hidden');
      isVisible = true;
    }
  }, { passive: true });

  document.addEventListener('mouseenter', () => {
    cursor.classList.remove('hidden');
    isVisible = true;
  });

  document.addEventListener('mouseleave', () => {
    cursor.classList.add('hidden');
    isVisible = false;
  });

  function renderCursor() {
    cursor.style.transform = `translate3d(${cursorX}px, ${cursorY}px, 0) translate(-50%, -50%)`;
    requestAnimationFrame(renderCursor);
  }
  requestAnimationFrame(renderCursor);

  const interactiveSelectors = 'a, button, input, select, textarea, [role="button"], .game-card, .team-card, .community-card, .gallery-item, .lightbox-nav, .lightbox-close, .game-tab, .hamburger, .snake-overlay, .form-submit, .btn-neon';

  document.body.addEventListener('mouseover', (e) => {
    if (e.target.closest(interactiveSelectors)) {
      cursor.classList.add('hovering');
    }
  });

  document.body.addEventListener('mouseout', (e) => {
    if (e.target.closest(interactiveSelectors)) {
      cursor.classList.remove('hovering');
    }
  });
});
