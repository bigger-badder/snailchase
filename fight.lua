--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:7a58bb9226a05db15a31e6a65612c785:8fde9133c5d94304da1bdbf41a929d60:d17c964c62a6f4982cb469a62e138684$
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
            -- fight/0000
            x=2,
            y=664,
            width=314,
            height=316,

            sourceX = 125,
            sourceY = 39,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- fight/0001
            x=2,
            y=664,
            width=314,
            height=316,

            sourceX = 125,
            sourceY = 39,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- fight/0002
            x=2,
            y=664,
            width=314,
            height=316,

            sourceX = 125,
            sourceY = 39,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- fight/0003
            x=2,
            y=2,
            width=486,
            height=306,

            sourceX = 30,
            sourceY = 61,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- fight/0004
            x=2,
            y=2,
            width=486,
            height=306,

            sourceX = 30,
            sourceY = 61,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- fight/0005
            x=2,
            y=2,
            width=486,
            height=306,

            sourceX = 30,
            sourceY = 61,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- fight/0006
            x=2,
            y=310,
            width=420,
            height=352,

            sourceX = 77,
            sourceY = 3,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- fight/0007
            x=2,
            y=310,
            width=420,
            height=352,

            sourceX = 77,
            sourceY = 3,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- fight/0008
            x=2,
            y=310,
            width=420,
            height=352,

            sourceX = 77,
            sourceY = 3,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- fight/0009
            x=2,
            y=310,
            width=420,
            height=352,

            sourceX = 77,
            sourceY = 3,
            sourceWidth = 550,
            sourceHeight = 400
        },
    },
    
    sheetContentWidth = 490,
    sheetContentHeight = 982
}

SheetInfo.frameIndex =
{

    ["fight/0000"] = 1,
    ["fight/0001"] = 2,
    ["fight/0002"] = 3,
    ["fight/0003"] = 4,
    ["fight/0004"] = 5,
    ["fight/0005"] = 6,
    ["fight/0006"] = 7,
    ["fight/0007"] = 8,
    ["fight/0008"] = 9,
    ["fight/0009"] = 10,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
