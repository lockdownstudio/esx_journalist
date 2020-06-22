Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = { r = 102, g = 0, b = 102 }
Config.EnablePlayerManagement     = true
Config.EnableVaultManagement      = true
Config.EnableSocietyOwnedVehicles = false --disabled to let journalists buy their own vehicles.
Config.EnableHelicopters          = true
Config.EnableMoneyWash            = false
Config.MaxInService               = 30
Config.Locale                     = 'en'

Config.AuthorizedVehicles = {
	car = {
		crew = {},

		cameraman = {
			{model = 'rumpo', price = 500}
		},

		reporter = {
			{model = 'rumpo', price = 500}
        },
        
        investigator = {
			{model = 'rumpo', price = 500}
		},

		boss = {
			{model = 'rumpo', price = 500}
		}
	},

	helicopter = {
		crew = {},

		cameraman = {},

		reporter = {
            {model = 'frogger2', props = {modLivery = 0}, price = 1000}
        },

        investigator = {
            {model = 'frogger2', props = {modLivery = 0}, price = 1000}
        },

		boss = {
			{model = 'frogger2', props = {modLivery = 0}, price = 1000}
		}
	}
}


Config.Blip = {
	Pos     = { x = -598.7, y = -929.9, z = 23.0},
	Sprite  = 184,
	Display = 3,
	Scale   = 0.85,
	Colour  = 0,
}

Config.Stations = {

	Main = {

		BossActions = {
			vector3(-574.2, -938.9, 28.8)
		},
		
		Cloakrooms = {
			vector3(-599.2, -915.3, 33.6)
		},
		Vaults = {
			vector3(-567.4, -923.3, 28.8)
		},
		VehicleDeleters = {
			vector3(-533.1, -882.0, 25.3)
		},			
	
		Vehicles = {
			{
				Spawner = vector3(-535.6, -884.4, 25.3),
				InsideShop = vector3(-572.2, -915.3, 35.8),
				SpawnPoints = {
					{coords = vector3(-532.7, -892.1, 23.5), heading = 178.34, radius = 6.0},
				}
			},
		},
	
		Helicopters = {
			{
				Spawner = vector3(-570.6, -935.4, 36.8),
				InsideShop = vector3(-572.2, -915.3, 35.8),
				SpawnPoints = {
					{coords = vector3(-582.8, -930.6, 35.8), heading = 97.6, radius = 10.0}
				}
			}
		}

	}

	
}

Config.Uniforms = {
	journalist_outfit = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 13,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 26,
			['pants_1'] = 28,   ['pants_2'] = 0,
			['shoes_1'] = 20,   ['shoes_2'] = 0,
			['chain_1'] = 0,  ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 14,   ['torso_2'] = 6,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 6,   ['pants_2'] = 0,
			['shoes_1'] = 1,   ['shoes_2'] = 6,
			['chain_1'] = 0,  ['chain_2'] = 0
		}
	},
  journalist_outfit_1 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 13,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 26,
			['pants_1'] = 28,   ['pants_2'] = 0,
			['shoes_1'] = 20,   ['shoes_2'] = 0,
			['chain_1'] = 0,  ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 43,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 11,   ['pants_2'] = 6,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['chain_1'] = 0,  ['chain_2'] = 0,
            ['helmet_1'] =19,  ['helmet_2'] = 0
		}	
	},
  journalist_outfit_2 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 13,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 26,
			['pants_1'] = 28,   ['pants_2'] = 0,
			['shoes_1'] = 20,   ['shoes_2'] = 0,
			['chain_1'] = 0,  ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 27,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 6,   ['pants_2'] = 0,
			['shoes_1'] = 42,   ['shoes_2'] = 2,
			['chain_1'] = 0,  ['chain_2'] = 0
		}	
	},
  journalist_outfit_3 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 13,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 26,
			['pants_1'] = 28,   ['pants_2'] = 0,
			['shoes_1'] = 20,   ['shoes_2'] = 0,
			['chain_1'] = 0,  ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 7,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 6,
			['pants_1'] = 7,   ['pants_2'] = 0,
			['shoes_1'] = 42,   ['shoes_2'] = 0,
			['chain_1'] = 0,  ['chain_2'] = 0
		}	
	},
	journalist_outfit_4 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 13,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 26,
			['pants_1'] = 28,   ['pants_2'] = 0,
			['shoes_1'] = 20,   ['shoes_2'] = 0,
			['chain_1'] = 0,  ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 23,  ['tshirt_2'] = 4,
			['torso_1'] = 7,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 6,
			['pants_1'] = 8,   ['pants_2'] = 0,
			['shoes_1'] = 42,   ['shoes_2'] = 4,
			['chain_1'] = 6,  ['chain_2'] = 0
		}	
	}
}