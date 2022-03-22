local Virovirokun, super = Class(Encounter)

function Virovirokun:init()
    super:init(self)

    self.text = "* Virovirokun floated in!"

    self:addEnemy("virovirokun", 530, 148)
    self:addEnemy("virovirokun", 560, 262)
    --self:addEnemy("virovirokun")
    --self:addEnemy("virovirokun")

    self.background = true
    self.music = "battle"

    --self.default_xactions = false

    --Game.battle:registerXAction("susie", "Snap")
    --Game.battle:registerXAction("susie", "Supercharge", "Charge\nfaster", 80)
end

--[[function Virovirokun:getDialogueCutscene()
    if Game.battle.turn_count == 2 then
        local enemies = Game.battle:getActiveEnemies()
        if #enemies == 2 then
            return function(cutscene)
                cutscene:enemyText(enemies[1], "My fellow Americans,")
                cutscene:text("Obama???", "surprise_smile", "susie")
                cutscene:enemyText(enemies[1], "let me be clear")

                Assets.playSound("snd_deathnoise", 1, 0.75)
                local alphafx = enemies[1]:addFX(AlphaFX(1))
                Game.battle.timer:tween(1, alphafx, {alpha = 0})

                cutscene:wait(2.5)
                Game.battle:removeEnemy(enemies[1], false)

                cutscene:enemyText(enemies[2], "OBAMA NOOOOOOOOOOO\nOOOOOOOOOOOOOOOOOO\nOOOOOOOOOOOOOOOOOO\nOOOOOOOOOOOOOOOOOO", {wait = false})

                cutscene:after(function()
                    Game.battle:setState("VICTORY")
                end, true)
            end
        end
    end
end]]

function Virovirokun:onGlowshardUse(user)
    local lines = ""
    for _, enemy in ipairs(Game.battle.enemies) do
        lines = lines .. "* " .. enemy.name .. " blew up!\n"
        enemy:explode(0, 0, true)
        enemy:hurt(enemy.health * 0.75, user)
    end
    local inventory = Game.inventory:getStorage("item")
    for index,item in ipairs(inventory) do
        if item.id == "glowshard" then
            Game.inventory:removeItem("item", index)
            break
        end
    end
    return {
        "* "..user.chara.name.." used the GLOWSHARD!",
        lines,
        "* The GLOWSHARD disappeared!"
    }
end

function Virovirokun:update(dt)
    if Game.battle.state == "DEFENDING" then
        if Input.pressed("menu") then
            Game.battle:swapSoul(PinkSoul())
        end
    end

    super:update(self, dt)
end

return Virovirokun