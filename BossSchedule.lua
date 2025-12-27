-- BossSchedule.lua
-- Script to calculate next bosses for Black Desert Online (SA Server)
-- Author: Antigravity

-- Table of Bosses (Time in HH:MM format, 24h)
-- 1=Sunday, 2=Monday, 3=Tuesday, 4=Wednesday, 5=Thursday, 6=Friday, 7=Saturday
-- IMPORTANT: Update this table if the schedule changes.

local schedule = {
    [1] = { -- Sunday (DOM)
        { time = "02:00", bosses = {"Nouver", "San-gun"} },
        { time = "11:00", bosses = {"Kutum", "Bulgasal"} },
        { time = "14:00", bosses = {"GARMOTH"} },
        { time = "16:00", bosses = {"Karanda", "Uturi"} },
        { time = "17:00", bosses = {"Vell"} },
        { time = "19:00", bosses = {"GARMOTH"} },
        { time = "20:00", bosses = {"Kzarka", "San-gun"} },
        { time = "23:15", bosses = {"GARMOTH"} },
        { time = "23:30", bosses = {"Nouver", "Rei dos Porcos Dourados"} }
    },
    [2] = { -- Monday (SEG)
        { time = "02:00", bosses = {"Kzarka", "Bulgasal"} },
        { time = "11:00", bosses = {"Nouver", "San-gun"} },
        { time = "14:00", bosses = {"GARMOTH"} },
        { time = "16:00", bosses = {"Kutum", "Rei dos Porcos Dourados"} },
        { time = "20:00", bosses = {"Karanda", "Uturi"} },
        { time = "23:15", bosses = {"GARMOTH"} },
        { time = "23:30", bosses = {"Offin", "Bulgasal"} }
    },
    [3] = { -- Tuesday (TER)
        { time = "02:00", bosses = {"Nouver", "Uturi"} },
        { time = "11:00", bosses = {"Kutum", "Rei dos Porcos Dourados"} },
        { time = "14:00", bosses = {"GARMOTH"} },
        { time = "16:00", bosses = {"Nouver", "San-gun"} },
        { time = "20:00", bosses = {"Kzarka", "Bulgasal"} },
        { time = "23:15", bosses = {"GARMOTH"} },
        { time = "23:30", bosses = {"Karanda", "Uturi"} }
    },
    [4] = { -- Wednesday (QUA)
        { time = "02:00", bosses = {"Offin", "Rei dos Porcos Dourados"} },
        { time = "11:00", bosses = {"Nouver", "Uturi"} },
        { time = "14:00", bosses = {"GARMOTH"} },
        { time = "16:00", bosses = {"Karanda", "San-gun"} },
        { time = "19:00", bosses = {"Quint", "Muraka"} },
        { time = "20:00", bosses = {"Kutum", "Rei dos Porcos Dourados"} },
        { time = "23:15", bosses = {"GARMOTH"} },
        { time = "23:30", bosses = {"Kzarka", "Bulgasal"} }
    },
    [5] = { -- Thursday (QUI)        
        { time = "11:00", bosses = {"Kzarka", "San-gun"} },
        { time = "14:00", bosses = {"GARMOTH"} },
        { time = "16:00", bosses = {"Nouver", "Bulgasal"} },
        { time = "20:00", bosses = {"Karanda", "Uturi"} },
        { time = "23:15", bosses = {"GARMOTH"} },
        { time = "23:30", bosses = {"Kutum", "Rei dos Porcos Dourados"} }
    },
    [6] = { -- Friday (SEX)
        { time = "02:00", bosses = {"Karanda", "San-gun"} },
        { time = "11:00", bosses = {"Offin", "Bulgasal"} },
        { time = "14:00", bosses = {"GARMOTH"} },
        { time = "16:00", bosses = {"Kzarka", "Uturi"} },
        { time = "19:00", bosses = {"Vell"} },
        { time = "20:00", bosses = {"Kutum", "Rei dos Porcos Dourados"} },
        { time = "23:15", bosses = {"GARMOTH"} },
        { time = "23:30", bosses = {"Nouver", "San-gun"} }
    },
    [7] = { -- Saturday (SÁB)
        { time = "02:00", bosses = {"Kutum", "Bulgasal"} },
        { time = "11:00", bosses = {"Karanda", "Uturi"} },
        { time = "14:00", bosses = {"GARMOTH"} },
        { time = "16:00", bosses = {"Kzarka", "Rei dos Porcos Dourados"} },
        { time = "17:00", bosses = {"Sombra Negra"} }, 
        { time = "19:00", bosses = {"Quint", "Muraka"} }
        -- No late bosses on Saturday (Siege/Conquest War)
    }
}

-- Helper: Convert "HH:MM" to minutes from start of day
function TimeToMinutes(timeStr)
    local h, m = timeStr:match("(%d+):(%d+)")
    return tonumber(h) * 60 + tonumber(m)
end

-- Helper: Convert seconds to HH:MM:SS
function SecondsToClock(seconds)
    if seconds <= 0 then return "00:00" end
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    return string.format("%02d:%02d", h, m)
end

-- Helper: Get day name from day index (1=Sunday, 7=Saturday)
function GetDayName(dayIdx)
    local days = {"Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"}
    return days[dayIdx] or "Desconhecido"
end



function Update()
    local now = os.date("*t")
    local todayIdx = now.wday -- 1=Sun .. 7=Sat
    local currentMinutes = now.hour * 60 + now.min
    local currentSecondsTotal = currentMinutes * 60 + now.sec
    
    local upcoming = {}
    
    -- Check today's remaining bosses
    if schedule[todayIdx] then
        for _, entry in ipairs(schedule[todayIdx]) do
            local bm = TimeToMinutes(entry.time)
            if bm > currentMinutes then
                table.insert(upcoming, {
                    day = "Hoje",
                    time = entry.time,
                    bosses = entry.bosses,
                    diff = (bm * 60) - currentSecondsTotal
                })
            end
        end
    end
    
    -- If no bosses today, check next days
    if #upcoming == 0 then
        for daysAhead = 1, 7 do
            local nextDayIdx = ((todayIdx - 1 + daysAhead) % 7) + 1
            if schedule[nextDayIdx] and #schedule[nextDayIdx] > 0 then
                local firstBoss = schedule[nextDayIdx][1]
                local bm = TimeToMinutes(firstBoss.time)
                
                -- Calculate time until the boss
                local secondsUntilMidnight = (24 * 60 * 60) - currentSecondsTotal
                local secondsIntoNextDay = bm * 60
                local totalSeconds = secondsUntilMidnight + ((daysAhead - 1) * 24 * 60 * 60) + secondsIntoNextDay
                
                table.insert(upcoming, {
                    day = GetDayName(nextDayIdx),
                    time = firstBoss.time,
                    bosses = firstBoss.bosses,
                    diff = totalSeconds
                })
                break
            end
        end
    end 

    -- Set Variables using SKIN:Bang
    if upcoming[1] then
        local nextB = upcoming[1]
        local bossNames = table.concat(nextB.bosses, ", ")
        -- New line separator for readability if needed, or stick to commas
        local bossNamesDisplay = table.concat(nextB.bosses, " & ")
        
        local countdown = SecondsToClock(nextB.diff)
        
        SKIN:Bang('!SetOption', 'MeterBossList', 'Text', bossNamesDisplay)
        SKIN:Bang('!SetOption', 'MeterCountdown', 'Text', countdown)
        
        -- Color Logic
        -- <= 10 mins (600s) -> Red
        -- <= 30 mins (1800s) -> Yellow
        -- <= 60 mins (3600s) -> Green
        -- > 60 mins -> White
        
        if nextB.diff <= 600 then
            SKIN:Bang('!SetVariable', 'ColorTimer', '255,80,80,255') -- Red
        elseif nextB.diff <= 1800 then
            SKIN:Bang('!SetVariable', 'ColorTimer', '255,220,50,255') -- Yellow
        elseif nextB.diff <= 3600 then
            SKIN:Bang('!SetVariable', 'ColorTimer', '100,255,100,255') -- Green
        else
            SKIN:Bang('!SetVariable', 'ColorTimer', '255,255,255,255') -- White
        end
        
    else
        SKIN:Bang('!SetOption', 'MeterBossList', 'Text', "Nenhum Boss")
        SKIN:Bang('!SetOption', 'MeterCountdown', 'Text', "--:--")
    end
    
    return "Updated"
end
