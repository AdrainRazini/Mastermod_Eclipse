
-- URL da API do GitHub para listar os scripts
local GITHUB_USER = "AdrainRazini"
local GITHUB_REPO = "Mastermod_Eclipse"
local GITHUB_REPO_NAME = "MastermodEclipse"
local Owner = "Adrian75556435"
local SCRIPTS_FOLDER_URL = "https://api.github.com/repos/" .. GITHUB_USER .. "/" .. GITHUB_REPO .. "/contents/script"
local IMG_ICON = "rbxassetid://117585506735209"
local NAME_MOD_MENU = "ModMenuGui"


local config = {}

-- Criação da lista de cores 
local colors = {
	Red = Color3.fromRGB(255, 0, 0),
	Green = Color3.fromRGB(0, 255, 0),
	Blue = Color3.fromRGB(0, 0, 255),
	Yellow = Color3.fromRGB(255, 255, 0),
	Orange = Color3.fromRGB(255, 165, 0),
	Purple = Color3.fromRGB(128, 0, 128),
	Pink = Color3.fromRGB(255, 105, 180),
	White = Color3.fromRGB(255, 255, 255),
	Black = Color3.fromRGB(0, 0, 0),
	Gray = Color3.fromRGB(128, 128, 128),
	DarkGray = Color3.fromRGB(50, 50, 50),
	LightGray = Color3.fromRGB(200, 200, 200),
	Cyan = Color3.fromRGB(0, 255, 255),
	Magenta = Color3.fromRGB(255, 0, 255),
	Brown = Color3.fromRGB(139, 69, 19),
	Gold = Color3.fromRGB(255, 215, 0),
	Silver = Color3.fromRGB(192, 192, 192),
	Maroon = Color3.fromRGB(128, 0, 0),
	Navy = Color3.fromRGB(0, 0, 128),
	Lime = Color3.fromRGB(50, 205, 50),
	Olive = Color3.fromRGB(128, 128, 0),
	Teal = Color3.fromRGB(0, 128, 128),
	Aqua = Color3.fromRGB(0, 255, 170),
	Coral = Color3.fromRGB(255, 127, 80),
	Crimson = Color3.fromRGB(220, 20, 60),
	Indigo = Color3.fromRGB(75, 0, 130),
	Turquoise = Color3.fromRGB(64, 224, 208),
	Slate = Color3.fromRGB(112, 128, 144),
	Chocolate = Color3.fromRGB(210, 105, 30)
}



-- 🖼️ Função utilitária para criar UI Corner Obs: Aplicar Ui nas frames
local function applyCorner(instance, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = radius or UDim.new(0, 6)
	corner.Parent = instance
end

-- Função para aplicar contorno neon via UIStroke
local function applyUIStroke(instance, colorName, thickness)
	thickness = thickness or 2
	local stroke = Instance.new("UIStroke")
	stroke.Parent = instance
	stroke.Thickness = thickness
	stroke.LineJoinMode = Enum.LineJoinMode.Round
	stroke.Transparency = 0
	-- Escolhe cor da paleta ou usa branco como fallback
	stroke.Color = colors[colorName] or Color3.new(1, 1, 1)
end

local function applyNeonUIStroke(instance, cores, velocidade)
	velocidade = velocidade or 0.1

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Transparency = 0
	stroke.LineJoinMode = Enum.LineJoinMode.Round
	stroke.Parent = instance

	-- Se for string única, usa como cor fixa
	if typeof(cores) == "string" then
		stroke.Color = colors[cores] or Color3.new(1, 1, 1)
		return
	end

	-- Se for tabela, anima entre elas
	task.spawn(function()
		local index = 1
		while stroke.Parent do
			local cor = cores[index]
			stroke.Color = colors[cor] or Color3.new(1, 1, 1)
			index = index % #cores + 1
			task.wait(velocidade)
		end
	end)
end

local RunService = game:GetService("RunService")

local function applyRotatingGradientUIStroke(instance, cor1, cor2, cor3)
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Transparency = 0
	stroke.LineJoinMode = Enum.LineJoinMode.Round
	stroke.Color = colors.White
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = instance

	local gradient = Instance.new("UIGradient")
	gradient.Rotation = 0
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.0, colors[cor1] or Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(0.5, colors[cor2] or Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(1.0, colors[cor3] or Color3.new(1, 1, 1))
	})
	gradient.Parent = stroke

	-- Animação da rotação do gradiente
	local angle = 0
	RunService.RenderStepped:Connect(function()
		if gradient.Parent == nil then return end
		angle = (angle + 0.5) % 360 -- Velocidade de rotação
		gradient.Rotation = angle
	end)
end



--=========================================================--




-- Verificar se já existe um ScreenGui com o nome "ModMenu"
local existingScreenGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild(GITHUB_REPO_NAME)

-- Se já existir, retorna para evitar a criação do GUI
if existingScreenGui then
	return
end


function hello ()

	game:GetService("StarterGui"):SetCore("SendNotification", { 
		Title = GITHUB_REPO;
		Text = Owner;
		Icon = "rbxthumb://type=Asset&id=102637810511338&w=150&h=150"})
	Duration = 16;

end


function criar_Gui_Frame()
	local TweenService = game:GetService("TweenService")
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	local PlayerGui = player:WaitForChild("PlayerGui")

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = GITHUB_REPO_NAME
	ScreenGui.Parent = PlayerGui
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local ModMenu = Instance.new("Frame")
	ModMenu.Name = "ModMenu"
	ModMenu.Parent = ScreenGui
	ModMenu.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
	ModMenu.Size = UDim2.new(0, 240, 0, 320)
	ModMenu.Position = UDim2.new(0.05, 0, 0.1, 0)
	ModMenu.Active = true
	ModMenu.Draggable = true

	applyCorner(ModMenu, UDim.new(0, 8))
	applyRotatingGradientUIStroke(ModMenu, "Cyan", "Magenta", "Blue")


	local TitleBar = Instance.new("Frame")
	TitleBar.Name = "TitleBar"
	TitleBar.Parent = ModMenu
	TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	TitleBar.Size = UDim2.new(1, 0, 0, 35)

	Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)

	local Title = Instance.new("TextLabel")
	Title.Parent = TitleBar
	Title.Text = NAME_MOD_MENU
	Title.BackgroundTransparency = 1
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 18
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Size = UDim2.new(1, -40, 1, 0)
	Title.Position = UDim2.new(0, 10, 0, 0)

	local MinimizeButton = Instance.new("TextButton")
	MinimizeButton.Parent = TitleBar
	MinimizeButton.Text = "–"
	MinimizeButton.Font = Enum.Font.GothamBold
	MinimizeButton.TextSize = 22
	MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
	MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
	MinimizeButton.Position = UDim2.new(1, -30, 0, 0)
	Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(1, 0)

	local Content = Instance.new("ScrollingFrame")
	Content.Parent = ModMenu
	Content.Name = "Content"
	Content.Size = UDim2.new(1, 0, 1, -35)
	Content.Position = UDim2.new(0, 0, 0, 35)
	Content.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
	Content.ScrollBarThickness = 6
	Content.CanvasSize = UDim2.new(0, 0, 0, 0)

	Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 10)

	local layout = Instance.new("UIListLayout", Content)
	layout.Padding = UDim.new(0, 6)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder





--=========================================================--

-- Criação da Frame de configuração

-- 📦 Configurações
local configBtn = Instance.new("TextButton")
configBtn.Size = UDim2.new(0, 30, 0, 30)
configBtn.Position = UDim2.new(1, -30, 1, -30)
configBtn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
configBtn.Text = "⚙️"
configBtn.TextColor3 = Color3.new(1,1,1)
configBtn.Font = Enum.Font.GothamBold
configBtn.TextSize = 20
configBtn.Parent = ModMenu
applyCorner(configBtn)

-- ⚙️ Painel de Config
local configFrame = Instance.new("Frame")
configFrame.Size = UDim2.new(0, 300, 0, 400)
configFrame.Position = UDim2.new(0, ModMenu.Position.X.Offset + 220, 0, ModMenu.Position.Y.Offset)
configFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
configFrame.Visible = false
configFrame.Active = true
configFrame.Draggable = true
configFrame.Parent = ScreenGui
applyCorner(configFrame, UDim.new(0, 8))

local configTitle = Instance.new("TextLabel")
configTitle.Size = UDim2.new(1, 0, 0, 30)
configTitle.BackgroundTransparency = 1
configTitle.Text = "🔧 Configurações"
configTitle.TextColor3 = Color3.new(1, 1, 1)
configTitle.Font = Enum.Font.GothamBold
configTitle.TextSize = 18
configTitle.Parent = configFrame

--=========================================================--


	-- Criação de seções Obs: Melhoria do antigo Frame Config

	-- 🌐 Seções
	local secoes = {
		["Player"] = {},
		["Jogo"] = {},
		["Farm"] = {},
		["Teleportes"] = {}
	}

	-- 🧭 Menu de Abas
	local abasFrame = Instance.new("Frame")
	abasFrame.Size = UDim2.new(1, 0, 0, 30)
	abasFrame.BackgroundTransparency = 1
	abasFrame.Position = UDim2.new(0, 0, 0, 30)
	abasFrame.Parent = configFrame

	-- 🔁 Função para criar abas
	local abaSelecionada = "Player"

	local function atualizarVisibilidade()
		for nomeSecao, elementos in pairs(secoes) do
			for _, ui in pairs(elementos) do
				ui.Visible = (nomeSecao == abaSelecionada)
			end
		end
	end

	local function criarAba(nome, posX)
		local botao = Instance.new("TextButton")
		botao.Size = UDim2.new(0, 60, 0, 25)
		botao.Position = UDim2.new(0, posX, 0, 0)
		botao.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		botao.Text = nome
		botao.TextColor3 = Color3.new(1, 1, 1)
		botao.Font = Enum.Font.GothamBold
		botao.TextSize = 13
		botao.Parent = abasFrame
		applyCorner(botao, UDim.new(0, 4))

		botao.MouseButton1Click:Connect(function()
			abaSelecionada = nome
			atualizarVisibilidade()
		end)
	end

	-- abas Obs: Criação das abas
	criarAba("Player", 10)
	criarAba("Jogo", 80)
	criarAba("Farm", 150)
	criarAba("Teleportes", 220)
	--======================================================--
	
	-- Criação de entradas e checkboxes Obs: Melhoria do antigo Frame Config

	local function criarEntrada(titulo, posY, valorAtual, onChange, secao)
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(0, 120, 0, 20)
		label.Position = UDim2.new(0, 10, 0, posY)
		label.Text = titulo
		label.TextColor3 = Color3.new(1,1,1)
		label.BackgroundTransparency = 1
		label.Font = Enum.Font.Gotham
		label.TextSize = 14
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Parent = configFrame

		local box = Instance.new("TextBox")
		box.Size = UDim2.new(0, 70, 0, 20)
		box.Position = UDim2.new(1, -80, 0, posY)
		box.Text = tostring(valorAtual)
		box.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
		box.TextColor3 = Color3.new(1, 1, 1)
		box.Font = Enum.Font.Gotham
		box.TextSize = 14
		box.ClearTextOnFocus = false
		box.Parent = configFrame
		applyCorner(box)

		box.FocusLost:Connect(function()
			local value = tonumber(box.Text)
			if value then onChange(value) end
		end)

		label.Visible = false
		box.Visible = false
		table.insert(secoes[secao], label)
		table.insert(secoes[secao], box)
	end

	local function criarCheckbox(titulo, posY, valorInicial, callback, secao)
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(0, 140, 0, 20)
		label.Position = UDim2.new(0, 10, 0, posY)
		label.Text = titulo
		label.TextColor3 = Color3.new(1, 1, 1)
		label.BackgroundTransparency = 1
		label.Font = Enum.Font.Gotham
		label.TextSize = 14
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Parent = configFrame

		local box = Instance.new("TextButton")
		box.Size = UDim2.new(0, 20, 0, 20)
		box.Position = UDim2.new(1, -30, 0, posY)
		box.BackgroundColor3 = valorInicial and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(70, 70, 70)
		box.Text = valorInicial and "✔" or ""
		box.TextColor3 = Color3.new(1, 1, 1)
		box.Font = Enum.Font.GothamBold
		box.TextSize = 16
		box.Parent = configFrame
		applyCorner(box, UDim.new(0, 4))

		box.MouseButton1Click:Connect(function()
			valorInicial = not valorInicial
			box.BackgroundColor3 = valorInicial and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(70, 70, 70)
			box.Text = valorInicial and "✔" or ""
			callback(valorInicial)
		end)

		label.Visible = false
		box.Visible = false
		table.insert(secoes[secao], label)
		table.insert(secoes[secao], box)
	end

	--====================================================================================================================--
	
	--=====================================================================================================================--

	-- Controle do proprio personagem Obs: Bom para mods locais.

	-- 🧍 Player Control
	local ultimoWalkSpeed = 16
	local ultimoJumpPower = 50
	local ultimaColisao = true
	local ultimoESP = false

	-- 1. Velocidade de caminhada
	local function setWalkSpeed(valor)
		ultimoWalkSpeed = valor
		local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = valor
		end
	end

	local function setJumpPower(valor)
		ultimoJumpPower = valor
		local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.JumpPower = valor
		end
	end

	local function setCollision(ativo)
		ultimaColisao = ativo
		local character = game.Players.LocalPlayer.Character
		if character then
			for _, part in pairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = ativo
				end
			end
		end
	end

	local function toggleESP(ativo)
		ultimoESP = ativo
		local char = game.Players.LocalPlayer.Character
		if not char then return end

		local highlight = char:FindFirstChild("PlayerHighlight")
		if ativo then
			if not highlight then
				highlight = Instance.new("Highlight")
				highlight.Name = "PlayerHighlight"
				highlight.FillTransparency = 1
				highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
				highlight.OutlineTransparency = 0
				highlight.Parent = char
			end
		else
			if highlight then
				highlight:Destroy()
			end
		end
	end

	local player = game.Players.LocalPlayer
	player.CharacterAdded:Connect(function(char)
		char:WaitForChild("Humanoid")

		task.wait(0.2) -- pequeno delay para garantir que as partes existam

		setWalkSpeed(ultimoWalkSpeed)
		setJumpPower(ultimoJumpPower)
		setCollision(ultimaColisao)
		toggleESP(ultimoESP)
	end)



	criarEntrada("Velocidade:", 70, 16, setWalkSpeed, "Player")
	criarEntrada("Pulo:", 100, 50, setJumpPower, "Player")
	criarCheckbox("Colisão", 130, true, setCollision, "Player")
	criarCheckbox("ESP (Highlight)", 160, false, toggleESP, "Player")
	--====================================================================--
	
	--====================================================================================================================--
	
	
	
	
	-- 📥 Abrir/Fechar painel de configurações
	configBtn.MouseButton1Click:Connect(function()
		configFrame.Visible = not configFrame.Visible
	end)




	local Buttons = {}
	local isMinimized = false

	local function updateCanvasSize()
		local totalHeight = 0
		for _, btn in ipairs(Buttons) do
			totalHeight += btn.Size.Y.Offset + layout.Padding.Offset
		end
		Content.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
	end

	local activeAlerts = {}

	local function showAlertInMenu(menuGui, text, duration)
		if not menuGui then return end

		local alertFrame = Instance.new("Frame")
		alertFrame.Size = UDim2.new(0, 280, 0, 50)
		alertFrame.Position = UDim2.new(1, -300, 1, -60 - (#activeAlerts * 60))
		alertFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
		alertFrame.BackgroundTransparency = 0
		alertFrame.BorderSizePixel = 0
		alertFrame.AnchorPoint = Vector2.new(0, 1)
		alertFrame.Name = "LocalAlert"
		alertFrame.ZIndex = 999
		alertFrame.Parent = menuGui

		Instance.new("UICorner", alertFrame).CornerRadius = UDim.new(0, 8)

		local label = Instance.new("TextLabel", alertFrame)
		label.Size = UDim2.new(1, -20, 1, -10)
		label.Position = UDim2.new(0, 10, 0, 5)
		label.BackgroundTransparency = 1
		label.Text = text
		label.TextColor3 = Color3.new(1, 1, 1)
		label.Font = Enum.Font.Gotham
		label.TextSize = 16
		label.TextWrapped = true
		label.ZIndex = 1000

		table.insert(activeAlerts, alertFrame)

		task.delay(duration or 3, function()
			for i = 1, 10 do
				alertFrame.BackgroundTransparency += 0.05
				label.TextTransparency += 0.05
				task.wait(0.04)
			end
			alertFrame:Destroy()
			table.remove(activeAlerts, table.find(activeAlerts, alertFrame))
			for i, alert in ipairs(activeAlerts) do
				alert:TweenPosition(UDim2.new(1, -300, 1, -60 - ((i - 1) * 60)), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
			end
		end)
	end

	local function alert(msg, dur)
		showAlertInMenu(ScreenGui, msg, dur or 4)
	end

	local function createButton(text, callback)
		local Button = Instance.new("TextButton")
		Button.Parent = Content
		Button.Size = UDim2.new(0.9, 0, 0, 40)
		Button.Text = text
		Button.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
		Button.TextColor3 = Color3.new(1, 1, 1)
		Button.Font = Enum.Font.GothamBold
		Button.TextSize = 16
		Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

		Button.MouseButton1Click:Connect(function()
			alert("📦 Botão '" .. text .. "' executado", 3)
			callback()
		end)

		table.insert(Buttons, Button)
		updateCanvasSize()
	end

	-- Minimizar
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local minimizeImage = Instance.new("ImageLabel")
	minimizeImage.Parent = ModMenu
	minimizeImage.Size = UDim2.new(1, 0, 1, 0)
	minimizeImage.BackgroundTransparency = 1
	minimizeImage.Image = IMG_ICON  -- Substitua IMG_ICON pela URL ou caminho da imagem desejada
	minimizeImage.Visible = false

	-- Adicionando bordas arredondadas
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)  -- Aqui ajustamos o arredondamento, se preferir mais ou menos, altere o valor
	corner.Parent = minimizeImage

	MinimizeButton.MouseButton1Click:Connect(function()
		isMinimized = not isMinimized

		-- Transições para o tamanho do menu
		local sizeTween = TweenService:Create(ModMenu, tweenInfo, {
			Size = isMinimized and UDim2.new(0, 50, 0, 50) or UDim2.new(0, 240, 0, 320)
		})

		-- Transições para a visibilidade do título
		local titleTween = TweenService:Create(Title, tweenInfo, {
			TextTransparency = isMinimized and 1 or 0
		})

		-- Controle da visibilidade do conteúdo
		Content.Visible = not isMinimized

		-- Transições para a imagem de minimizar
		local imageTween = TweenService:Create(minimizeImage, tweenInfo, {
			Transparency = isMinimized and 0 or 1
		})

		-- Torna a imagem visível durante a minimização
		minimizeImage.Visible = true
		configBtn.Visible = false
		imageTween:Play()

		-- Esconde a imagem de minimizar após a animação
		if not isMinimized then
			imageTween.Completed:Connect(function()
				minimizeImage.Visible = false
				configBtn.Visible = true
			end)
		end

		-- Executa as transições
		sizeTween:Play()
		titleTween:Play()
	end)

	-- Carregar scripts do GitHub
	local scripts = {
		{name = "Print", path = "example.lua"},
	}

	for _, script in ipairs(scripts) do
		createButton(script.name:upper(), function()
			local success, response = pcall(function()
				return game:HttpGet("https://raw.githubusercontent.com/" .. GITHUB_USER .. "/" .. GITHUB_REPO .. "/main/script/" .. script.path)
			end)
			if success then
				alert("🧠 Script '" .. script.name:upper() .. "' carregado!", 5)
				loadstring(response)()
			else
				alert("❌ Falha ao carregar '" .. script.name:upper() .. "'", 5)
			end
		end)
	end

	-- Mensagem inicial
	alert("👋 Bem-vindo, " .. player.Name .. "!", 6)
	alert("✅ Menu " .. GITHUB_REPO .. " ativado!", 5)
	hello()
end


-- Executa o menu
criar_Gui_Frame()
