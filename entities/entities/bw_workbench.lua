AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Workbench"
ENT.Category = "BaseWars Entities"
ENT.Spawnable = true
ENT.Model = "models/props/CS_militia/table_shed.mdl"

function ENT:Initialize()
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

if SERVER then
    util.AddNetworkString("OpenWorkbenchGUI")
end

function ENT:Use(activator, caller)
    if not IsValid(caller) or not caller:IsPlayer() then return end

    net.Start("OpenWorkbenchGUI")
    net.WriteTable(caller.craftingMaterials) -- Send the player's crafting materials to the client
    net.Send(caller)
end