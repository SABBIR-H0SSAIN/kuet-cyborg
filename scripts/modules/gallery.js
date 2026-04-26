document.addEventListener('DOMContentLoaded', () => {
  const galleryGrid = document.getElementById('galleryGrid');
  if (!galleryGrid) return;

  const galleryData = CONFIG.gallery || [];

  const galleryImages = [];

  galleryData.forEach((item, index) => {
    const imgCanvas = document.createElement('canvas');
    imgCanvas.width = 640;
    imgCanvas.height = 400;
    const imgCtx = imgCanvas.getContext('2d');

    const grad = imgCtx.createLinearGradient(0, 0, 640, 400);
    grad.addColorStop(0, item.color);
    grad.addColorStop(1, '#050508');
    imgCtx.fillStyle = grad;
    imgCtx.fillRect(0, 0, 640, 400);

    imgCtx.strokeStyle = item.accent + '15';
    imgCtx.lineWidth = 1;
    for (let x = 0; x < 640; x += 40) {
      imgCtx.beginPath(); imgCtx.moveTo(x, 0); imgCtx.lineTo(x, 400); imgCtx.stroke();
    }
    for (let y = 0; y < 400; y += 40) {
      imgCtx.beginPath(); imgCtx.moveTo(0, y); imgCtx.lineTo(640, y); imgCtx.stroke();
    }

    for (let i = 0; i < 5; i++) {
      const cx = Math.random() * 640;
      const cy = Math.random() * 400;
      const r = Math.random() * 60 + 20;
      imgCtx.beginPath();
      imgCtx.arc(cx, cy, r, 0, Math.PI * 2);
      imgCtx.strokeStyle = item.accent + '20';
      imgCtx.lineWidth = 1;
      imgCtx.stroke();
    }

    imgCtx.font = '80px serif';
    imgCtx.textAlign = 'center';
    imgCtx.textBaseline = 'middle';
    imgCtx.fillText(item.icon, 320, 180);

    imgCtx.font = '600 24px Rajdhani, sans-serif';
    imgCtx.fillStyle = item.accent;
    imgCtx.fillText(item.title, 320, 300);

    imgCtx.font = '12px "Share Tech Mono", monospace';
    imgCtx.fillStyle = '#ffffff30';
    imgCtx.fillText('CYBORG — KUET', 320, 370);

    const dataUrl = imgCanvas.toDataURL('image/png');
    galleryImages.push(dataUrl);

    const galleryItem = document.createElement('div');
    galleryItem.className = 'gallery-item reveal-scale';
    galleryItem.innerHTML = `
      <img src="${dataUrl}" alt="${item.title}" loading="lazy" />
      <div class="gallery-item-overlay">
        <span>${item.title}</span>
      </div>
    `;
    galleryItem.addEventListener('click', () => openLightbox(index));
    galleryGrid.appendChild(galleryItem);
  });

  // Re-observe gallery items if intersection observer exists
  if (typeof window.revealObserver !== 'undefined') {
    document.querySelectorAll('.gallery-item.reveal-scale').forEach(el => window.revealObserver.observe(el));
  }

  // Lightbox
  const lightbox = document.getElementById('lightbox');
  const lightboxImg = document.getElementById('lightboxImg');
  const lightboxClose = document.getElementById('lightboxClose');
  const lightboxPrev = document.getElementById('lightboxPrev');
  const lightboxNext = document.getElementById('lightboxNext');
  let currentLightboxIndex = 0;

  function openLightbox(index) {
    currentLightboxIndex = index;
    lightboxImg.src = galleryImages[index];
    lightbox.classList.add('active');
    document.body.classList.add('no-scroll');
  }

  function closeLightbox() {
    lightbox.classList.remove('active');
    document.body.classList.remove('no-scroll');
  }

  lightboxClose.addEventListener('click', closeLightbox);
  lightbox.addEventListener('click', (e) => {
    if (e.target === lightbox) closeLightbox();
  });

  lightboxPrev.addEventListener('click', (e) => {
    e.stopPropagation();
    currentLightboxIndex = (currentLightboxIndex - 1 + galleryImages.length) % galleryImages.length;
    lightboxImg.src = galleryImages[currentLightboxIndex];
  });

  lightboxNext.addEventListener('click', (e) => {
    e.stopPropagation();
    currentLightboxIndex = (currentLightboxIndex + 1) % galleryImages.length;
    lightboxImg.src = galleryImages[currentLightboxIndex];
  });

  document.addEventListener('keydown', (e) => {
    if (!lightbox.classList.contains('active')) return;
    if (e.key === 'Escape') closeLightbox();
    if (e.key === 'ArrowLeft') lightboxPrev.click();
    if (e.key === 'ArrowRight') lightboxNext.click();
  });
});
