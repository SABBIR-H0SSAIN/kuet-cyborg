document.addEventListener('DOMContentLoaded', () => {
  const snakeCanvas = document.getElementById('snake-game');
  if (!snakeCanvas) return;

  const sCtx = snakeCanvas.getContext('2d');
  const snakeScoreEl = document.getElementById('snake-score-val');
  const snakeContainer = document.getElementById('snake-container');
  const playAgainBtn = document.getElementById('snake-play-again');

  const gridSize = 20;

  const logoImg = new Image();
  logoImg.src = 'assets/logos/cybrog-logo.jpg';
  let tileCountX, tileCountY;

  function resizeCanvas() {
    const rect = snakeContainer.getBoundingClientRect();
    snakeCanvas.width = Math.floor(rect.width / gridSize) * gridSize;
    snakeCanvas.height = Math.floor(rect.height / gridSize) * gridSize;
    tileCountX = snakeCanvas.width / gridSize;
    tileCountY = snakeCanvas.height / gridSize;
  }
  resizeCanvas();
  window.addEventListener('resize', resizeCanvas);

  let snake = [];
  let appleX, appleY;
  let velocityX = 1, velocityY = 0;
  let score = 0;
  let gameLoop;
  let isPlaying = false;
  let isGameOver = false;
  let gameFrame = 0;

  function spawnApple() {
    const margin = 2;
    appleX = margin + Math.floor(Math.random() * (tileCountX - margin * 2));
    appleY = margin + Math.floor(Math.random() * (tileCountY - margin * 2));
    for (const seg of snake) {
      if (seg.x === appleX && seg.y === appleY) { spawnApple(); return; }
    }
    const midX = tileCountX / 2;
    if (appleX > midX - 4 && appleX < midX + 4 && appleY < 3) {
      spawnApple(); return;
    }
  }

  function initSnake() {
    snake = [];
    const startX = Math.floor(tileCountX / 2);
    const startY = Math.floor(tileCountY / 2);
    for (let i = 0; i < 4; i++) {
      snake.push({ x: startX - i, y: startY });
    }
    velocityX = 1; velocityY = 0;
    score = 0;
    gameFrame = 0;
    isGameOver = false;
    snakeScoreEl.textContent = score;
    spawnApple();
    playAgainBtn.classList.add('hidden');
  }

  function drawGame() {
    gameFrame++;

    const headX = snake[0].x + velocityX;
    const headY = snake[0].y + velocityY;

    let newX = headX < 0 ? tileCountX - 1 : headX >= tileCountX ? 0 : headX;
    let newY = headY < 0 ? tileCountY - 1 : headY >= tileCountY ? 0 : headY;

    for (const seg of snake) {
      if (seg.x === newX && seg.y === newY) {
        isPlaying = false;
        isGameOver = true;
        clearTimeout(gameLoop);
        
        sCtx.fillStyle = 'rgba(5, 5, 8, 0.85)';
        sCtx.fillRect(0, 0, snakeCanvas.width, snakeCanvas.height);
        
        sCtx.font = 'bold 36px Rajdhani, sans-serif';
        sCtx.fillStyle = '#ff2d95';
        sCtx.textAlign = 'center';
        sCtx.shadowBlur = 10;
        sCtx.shadowColor = '#ff2d95';
        sCtx.fillText('GAME OVER', snakeCanvas.width / 2, snakeCanvas.height / 2 - 20);
        
        sCtx.font = '20px "Share Tech Mono", monospace';
        sCtx.fillStyle = '#00f0ff';
        sCtx.shadowColor = '#00f0ff';
        sCtx.fillText(`SCORE: ${score}`, snakeCanvas.width / 2, snakeCanvas.height / 2 + 15);
        sCtx.shadowBlur = 0;

        playAgainBtn.classList.remove('hidden');
        return;
      }
    }

    snake.unshift({ x: newX, y: newY });

    if (newX === appleX && newY === appleY) {
      score += 10;
      snakeScoreEl.textContent = score;
      spawnApple();
    } else {
      snake.pop();
    }

    sCtx.clearRect(0, 0, snakeCanvas.width, snakeCanvas.height);

    if (logoImg && logoImg.complete) {
      const imgRatio = logoImg.naturalWidth / logoImg.naturalHeight;
      const canvasRatio = snakeCanvas.width / snakeCanvas.height;
      let drawW, drawH;
      if (imgRatio > canvasRatio) {
        drawH = snakeCanvas.height;
        drawW = drawH * imgRatio;
      } else {
        drawW = snakeCanvas.width;
        drawH = drawW / imgRatio;
      }
      const lx = (snakeCanvas.width - drawW) / 2;
      const ly = (snakeCanvas.height - drawH) / 2;
      sCtx.globalAlpha = 0.18;
      sCtx.drawImage(logoImg, lx, ly, drawW, drawH);
      sCtx.globalAlpha = 1;
    }

    const pulseSize = 1 + Math.sin(gameFrame * 0.15) * 0.15;
    const appleGrad = sCtx.createRadialGradient(
      appleX * gridSize + gridSize / 2, appleY * gridSize + gridSize / 2, 2,
      appleX * gridSize + gridSize / 2, appleY * gridSize + gridSize / 2, gridSize * pulseSize
    );
    appleGrad.addColorStop(0, '#ff2d95');
    appleGrad.addColorStop(0.5, 'rgba(255, 45, 149, 0.2)');
    appleGrad.addColorStop(1, 'rgba(255, 45, 149, 0)');
    sCtx.fillStyle = appleGrad;
    sCtx.fillRect(
      appleX * gridSize - gridSize, appleY * gridSize - gridSize,
      gridSize * 3, gridSize * 3
    );
    sCtx.fillStyle = '#ff2d95';
    sCtx.shadowBlur = 5;
    sCtx.shadowColor = '#ff2d95';
    sCtx.beginPath();
    sCtx.arc(appleX * gridSize + gridSize / 2, appleY * gridSize + gridSize / 2, gridSize / 2 - 2, 0, Math.PI * 2);
    sCtx.fill();
    sCtx.shadowBlur = 0;

    for (let i = snake.length - 1; i >= 0; i--) {
      const seg = snake[i];
      const t = i / snake.length;

      if (i === 0) {
        sCtx.fillStyle = '#ffffff';
        sCtx.shadowBlur = 10;
        sCtx.shadowColor = '#00f0ff';
      } else {
        const r = Math.round(0 + t * 176);
        const g = Math.round(240 - t * 202);
        const b = Math.round(255);
        sCtx.fillStyle = `rgb(${r}, ${g}, ${b})`;
        sCtx.shadowBlur = 0;
      }
      
      sCtx.fillRect(seg.x * gridSize + 1, seg.y * gridSize + 1, gridSize - 2, gridSize - 2);
    }
    sCtx.shadowBlur = 0;
    const head = snake[0];
    const hx = head.x * gridSize;
    const hy = head.y * gridSize;
    const eyeSize = 4;
    const eyeColor = '#050508';
    const pupilColor = '#00f0ff';

    sCtx.fillStyle = eyeColor;

    if (velocityX === 1) {
      sCtx.fillRect(hx + gridSize - 7, hy + 4, eyeSize, eyeSize);
      sCtx.fillRect(hx + gridSize - 7, hy + gridSize - 8, eyeSize, eyeSize);
    } else if (velocityX === -1) {
      sCtx.fillRect(hx + 3, hy + 4, eyeSize, eyeSize);
      sCtx.fillRect(hx + 3, hy + gridSize - 8, eyeSize, eyeSize);
    } else if (velocityY === -1) {
      sCtx.fillRect(hx + 4, hy + 3, eyeSize, eyeSize);
      sCtx.fillRect(hx + gridSize - 8, hy + 3, eyeSize, eyeSize);
    } else {
      sCtx.fillRect(hx + 4, hy + gridSize - 7, eyeSize, eyeSize);
      sCtx.fillRect(hx + gridSize - 8, hy + gridSize - 7, eyeSize, eyeSize);
    }

    if (isPlaying) {
      const speed = Math.max(60, 110 - (score * 0.4));
      gameLoop = setTimeout(drawGame, speed);
    }
  }

  // Controls
  window.addEventListener('keydown', (e) => {
    if (!isPlaying) return;
    if (['ArrowUp','ArrowDown','ArrowLeft','ArrowRight',' '].indexOf(e.code) > -1) {
      e.preventDefault();
    }
    if (e.key === 'ArrowUp' && velocityY !== 1) { velocityX = 0; velocityY = -1; }
    if (e.key === 'ArrowDown' && velocityY !== -1) { velocityX = 0; velocityY = 1; }
    if (e.key === 'ArrowLeft' && velocityX !== 1) { velocityX = -1; velocityY = 0; }
    if (e.key === 'ArrowRight' && velocityX !== -1) { velocityX = 1; velocityY = 0; }
  });

  // Touch Controls
  let touchStartX = 0, touchStartY = 0;
  snakeCanvas.addEventListener('touchstart', (e) => {
    touchStartX = e.touches[0].clientX;
    touchStartY = e.touches[0].clientY;
  }, { passive: true });

  snakeCanvas.addEventListener('touchmove', (e) => {
    e.preventDefault();
  }, { passive: false });

  snakeCanvas.addEventListener('touchend', (e) => {
    const dx = e.changedTouches[0].clientX - touchStartX;
    const dy = e.changedTouches[0].clientY - touchStartY;
    const absDx = Math.abs(dx);
    const absDy = Math.abs(dy);
    if (absDx < 15 && absDy < 15) return; // Ignore taps

    if (absDx > absDy) {
      // Horizontal swipe
      if (dx > 0 && velocityX !== -1) { velocityX = 1; velocityY = 0; }
      else if (dx < 0 && velocityX !== 1) { velocityX = -1; velocityY = 0; }
    } else {
      // Vertical swipe
      if (dy > 0 && velocityY !== -1) { velocityX = 0; velocityY = 1; }
      else if (dy < 0 && velocityY !== 1) { velocityX = 0; velocityY = -1; }
    }
  }, { passive: true });

  // Scroll Observer
  const aboutSection = document.getElementById('about');
  const snakeObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting && !isPlaying && !isGameOver) {
        resizeCanvas();
        initSnake();
        isPlaying = true;
        drawGame();
      } else if (!entry.isIntersecting && isPlaying) {
        isPlaying = false;
        clearTimeout(gameLoop);
      }
    });
  }, { threshold: 0.3 });
  snakeObserver.observe(aboutSection);

  // Reset Game
  if (playAgainBtn) {
    playAgainBtn.addEventListener('click', () => {
      initSnake();
      isPlaying = true;
      drawGame();
    });
  }

});
