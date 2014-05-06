--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:196e690adb3ba020a73e2608702993fb:da125cce7880041f4d370a28ebda4e7c:ca779cd82e5b7335e8f11dd2897b2ce9$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- bird/0000
            x=2,
            y=2,
            width=248,
            height=260,

            sourceX = 140,
            sourceY = 52,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- bird/0001
            x=2,
            y=264,
            width=248,
            height=258,

            sourceX = 140,
            sourceY = 54,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- bird/0002
            x=2,
            y=784,
            width=196,
            height=258,

            sourceX = 166,
            sourceY = 54,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- bird/0003
            x=2,
            y=524,
            width=196,
            height=258,

            sourceX = 166,
            sourceY = 54,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- bird/0004
            x=2,
            y=1306,
            width=140,
            height=260,

            sourceX = 193,
            sourceY = 52,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- bird/0005
            x=2,
            y=1044,
            width=140,
            height=260,

            sourceX = 193,
            sourceY = 52,
            sourceWidth = 550,
            sourceHeight = 400
        },
    },
    
    sheetContentWidth = 252,
    sheetContentHeight = 1568
}

SheetInfo.frameIndex =
{

    ["bird/0000"] = 1,
    ["bird/0001"] = 2,
    ["bird/0002"] = 3,
    ["bird/0003"] = 4,
    ["bird/0004"] = 5,
    ["bird/0005"] = 6,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
