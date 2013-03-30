local MSQ = LibStub("Masque", true)
if not MSQ then return end

-- RealUI
MSQ:AddSkin(
	"RealUI", 
	{
		Author = "Nibelheim",
		Version = "7.0",
		Shape = "Square",
		Masque_Version = 40200,
		Backdrop = {
			Width = 32,
			Height = 32,
			Texture = [[Interface\AddOns\Masque_RealUI\Textures\Backdrop]],
		},
		Icon = {
			Width = 26,
			Height = 26,
			TexCoords = {0.1, 0.9, 0.1, 0.9},
		},
		Flash = {
			Width = 32,
			Height = 32,
			Color = {1, 0, 0, 0.3},
			Texture = [[Interface\AddOns\Masque_RealUI\Textures\Overlay]],
		},
		Cooldown = {
			Width = 26,
			Height = 26,
		},
		Pushed = {
			Width = 32,
			Height = 32,
			Color = {0, 0, 0, 0.5},
			Texture = [[Interface\AddOns\Masque_RealUI\Textures\Overlay]],
		},
		Normal = {
			Width = 32,
			Height = 32,
			Color = {0, 0, 0, 1},
			Texture = [[Interface\AddOns\Masque_RealUI\Textures\Normal]],
		},
		Disabled = {
			Hide = true,
		},
		Checked = {
			Width = 32,
			Height = 32,
			BlendMode = "ADD",
			Color = {0, 0.8, 1, 0.5},
			Texture = [[Interface\AddOns\Masque_RealUI\Textures\Border]],
		},
		Border = {
			Width = 32,
			Height = 32,
			BlendMode = "ADD",
			Texture = [[Interface\AddOns\Masque_RealUI\Textures\Border]],
		},
		Gloss = {
			Width = 32,
			Height = 32,
			Texture = [[Interface\AddOns\Masque_RealUI\Textures\Gloss]],
		},
		AutoCastable = {
			Width = 54,
			Height = 54,
			OffsetX = 0.5,
			OffsetY = -0.5,
			Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
		},
		Highlight = {
			Width = 32,
			Height = 32,
			BlendMode = "ADD",
			Color = {1, 1, 1, 0.5},
			Texture = [[Interface\AddOns\Masque_RealUI\Textures\Highlight]],
		},
		Name = {
			Width = 32,
			Height = 10,
			OffsetX = 5.5,
			OffsetY = 4.5,
			Font = [[Interface\AddOns\Masque_RealUI\Font\pixel1.ttf]],
			FontSize = 8,
			JustifyH = "LEFT",
		},
		Count = {
			Width = 32,
			Height = 10,
			Font = [[Interface\AddOns\Masque_RealUI\Font\pixel1.ttf]],
			FontSize = 8,
			JustifyH = "RIGHT",
			OffsetX = -3.5,
			OffsetY = 5.5,
		},
		HotKey = {
			Width = 32,
			Height = 10,
			OffsetX = 6.5,
			OffsetY = -5.5,
			Font = [[Interface\AddOns\Masque_RealUI\Font\pixel1.ttf]],
			FontSize = 8,
			JustifyH = "LEFT",
		},
		Duration = {
			Width = 32,
			Height = 10,
			OffsetY = -2,
		},
		AutoCast = {
			Width = 26,
			Height = 26,
			OffsetX = 1,
			OffsetY = -1,
		},
	}, 
	true
)
