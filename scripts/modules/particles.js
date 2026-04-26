document.addEventListener('DOMContentLoaded', () => {
  const canvas = document.getElementById('hero-canvas');
  if (!canvas) return;
  const ctx = canvas.getContext('2d');
  let particlesArray = [];
  let mouseX = 0;
  let mouseY = 0;

  function resizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
  }
  resizeCanvas();
  window.addEventListener('resize', resizeCanvas);

  document.addEventListener('mousemove', (e) => {
    mouseX = e.clientX;
    mouseY = e.clientY;
  }, { passive: true });

  class Particle {
    constructor() {
      this.x = Math.random() * canvas.width;
      this.y = Math.random() * canvas.height;
      this.size = Math.random() * 2 + 0.5;
      this.speedX = (Math.random() - 0.5) * 0.8;
      this.speedY = (Math.random() - 0.5) * 0.8;
      this.opacity = Math.random() * 0.5 + 0.2;
      const colors = [
        'rgba(0, 240, 255,',   // cyan
        'rgba(176, 38, 255,',  // purple
        'rgba(255, 45, 149,',  // pink
        'rgba(57, 255, 20,',   // green
      ];
      this.color = colors[Math.floor(Math.random() * colors.length)];
    }

    update() {
      this.x += this.speedX;
      this.y += this.speedY;

      // Mouse attraction
      const dx = mouseX - this.x;
      const dy = mouseY - this.y;
      const distSq = dx * dx + dy * dy;
      if (distSq < 40000) { 
        this.x += dx * 0.002;
        this.y += dy * 0.002;
      }
      
      if (this.x < 0) this.x = canvas.width;
      if (this.x > canvas.width) this.x = 0;
      if (this.y < 0) this.y = canvas.height;
      if (this.y > canvas.height) this.y = 0;
    }

    draw() {
      ctx.beginPath();
      ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
      ctx.fillStyle = this.color + this.opacity + ')';
      ctx.fill();
    }
  }

  function initParticles() {
    particlesArray = [];
    const count = Math.min(window.innerWidth * 0.08, 120);
    for (let i = 0; i < count; i++) {
      particlesArray.push(new Particle());
    }
  }

  function connectParticles() {
    const len = particlesArray.length;
    const maxDistSq = 16900;
    ctx.lineWidth = 0.5;
    for (let a = 0; a < len; a++) {
      const pa = particlesArray[a];
      for (let b = a + 1; b < len; b++) {
        const pb = particlesArray[b];
        const dx = pa.x - pb.x;
        const dy = pa.y - pb.y;
        const distSq = dx * dx + dy * dy;

        if (distSq < maxDistSq) {
          const dist = Math.sqrt(distSq);
          const opacity = (1 - dist / 130) * 0.15;
          ctx.strokeStyle = `rgba(0, 240, 255, ${opacity})`;
          ctx.beginPath();
          ctx.moveTo(pa.x, pa.y);
          ctx.lineTo(pb.x, pb.y);
          ctx.stroke();
        }
      }
    }
  }

  let particlesRunning = true;
  document.addEventListener('visibilitychange', () => {
    if (document.hidden) {
      particlesRunning = false;
    } else {
      particlesRunning = true;
      requestAnimationFrame(animateParticles);
    }
  });

  function animateParticles() {
    if (!particlesRunning) return;
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    for (const p of particlesArray) {
      p.update();
      p.draw();
    }
    connectParticles();
    requestAnimationFrame(animateParticles);
  }

  initParticles();
  animateParticles();
});
