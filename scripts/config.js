const CONFIG = {
  phrases: [
    'Elite Esports Division of KUET',
    'Dominating PC, Mobile & Console',
    'Where Legends Are Forged ⚡',
    'Train Hard. Play Harder. Win Everything.',
    'The Battlefield Awaits...',
  ],

  achievements: [
    { icon: '🏆', target: 25, label: 'Tournaments Won' },
    { icon: '🎮', target: 50, label: 'Events Hosted' },
    { icon: '👥', target: 200, label: 'Active Members' },
    { icon: '⚔️', target: 150, label: 'Matches Played' }
  ],

  games: [
    {
      title: 'Valorant',
      category: 'pc esports',
      badge: 'PC',
      image: 'https://images.steamusercontent.com/ugc/1009310639741043947/C4780FD7B53B39EFE4A536842FC1281A48A1256F/?imw=637&imh=358&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true',
      desc: 'Our tactical FPS division leads the charge with precision and strategy in every round.',
      tags: ['FPS', 'Tactical']
    },
    {
      title: 'PUBG Mobile',
      category: 'mobile',
      badge: 'Mobile',
      image: 'https://upload.wikimedia.org/wikipedia/en/4/44/PlayerUnknown%27s_Battlegrounds_Mobile.webp',
      desc: 'Dominating battle royales across mobile platforms with sharp positioning and rotations.',
      tags: ['Battle Royale', 'Mobile']
    },
    {
      title: 'League of Legends',
      category: 'pc esports',
      badge: 'PC',
      image: 'https://www.exitlag.com/blog/wp-content/uploads/2024/10/league-of-legends-download-1.webp',
      desc: 'Strategic MOBA gameplay with our roster of well-coordinated and mechanically gifted players.',
      tags: ['MOBA', 'Strategy']
    },
    {
      title: 'CS2',
      category: 'pc esports',
      badge: 'Esports',
      image: 'https://gaming-cdn.com/images/products/13664/616x353/counter-strike-2-pc-game-steam-cover.jpg?v=1695885435',
      desc: 'The OG competitive FPS. Our CS2 roster brings raw skill and veteran experience.',
      tags: ['FPS', 'Competitive']
    },
    {
      title: 'Free Fire',
      category: 'mobile',
      badge: 'Mobile',
      image: 'https://images.hindustantimes.com/tech/img/2022/06/23/1600x900/54f31449f5f91cf0cc223cc635cd5952jpg_1655955051259_1655955067513.jpeg',
      desc: 'Fast-paced mobile battle royale where our squad delivers swift eliminations.',
      tags: ['Battle Royale', 'Mobile']
    },
    {
      title: 'Dota 2',
      category: 'pc esports',
      badge: 'PC',
      image: 'https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/570/header.jpg?t=1769535998',
      desc: 'Complex strategy meets mechanical precision. Our Dota roster thrives on teamwork.',
      tags: ['MOBA', 'Strategy']
    }
  ],

  team: [
    { name: 'Arif Khan', role: 'President & Founder', initials: 'AK', socials: { facebook: '#', discord: '#', linkedin: '#' } },
    { name: 'Sadia Rahman', role: 'Vice President', initials: 'SR', socials: { facebook: '#', discord: '#', linkedin: '#' } },
    { name: 'Tahmid Hasan', role: 'Team Captain — FPS', initials: 'TH', socials: { facebook: '#', discord: '#', linkedin: '#' } },
    { name: 'Nusrat Jahan', role: 'Event Coordinator', initials: 'NJ', socials: { facebook: '#', discord: '#', linkedin: '#' } },
    { name: 'Raihan Islam', role: 'Team Captain — MOBA', initials: 'RI', socials: { facebook: '#', discord: '#', linkedin: '#' } },
    { name: 'Farhan Ahmed', role: 'Creative Director', initials: 'FA', socials: { facebook: '#', discord: '#', linkedin: '#' } },
    { name: 'Manha Akter', role: 'Social Media Lead', initials: 'MA', socials: { facebook: '#', discord: '#', linkedin: '#' } },
    { name: 'Zahid Rahman', role: 'Tech Lead & Streamer', initials: 'ZR', socials: { facebook: '#', discord: '#', linkedin: '#' } }
  ],

  events: [
    { date: 'June 2026', status: 'upcoming', title: 'Cyborg Clash 4.0', desc: 'Our flagship inter-university esports tournament featuring Valorant, PUBG Mobile, and CS2 with a prize pool of ৳50,000.', align: 'left' },
    { date: 'March 2026', status: 'upcoming', title: 'LAN Party Night', desc: 'An all-night gaming marathon at the KUET campus with custom setups, mini tournaments, and community bonding.', align: 'right' },
    { date: 'Jan 2026', status: 'past', title: 'KUET Gaming Fest', desc: '3-day gaming festival with workshops, Cosplay, and competitive matches. Over 300 participants from 12 universities.', align: 'left' },
    { date: 'Oct 2025', status: 'past', title: 'Cyborg Clash 3.0', desc: "National-level esports competition. Cyborg's Valorant team secured 1st place against 64 competing teams.", align: 'right' },
    { date: 'July 2025', status: 'past', title: 'Summer Bootcamp', desc: 'Intensive 2-week training camp covering aim training, strategy, team coordination, and mental fortitude.', align: 'left' }
  ],

  gallery: [
    { title: 'Tournament Finals', color: '#0a1628', accent: '#00f0ff', icon: '🏆' },
    { title: 'Team Practice', color: '#140a28', accent: '#b026ff', icon: '🎮' },
    { title: 'LAN Party Night', color: '#0a2818', accent: '#39ff14', icon: '💻' },
    { title: 'Award Ceremony', color: '#281a0a', accent: '#ff6b00', icon: '🥇' },
    { title: 'Cosplay Event', color: '#280a1a', accent: '#ff2d95', icon: '🎭' },
    { title: 'Campus Meetup', color: '#0a1828', accent: '#00f0ff', icon: '🤝' },
    { title: 'Stream Setup', color: '#1a0a28', accent: '#b026ff', icon: '📡' },
    { title: 'Victory Moment', color: '#0a280a', accent: '#39ff14', icon: '🎉' }
  ]
};
