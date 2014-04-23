--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:afceff24826416d962724706739b0c88:dbf2c6fe5bd9875749c5f04f861ebbf7:60afeb45eedbfc4d0e7dd547290316ac$
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
            -- snail/0000
            x=1046,
            y=2,
            width=114,
            height=240,

            sourceX = 200,
            sourceY = 91,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0001
            x=930,
            y=2,
            width=114,
            height=240,

            sourceX = 200,
            sourceY = 91,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0002
            x=930,
            y=244,
            width=114,
            height=238,

            sourceX = 200,
            sourceY = 93,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0003
            x=234,
            y=246,
            width=114,
            height=236,

            sourceX = 200,
            sourceY = 94,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0004
            x=118,
            y=246,
            width=114,
            height=236,

            sourceX = 200,
            sourceY = 94,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0005
            x=814,
            y=244,
            width=114,
            height=238,

            sourceX = 200,
            sourceY = 93,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0006
            x=814,
            y=2,
            width=114,
            height=240,

            sourceX = 200,
            sourceY = 91,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0007
            x=234,
            y=2,
            width=114,
            height=242,

            sourceX = 200,
            sourceY = 90,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0008
            x=698,
            y=2,
            width=114,
            height=240,

            sourceX = 200,
            sourceY = 91,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0009
            x=118,
            y=2,
            width=114,
            height=242,

            sourceX = 200,
            sourceY = 90,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0010
            x=582,
            y=2,
            width=114,
            height=240,

            sourceX = 200,
            sourceY = 92,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0011
            x=698,
            y=244,
            width=114,
            height=238,

            sourceX = 200,
            sourceY = 93,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0012
            x=582,
            y=244,
            width=114,
            height=238,

            sourceX = 200,
            sourceY = 93,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0013
            x=466,
            y=244,
            width=114,
            height=238,

            sourceX = 200,
            sourceY = 93,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0014
            x=2,
            y=246,
            width=114,
            height=236,

            sourceX = 200,
            sourceY = 94,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0015
            x=350,
            y=244,
            width=114,
            height=238,

            sourceX = 200,
            sourceY = 93,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0016
            x=466,
            y=2,
            width=114,
            height=240,

            sourceX = 200,
            sourceY = 92,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0017
            x=350,
            y=2,
            width=114,
            height=240,

            sourceX = 200,
            sourceY = 91,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0018
            x=2,
            y=2,
            width=114,
            height=242,

            sourceX = 200,
            sourceY = 90,
            sourceWidth = 550,
            sourceHeight = 400
        },
        {
            -- snail/0019
            x=1046,
            y=2,
            width=114,
            height=240,

            sourceX = 200,
            sourceY = 91,
            sourceWidth = 550,
            sourceHeight = 400
        },
    },
    
    sheetContentWidth = 1162,
    sheetContentHeight = 484
}

SheetInfo.frameIndex =
{

    ["snail/0000"] = 1,
    ["snail/0001"] = 2,
    ["snail/0002"] = 3,
    ["snail/0003"] = 4,
    ["snail/0004"] = 5,
    ["snail/0005"] = 6,
    ["snail/0006"] = 7,
    ["snail/0007"] = 8,
    ["snail/0008"] = 9,
    ["snail/0009"] = 10,
    ["snail/0010"] = 11,
    ["snail/0011"] = 12,
    ["snail/0012"] = 13,
    ["snail/0013"] = 14,
    ["snail/0014"] = 15,
    ["snail/0015"] = 16,
    ["snail/0016"] = 17,
    ["snail/0017"] = 18,
    ["snail/0018"] = 19,
    ["snail/0019"] = 20,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
