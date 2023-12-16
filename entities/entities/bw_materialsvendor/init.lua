AddCSLuaFile()
AddCSLuaFile("cl_init.lua")

ENT.Base = "base_ai" -- This entity is an AI.
ENT.Type = "ai" -- This entity is an AI.

ENT.PrintName = "Materials Vendor"
ENT.Author = "Your Name"
ENT.Contact = "Your Contact Information"
ENT.Purpose = "Sells materials to players."
ENT.Instructions = "Press E to buy materials."

ENT.AutomaticFrameAdvance = true -- This entity will animate itself.

function ENT:Initialize()
    self:SetModel("models/mossman.mdl") -- Set the model of the NPC. Replace with the actual model of your NPC.

    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()

    self:SetSolid(SOLID_BBOX)
    self:SetMoveType(MOVETYPE_STEP)

    self:CapabilitiesAdd(CAP_TURN_HEAD)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE)

    self:SetUseType(SIMPLE_USE)

    self:DropToFloor()
end

concommand.Add("spawnnpc", function(ply, cmd, args)
    if not IsValid(ply) or not ply:IsPlayer() then return end

    local npc = ents.Create("bw_materialsvendor")
    if not IsValid(npc) then return end

    npc:SetPos(ply:GetPos() + Vector(0, 0, 50)) -- Spawn the NPC 50 units above the player to prevent it from spawning inside the player
    npc:Spawn()
end)

util.AddNetworkString("OpenMaterialsVendorGUI")

function ENT:AcceptInput(name, activator, caller)
    if name == "Use" and IsValid(caller) and caller:IsPlayer() then
        net.Start("OpenMaterialsVendorGUI")
        net.WriteTable(caller.craftingMaterials) -- Send the player's crafting materials to the client
        net.Send(caller)
    end
end