-- Author: User319183
-- Date: 12/3/2023

--imports
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

--variables
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Mouse = LocalPlayer:GetMouse()

local settings = {
    speed = 1; --how fast we walk
    tolerance = 1; --how close we need to be to the target
    stop = false; --if we should stop walking
    jumpOnObstacle = true; --if we should jump over obstacles
} 

local targets = {
    {Vector3.new(x, y, z), Vector3.new(x, y, z)}; --{start, end}
    {Vector3.new(x, y, z), Vector3.new(x, y, z)}; --{start, end}
    {Vector3.new(x, y, z), Vector3.new(x, y, z)}; --{start, end}
    {Vector3.new(x, y, z), Vector3.new(x, y, z)}; --{start, end}
    {Vector3.new(x, y, z), Vector3.new(x, y, z)}; --{start, end}
}

local function checkIfStuck()
    local stuck = false
    local ray = Ray.new(RootPart.Position, RootPart.CFrame.LookVector * 4)
    local part, position = Workspace:FindPartOnRayWithIgnoreList(ray, {Character, Workspace.Terrain})
    if part then
        stuck = true
    end
    return stuck
end

local function jump()
    Humanoid.Jump = true
    wait(0.1)
    Humanoid.Jump = false
end

local function walk(target)
    while not settings.stop do
        if (RootPart.Position - target[1]).Magnitude > settings.tolerance then
            local ray = Ray.new(RootPart.Position, RootPart.CFrame.LookVector * 4)
            local part, position = Workspace:FindPartOnRayWithIgnoreList(ray, {Character, Workspace.Terrain})
            if part and settings.jumpOnObstacle then
                jump()
            end
            Humanoid:MoveTo(target[1])
        else
            settings.stop = true
        end
        wait()
    end
end

function start()
    for i, target in ipairs(targets) do
        settings.stop = false
        walk(target)
    end
end

start()
