repeat
    task.wait()
until game:IsLoaded()
local Scraped = {}
if isfile(game.PlaceId .. "_Scraped.json") then
    Scraped = game.HttpService:JSONDecode(readfile(game.PlaceId .. "_Scraped.json"))
end
function CheckIfScraped(AnimationId)
    for Index, ScrapedAnimationId in pairs(Scraped) do
        if AnimationId == ScrapedAnimationId then
            return true
        end
    end
end
for Index, Animation in pairs(game:GetDescendants()) do
    if Animation.ClassName == "Animation" and not CheckIfScraped(Animation.AnimationId) and tonumber(Animation.AnimationId:sub(14, #Animation.AnimationId)) and tonumber(Animation.AnimationId:sub(14, #Animation.AnimationId)) ~= 0 then
        local AssetName = game.MarketplaceService:GetProductInfo(tonumber(Animation.AnimationId:sub(14, #Animation.AnimationId)))["Name"]
        if AssetName then
            Scraped[AssetName] = Animation.AnimationId
        end
    end
end
writefile(game.PlaceId .. "_Scraped.json", game.HttpService:JSONEncode(Scraped))
