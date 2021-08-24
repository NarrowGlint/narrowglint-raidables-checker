--NarrowGlints Raidable Checker

include("autorun/config.lua")

SWEP.PrintName = "Raidables Checker"
SWEP.Author = "NarrowGlint"
SWEP.Category = "NarrowGlint"
SWEP.Instructions = "Left mouse to check for printers, meth, etc."

SWEP.Spawnable = true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		    = "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		    = "none"

SWEP.Weight			        = 5
SWEP.AutoSwitchTo		    = false
SWEP.AutoSwitchFrom		    = false

SWEP.Slot                   = 2
SWEP.SlotPos			    = 2
SWEP.DrawAmmo			    = false
SWEP.DrawCrosshair		    = true


local foundMessage = " was found within the range!"

local failMessage = "No more raidables were found within the range!"


function SWEP:RaidableCheck()
	
	local owner = self:GetOwner()

	if (not owner:IsValid()) then return end

	if (CLIENT) then return end

	local playerPos = owner:GetPos()

-- This adds the front square pos (up and to the right)
	
	local frontPos = Vector(0,0,0)
	
	frontPos:Add(playerPos + Vector(800, -900, -250))

-- This adds the behind square pos (back and to the left)
	
	local backPos = Vector(0,0,0)

	backPos:Add(playerPos + Vector(-800, 900, 250))
	
-- Create the box for the entities

	local boxEnts = ents.FindInBox(frontPos, backPos)

-- Im new to Lua, sorry there is probably a better way to do this.

	for key, className in ipairs(raidables) do
		
		for i, v in ipairs(boxEnts) do
			
			if v:GetClass() == className then
			
				owner:ChatPrint(className .. " was found within the range!")
			
			else
			
				no_ents_found = true
			
			end
		end
	end
	
	if no_ents_found then
		owner:ChatPrint("No more raidables were found within the range!")
	end

end

-- This is more fun

function SWEP:PrimaryAttack()

	self:RaidableCheck()

end
