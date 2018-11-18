Chat.Template("showid", "<img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAE5SURBVDhPxZNfS8JQGIf3SaJv2WU30V0R/WEQUnRTbdOpre04jWYzMMECU+emm42mpkkYhEHdvHle2khWo1154OH8+HHeB3YOYxa/2NWT5TNWSUn7RIkDnaGzjJRQjb7Zhel4hIxsF4Yznp3HyK5nOCAn8i1G3M5qg1YdXj0L6Tdr0GvU4D9dek8qo+Bz0gXKxDNB5xQo8TJmv/+LkOCKJzB9EBFdIMFBq1KFcraIvLgG7m9P7bBA5yT48ESEZr8ftuvgVG/neB/bYcHlMQG3IoB7I2COJZDFAqwJKVgXuBmnmM+TeRT8/ASafXEgoBd2qOaAbRTmOFBJ5GUGgtCTNe/Dz/hLh4LMrli3igQGdxeIXcpBRyfgXKuRnakpkN5JNZitlaMlfoPP8JtJLRazGTr7/UcsbDHMF28/dfzPChDpAAAAAElFTkSuQmCC\" height=\"20\" />  <b>{0}</b>: {1}")

function FormatPhoneNumber(value)
    return "^3(^5"..value:sub(1, 3).."^3) ^5"..value:sub(4, 6).."^3-^5"..value:sub(7, 10)
end

Chat.Command({"pn", "phonenumber", "number"}, function(source, args, fullCommand)
    TriggerEvent("phone:number", source, function(phone_number)
        if phone_number then
            Chat.Message(-1, "^0-", "^5"..GetIdentity(source).."  ^0notes down "..FormatPhoneNumber(phone_number).." ^0and passes it to the nearest person", 48, 177, 232, true, nil, 5, source)
        else
            Chat.Message(source, "INFO", "Unable to get phone number? >.>", 255, 0, 0, true)
        end
    end)
end, false, {Help = "Share your phone number", Params = {}})

Chat.Command("showid", function(source, args, fullCommand)
    local license = ""
    TriggerEvent("core:getuser", source, function(user)
        if user ~= nil then
            if user.get("drivers_license") == "true" then
                license = "Valid"
            else
                license = "Suspended"
            end
            Chat.Message(-1, "", "^5First name^0: ^3"..user.get("first_name").."^0, ^5Last name^0: ^3"..user.get("last_name").."^0, ^5DOB^0: ^3"..user.get("dob").."^0, ^5Occupation^0: ^3"..user.get("job").name.."^0, ^5Drivers License^0: ^3"..license, 48, 177, 232, true, "showid", 5, source)
        else
            Chat.Message(source, "INFO", "Unable share id? >.>", 255, 0, 0, true)
        end
    end)
end, false, {Help = "Share your Identification", Params = {}})