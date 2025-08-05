
const toggleBtn = document.getElementById("toggleBtn");
const sidebar = document.getElementById("sidebar");
const mainContent = document.getElementById("main-content");

toggleBtn.addEventListener("click", () => {
  sidebar.classList.toggle("open");
});

function Event(tipo) {
  let html = "";

  switch (tipo) {
    case "Sobre":
  html = `
    <h1>📌 Sobre o Projeto</h1>
    <p><strong>Mastermod</strong> é um conjunto de ferramentas personalizadas desenvolvidas para aprimorar a experiência no jogo Roblox. Este menu oferece funcionalidades avançadas para personalização e automação dentro do jogo.</p>
    
    <h2>⚠️ Aviso</h2>
    <p>O uso de mods e scripts em jogos online pode violar os Termos de Serviço do Roblox, resultando em banimentos ou outras penalidades. <strong>Use este projeto por sua conta e risco.</strong></p>

    <h2>👨‍💻 Para usar basta colar em um Executor Lua:</h2>
    <code id="codigo-mod">
      loadstring(game:HttpGet("https://raw.githubusercontent.com/AdrainRazini/mastermod/refs/heads/main/apresentar"))()
    </code>

    <button class="btn" onclick="copiarCodigo()">📋 Copiar Script</button>
  </div>


    <h2>📂 Estrutura do Projeto</h2>
    <pre><code>
mastermod/
├── mod/              # mod menu   
├── script/           # Scripts principais do mod menu     
├── README.md         # Documentação do projeto
└── Mastermod         # Arquivo principal do mod menu
    </code></pre>

    <h2>🚀 Funcionalidades</h2>
    <ul>
      <li>📌 <strong>Modos de jogo personalizados</strong></li>
      <li>🛠 <strong>Ferramentas de automação</strong></li>
      <li>🎭 <strong>Modificações de personagem</strong></li>
      <li>🎮 <strong>Melhoria na jogabilidade</strong></li>
    </ul>

    <h2>📜 Requisitos</h2>
    <ul>
      <li>✅ Executor de Lua compatível com Roblox</li>
      <li>✅ Conexão com a internet</li>
      <li>✅ Conhecimento básico de scripts Lua (opcional)</li>
    </ul>

    <h2>🤝 Contribuição</h2>
    <p>Contribuições são bem-vindas! Se quiser adicionar novas funcionalidades, abra um <strong>Pull Request</strong> ou entre em contato.</p>

    <h2>📜 Licença</h2>
    <p>Este projeto é para uso educacional e não possui nenhuma ligação oficial com Roblox Corporation.</p>

    <p><strong>Autor:</strong> Adrian Razini Rangel</p>
  `;
  break;
    case "Aimbot":
      html = `
        <h1>Aimbot</h1>
        <p>O Aimbot permite travar a mira automaticamente nos jogadores mais próximos.</p>
        <ul>
          <li>✔ Ativação por tecla</li>
          <li>✔ Opções de FOV</li>
          <li>✔ Mira silenciosa</li>
        </ul>
      `;
      break;
    case "Esp":
      html = `
        <h1>ESP Visor</h1>
        <p>Destaca jogadores através de paredes com caixas e linhas.</p>
        <ul>
          <li>✔ Box ESP</li>
          <li>✔ Line ESP</li>
          <li>✔ Nome e time</li>
        </ul>
      `;
      break;
    case "Fly":
      html = `
        <h1>Fly</h1>
        <p>Permite que seu personagem voe pelo mapa.</p>
        <ul>
          <li>✔ Ativar/desativar com tecla</li>
          <li>✔ Velocidade ajustável</li>
        </ul>
      `;
      break;
    case "Speed":
      html = `
        <h1>Speed Hack</h1>
        <p>Aumenta a velocidade do seu personagem temporariamente.</p>
        <ul>
          <li>✔ Velocidade turbo</li>
          <li>✔ Corrida automática</li>
        </ul>
      `;
      break;
    default:
      html = `<h1>Erro</h1><p>Função desconhecida: ${tipo}</p>`;
  }

  mainContent.innerHTML = html;
}


const digitandoEl = document.getElementById("digitando");
const textos = [
  "Preparando ambiente...",
  "Conectando ao servidor...",
  "Carregando interface Master Mods...",
  "Aguardando usuário...",
  "✔ Velocidade ajustável",
  "Mira silenciosa"
];

let index = 0;
let charIndex = 0;
let apagando = false;

function digitarTexto() {
  const textoAtual = textos[index];

  if (!apagando) {
    digitandoEl.textContent = textoAtual.substring(0, charIndex + 1);
    charIndex++;
    if (charIndex === textoAtual.length) {
      apagando = true;
      setTimeout(digitarTexto, 1500); // espera antes de apagar
      return;
    }
  } else {
    digitandoEl.textContent = textoAtual.substring(0, charIndex - 1);
    charIndex--;
    if (charIndex === 0) {
      apagando = false;
      index = (index + 1) % textos.length;
    }
  }

  setTimeout(digitarTexto, apagando ? 40 : 70); // velocidade
}

digitarTexto();


function copiarCodigo() {
  const codigo = document.getElementById("codigo-mod").innerText;

  navigator.clipboard.writeText(codigo)
    .then(() => {
      alert("✅ Script copiado com sucesso!");
    })
    .catch(() => {
      alert("❌ Erro ao copiar.");
    });
}
