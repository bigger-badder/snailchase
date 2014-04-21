--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:c809f2f1c2e378d61e30021b85e30c21:b05330ceafb6cb4bb1f05a946e197ee9:2b36a7c67e9aa78629b2354e82fab554$
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
            -- charCatLadyRed/0000
            x=150,
            y=2,
            width=72,
            height=100,

            sourceX = 238,
            sourceY = 137,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- charCatLadyRed/0001
            x=76,
            y=2,
            width=72,
            height=100,

            sourceX = 238,
            sourceY = 137,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- charCatLadyRed/0002
            x=446,
            y=2,
            width=72,
            height=98,

            sourceX = 238,
            sourceY = 139,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- charCatLadyRed/0003
            x=372,
            y=2,
            width=72,
            height=98,

            sourceX = 238,
            sourceY = 139,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- charCatLadyRed/0004
            x=742,
            y=2,
            width=72,
            height=96,

            sourceX = 238,
            sourceY = 141,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- charCatLadyRed/0005
            x=668,
            y=2,
            width=72,
            height=96,

            sourceX = 238,
            sourceY = 141,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- charCatLadyRed/0006
            x=890,
            y=2,
            width=72,
            height=94,

            sourceX = 238,
            sourceY = 143,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- charCatLadyRed/0007
            x=816,
            y=2,
            width=72,
            height=94,

            sourceX = 238,
            sourceY = 143,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- charCatLadyRed/0008
            x=594,
            y=2,
            width=72,
            height=96,

            sourceX = 238,
            sourceY = 141,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- charCatLadyRed/0009
            x=520,
            y=2,
            width=72,
            height=96,

            sourceX = 238,
            sourceY = 141,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- charCatLadyRed/0010
            x=298,
            y=2,
            width=72,
            height=98,

            sourceX = 238,
            sourceY = 139,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- charCatLadyRed/0011
            x=224,
            y=2,
            width=72,
            height=98,

            sourceX = 238,
            sourceY = 139,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- charCatLadyRed/0012
            x=2,
            y=2,
            width=72,
            height=100,

            sourceX = 238,
            sourceY = 137,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- charCatLadyRed/0013
            x=150,
            y=2,
            width=72,
            height=100,

            sourceX = 238,
            sourceY = 137,
            sourceWidth = 550,
            sourceHeight = 400
        },
    },
    
    sheetContentWidth = 964,
    sheetContentHeight = 104
}

SheetInfo.frameIndex =
{

    ["charCatLadyRed/0000"] = 1,
    ["charCatLadyRed/0001"] = 2,
    ["charCatLadyRed/0002"] = 3,
    ["charCatLadyRed/0003"] = 4,
    ["charCatLadyRed/0004"] = 5,
    ["charCatLadyRed/0005"] = 6,
    ["charCatLadyRed/0006"] = 7,
    ["charCatLadyRed/0007"] = 8,
    ["charCatLadyRed/0008"] = 9,
    ["charCatLadyRed/0009"] = 10,
    ["charCatLadyRed/0010"] = 11,
    ["charCatLadyRed/0011"] = 12,
    ["charCatLadyRed/0012"] = 13,
    ["charCatLadyRed/0013"] = 14,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
