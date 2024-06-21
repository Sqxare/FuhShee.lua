local args = {
    [1] = "Leave"
}

game:GetService("ReplicatedStorage").sbEvent:FireServer(unpack(args))

wait(0.4) -- Wait for 1 second

-- Kick the player from the game
game:GetService("Players").LocalPlayer:Kick("No Loss Success")

-- Rejoin the server
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
