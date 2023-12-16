include("init.lua")

function ENT:Draw()
    self:DrawModel()
end

-- Declare the frame variable outside the function
local frame = nil

net.Receive("OpenMaterialsVendorGUI", function()
    local craftingMaterials = net.ReadTable()

    -- Check if the frame is already open
    if IsValid(frame) then return end

    -- Create a frame
    frame = vgui.Create("DFrame")
    frame:SetSize(500, 300)
    frame:Center()
    frame:SetTitle("Materials Vendor")
    frame:SetVisible(true)
    frame:SetDraggable(true)
    frame:ShowCloseButton(true)
    frame:MakePopup()
    frame.Paint = function(self, w, h)
        draw.RoundedBox(5, 0, 0, w, h, Color(40, 40, 40, 255)) -- Dark theme
    end

    -- When the frame is closed, clear the variable
    frame.OnClose = function()
        frame = nil
    end

    -- Create a list view to display the crafting materials
    local listView = vgui.Create("DListView", frame)
    listView:Dock(FILL)
    listView:SetMultiSelect(false)
    listView:AddColumn("Material")
    listView:AddColumn("Quantity")

    -- Add the crafting materials to the list view
    for material, quantity in pairs(craftingMaterials) do
        listView:AddLine(material, quantity)
    end
end)