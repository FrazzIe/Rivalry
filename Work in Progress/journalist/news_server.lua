RegisterServerEvent("news:load-news")
AddEventHandler("news:load-news", function(openUI)
    local time_t = ""
    local editor_t = ""
    local header_t = ""
    local body_t = ""
    local header2_t = ""
    local body2_t = ""
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM news_news", {}, function(news)
        if(news[1] == nil) then
            TriggerClientEvent("news:load-news")
        else
            for k, v, in ipairs(news)do
                if(v.id == 1)then
                    time_t = v.time
                    editor_t = v.editor_name
                    header_t = v.header
                    body_t = v.body
                    header2_t = v.header2
                    body2_t = v.body2
                end
            end
            TriggerClientEvent("news:load-news", time, editor, header, body, header2, body2)
        end
    end)
end)

RegisterServerEvent("news:submit")
AddEventHandler("news:submit", function(time, editor_name, header, body, header2, body2)
    local source = source;
    local news = exports['GHMattiMySQL']:QueryResult("INSERT INTO news_news (`time`,`editor_name`,`header`,`body`,`header2`, `body2`) VALUES (@time,@editor_name,@header,@body,@header2,@body2); SELECT * FROM news_news WHERE `id` = (SELECT LAST_INSERT_ID());", { 
        ['@time'] = time,
        ['@editor_name'] = editor_name,
        ['@header'] = header,
        ['@body'] = body,
        ['@header2'] = header2,
        ['@body2'] = body2,
    })
    TriggerClientEvent("news:new-news", -1, news, time, editor_name, header, body, header2, body2)
end)

RegisterServerEvent("news:remove-news")
AddEventHandler("news:remove-news", function(id)
    exports['GHMattiMySQL']:QueryAsync("DELETE FROM news_news WHERE id=@id", { ['@id'] = id})
    TriggerClientEvent("news:remove-news", -1, id)
end)
