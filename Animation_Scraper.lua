repeat
    task.wait()
until game:IsLoaded()
local Scraped = {}
if isfile(game.PlaceId .. "_Scraped.json") then
    Scraped = game.HttpService:JSONDecode(readfile(game.PlaceId .. "_Scraped.json"))
end
local ScrapedCount = 0
local OldScrapedCount = 0
for Index, AnimationId in pairs(Scraped) do
    ScrapedCount += 1
    OldScrapedCount += 1
end
rconsolename(game.PlaceId .. "_Scraped")
rconsoleprint("@@LIGHT_GREEN@@")
function InsertAnimation(Animation)
    if Animation then
        local function CheckIfScraped(AnimationId)
            for Index, ScrapedAnimationId in pairs(Scraped) do
                if AnimationId == ScrapedAnimationId then
                    return true
                end
            end
        end
        if not CheckIfScraped(Animation.AnimationId) and tonumber(Animation.AnimationId:sub(14, #Animation.AnimationId)) and tonumber(Animation.AnimationId:sub(14, #Animation.AnimationId)) ~= 0 then
            local AssetName = game.MarketplaceService:GetProductInfo(tonumber(Animation.AnimationId:sub(14, #Animation.AnimationId)))["Name"]
            if AssetName and not Scraped[AssetName] then
                ScrapedCount += 1
                rconsoleprint(AssetName .. " : " .. Animation.AnimationId .. "\n")
                Scraped[AssetName] = Animation.AnimationId
            end
        end
    end 
end
for Index, Unknown in pairs(game:GetDescendants()) do
    if Unknown.ClassName == "Animation" then
        InsertAnimation(Unknown)
    elseif Unknown.ClassName == "Humanoid" then
        for Index, AnimationTrack in pairs(Unknown:GetPlayingAnimationTracks()) do
            InsertAnimation(AnimationTrack.Animation)
        end
    end
end
if ScrapedCount > OldScrapedCount then
    writefile(game.PlaceId .. "_Scraped.json", game.HttpService:JSONEncode(Scraped))
end
