#Requires AutoHotkey v2.0
#SingleInstance Force

; ==============================================================================
; BLOCKS
; ==============================================================================
csvBlocks := "
(
; --- Block 1: a ---
1DE7,0363,E100
1D45,1D43,1D44
03B1,0061,0250
E340,2090,E300

; --- Block 2: b ---
1DE9,1DE8,E101,E102
1D5D,1D47,1DFD2,E200
03B2,0062,0180,1DF8C
1D66,E301,E302,E303

; --- Block 3: c ---
0368,E103
1D9C,E201
0063,A793
E304,E305

; --- Block 4: d ---
E141,0369,E104,E105
1D5F,1D48,1DFD3,E202
03B4,0064,0111,1DF8D
E341,E306,E307,E308

; --- Block 5: e ---
E142,0364,1DEA
1D4B,1D49,1D4A
03B5,0065,0259
E342,2091,2094

; --- Block 6: f ---
E154,1DEB
1D60,1DA0
03C6,0066
1D69,E309

; --- Block 7: g ---
E140,1DDA,E106,E107
1D5E,1D4D,1DFD4,E203
03B3,0067,01E5,1DF8E
1D67,E30A,E30B,E30C

; --- Block 8: h ---
E144,036A,E108
E241,02B0,02B1
03B7,0068,0266
E344,2095,E30D

; --- Block 9: i ---
E146,0365,E109
1DA5,2071,1D4E
03B9,0069,1D09
E346,1D62,E30E

; --- Block 10: j ---
E10A
02B2
006A
2C7C

; --- Block 11: k ---
E14C,E147,1DDC
E247,E242,1D4F
03BE,03BA,006B
E34C,E347,2096

; --- Block 12-A: l ---
E149,E148,1DDD,E10D,E10E,E10F
E244,E243,02E1,1DFD5,E204,1DFD6
019B,03BB,006C,0142,1DF8F,019A
E349,E348,2097,E311,E312,E313

; --- Block 12-B: ɫ ---
E10C,E10B
AB5E,AB5D
026B,AB37
E310,E30F

; --- Block 13: m ---
E14A,036B,E110
E245,1D50,1DAC
03BC,006D,0271
E34A,2098,E314

; --- Block 14: n ---
E14B,1DE0,E111,E112
E246,207F,1D51,E205
03BD,006E,014B,1DF4F
E34B,2099,E315,E316

; --- Block 15-A: o ---
E14D,E158,0366,E114,E113
E248,1DFF4,1D52,107A2,1DFCE
03BF,03C9,006F,00F8,1DF58
E34D,E355,2092,E318,E317

; --- Block 15-B: œ ---
E115
A7F9
0153
E319

; --- Block 16: p ---
E157,E14E,1DEE
1DFF3,E249,1D56
03C8,03C0,0070
E354,E34E,209A

; --- Block 17: q ---
E116
107A5
0071
E31A

; --- Block 18: r ---
E14F,036C,E117,E118,E119,E11A
E24A,02B3,02B4,02B6,E206,E207
03C1,0072,0279,0281,AB4B,1DF8B
1D68,1D63,E31B,E31C,E31D,E31E

; --- Block 19: s ---
E150,E151,1DE4,1DEF
E24B,E24C,02E2,1DB4
03C2,03C3,0073,0283
E34F,E350,209B,E31F

; --- Block 20: t ---
E145,E152,036D,E11B
1DBF,E24D,1D57,E208
03B8,03C4,0074,0167
E345,E351,209C,E320

; --- Block 21: u ---
E153,0367,E11D,E11C
1DB7,1D58,AB5F,1DFCF
03C5,0075,AB52,1DF59
E352,1D64,E322,E321

; --- Block 22: v ---
036E
1D5B
0076
1D65

; --- Block 23: w ---
1DF1
02B7
0077
209D

; --- Block 24: x ---
E156,E155,036F,VOID
E24E,1D61,02E3,VOID
1DF54,03C7,0078,02DF
E353,1D6A,2093,VOID

; --- Block 25: y ---
E11E
02B8
0079
209E

; --- Block 26: z ---
E143,1DE6,E11F
E240,1DBB,1DBE
03B6,007A,0292
E343,209F,E323

; --- Block 27: ? ---
VOID,VOID,E120
VOID,VOID,02C0
00BF,003F,0294
VOID,VOID,E324

; --- Block 28: <> ---
00AB,2039,003C,003E,203A,00BB

; --- Block 29: | ---
VOID,2534,VOID
253C,007C,253C
VOID,252C,VOID

; --- Block 30: () ---
1ABB,VOID
207D,207E
0028,0029
208D,208E
1ABD,VOID

; --- Block 31: +-~.°,'/^0 ---
VOID,VOID,VOID,E180,VOID,VOID,VOID,VOID,VOID,0361
VOID,1AE8,1AF2,0308,VOID,1AF3,VOID,030B,030C,0311
VOID,0304,0303,0307,030A,0313,030D,0301,0302,0306
002B,002D,007E,002E,00B0,002C,0027,002F,005E,0030
031F,0331,0330,0323,0325,0326,0329,0300,032C,032F
VOID,0347,1AB6,0324,VOID,1AB7,VOID,030F,VOID,032E
VOID,VOID,VOID,VOID,VOID,1AB8,VOID,VOID,VOID,035C
)"

; ==============================================================================
; SHADOW BLOCKS
; ==============================================================================
csvShadowBlocks := "
(
VOID,VOID,VOID,VOID,VOID,VOID,VOID,VOID,VOID,VOID
VOID,VOID,VOID,VOID,VOID,VOID,VOID,VOID,VOID,VOID
VOID,VOID,VOID,VOID,VOID,VOID,VOID,VOID,VOID,VOID
VOID,VOID,VOID,VOID,VOID,VOID,VOID,VOID,VOID,VOID
E18D,E189,E18C,E185,E18E,E184,E18F,VOID,E18B,E187
VOID,E18A,VOID,E186,VOID,E181,VOID,VOID,VOID,E188
VOID,VOID,VOID,VOID,VOID,E182,VOID,VOID,VOID,VOID
)"

; ==============================================================================
; INITIALIZATION & MAPS
; ==============================================================================
GridMap := Map() 
ShadowGridMap := Map()
FusionMap := Map()

; --- DEFINE FUSION RULES ---
FusionMap[Chr(0x006C) . Chr(0x0303)] := Chr(0x026B)

; --- SHADOW ENTRY MAP ---
global ShadowEntryMap := Map(
    Chr(0x031F), Chr(0xE18D),
    Chr(0x0331), Chr(0xE189),
    Chr(0x0330), Chr(0xE18C),
    Chr(0x0323), Chr(0xE185),
    Chr(0x0325), Chr(0xE18E),
    Chr(0x0326), Chr(0xE184),
    Chr(0x0329), Chr(0xE18F),
    Chr(0x032C), Chr(0xE18B),
    Chr(0x032F), Chr(0xE187),
    Chr(0x0347), Chr(0xE18A),
    Chr(0x0324), Chr(0xE186),
    Chr(0x1AB7), Chr(0xE181),
    Chr(0x032E), Chr(0xE188),
    Chr(0x1AB8), Chr(0xE182)
)

; --- CEDILLA BASES ---
global CedillaBases := Map(
    Chr(0x0043), true,  ; capital c (just for spelling French words)
    Chr(0x0063), true,  ; baseline c
    Chr(0x1D9C), true,  ; superscript c
    Chr(0x0368), true,  ; combining c
    Chr(0xE304), true,   ; subscript c
    Chr(0xA793), true,  ; baseline ꞓ
    Chr(0xE201), true,  ; superscript ꞓ
    Chr(0xE103), true,   ; combining ꞓ
    Chr(0xE305), true   ; subscript ꞓ
)

; --- COMBINING LETTERS ABOVE ---
global CombiningLettersAbove := Map(
    Chr(0x1DE7), true, Chr(0x0363), true, Chr(0xE100), true,
    Chr(0x1DE9), true, Chr(0x1DE8), true, Chr(0xE101), true, Chr(0xE102), true,
    Chr(0x0368), true, Chr(0xE103), true,
    Chr(0xE141), true, Chr(0x0369), true, Chr(0xE104), true, Chr(0xE105), true,
    Chr(0xE142), true, Chr(0x0364), true, Chr(0x1DEA), true,
    Chr(0xE154), true, Chr(0x1DEB), true,
    Chr(0xE140), true, Chr(0x1DDA), true, Chr(0xE106), true, Chr(0xE107), true,
    Chr(0xE144), true, Chr(0x036A), true, Chr(0xE108), true,
    Chr(0xE146), true, Chr(0x0365), true, Chr(0xE109), true,
    Chr(0xE10A), true,
    Chr(0xE14C), true, Chr(0xE147), true, Chr(0x1DDC), true,
    Chr(0xE149), true, Chr(0xE148), true, Chr(0x1DDD), true, Chr(0xE10D), true, Chr(0xE10E), true, Chr(0xE10F), true,
    Chr(0xE10C), true, Chr(0xE10B), true,
    Chr(0xE14A), true, Chr(0x036B), true, Chr(0xE110), true,
    Chr(0xE14B), true, Chr(0x1DE0), true, Chr(0xE111), true, Chr(0xE112), true,
    Chr(0xE14D), true, Chr(0xE158), true, Chr(0x0366), true, Chr(0xE114), true, Chr(0xE113), true,
    Chr(0xE115), true,
    Chr(0xE157), true, Chr(0xE14E), true, Chr(0x1DEE), true,
    Chr(0xE116), true,
    Chr(0xE14F), true, Chr(0x036C), true, Chr(0xE117), true, Chr(0xE118), true, Chr(0xE119), true, Chr(0xE11A), true,
    Chr(0xE150), true, Chr(0xE151), true, Chr(0x1DE4), true, Chr(0x1DEF), true,
    Chr(0xE145), true, Chr(0xE152), true, Chr(0x036D), true, Chr(0xE11B), true,
    Chr(0xE153), true, Chr(0x0367), true, Chr(0xE11D), true, Chr(0xE11C), true,
    Chr(0x036E), true,
    Chr(0x1DF1), true,
    Chr(0xE156), true, Chr(0xE155), true, Chr(0x036F), true,
    Chr(0xE11E), true,
    Chr(0xE143), true, Chr(0x1DE6), true, Chr(0xE11F), true,
    Chr(0xE120), true
)

; ==============================================================================
; PROCESSORS
; ==============================================================================
; Parse Standard Grid
CurrentGrid := []
Loop Parse, csvBlocks, "`n", "`r" {
    Line := Trim(A_LoopField)
    if (SubStr(Line, 1, 1) = ";" || Line = "") {
        if (CurrentGrid.Length > 0) {
            ProcessGrid(CurrentGrid, GridMap)
            CurrentGrid := []
        }
        continue
    }
    RowItems := []
    Loop Parse, Line, "," {
        CleanHex := Trim(A_LoopField)
        if (CleanHex != "" && CleanHex != "VOID") {
            try {
                RowItems.Push(Chr("0x" . CleanHex))
            } catch {
                RowItems.Push("") 
            }
        } else {
            RowItems.Push("")
        }
    }
    if (RowItems.Length > 0)
        CurrentGrid.Push(RowItems)
}
if (CurrentGrid.Length > 0)
    ProcessGrid(CurrentGrid, GridMap)

; Parse shadow grid
CurrentShadowGrid := []
Loop Parse, csvShadowBlocks, "`n", "`r" {
    Line := Trim(A_LoopField)
    if (SubStr(Line, 1, 1) = ";" || Line = "") {
        if (CurrentShadowGrid.Length > 0) {
            ProcessGrid(CurrentShadowGrid, ShadowGridMap)
            CurrentShadowGrid := []
        }
        continue
    }
    RowItems := []
    Loop Parse, Line, "," {
        CleanHex := Trim(A_LoopField)
        if (CleanHex != "" && CleanHex != "VOID") {
            try {
                RowItems.Push(Chr("0x" . CleanHex))
            } catch {
                RowItems.Push("") 
            }
        } else {
            RowItems.Push("")
        }
    }
    if (RowItems.Length > 0)
        CurrentShadowGrid.Push(RowItems)
}
if (CurrentShadowGrid.Length > 0)
    ProcessGrid(CurrentShadowGrid, ShadowGridMap)

ProcessGrid(Layout, TargetMap) {
    MaxRows := Layout.Length
    Loop MaxRows {
        r := A_Index
        Row := Layout[r]
        MaxCols := Row.Length
        
        Loop MaxCols {
            c := A_Index
            Char := Row[c]
            if (Char = "")
                continue
                
            if (!TargetMap.Has(Char))
                TargetMap[Char] := {U: "", D: "", L: "", R: ""}
            
            if (r > 1 && c <= Layout[r-1].Length && Layout[r-1][c] != "")
                TargetMap[Char].U := Layout[r-1][c]
            if (r < MaxRows && c <= Layout[r+1].Length && Layout[r+1][c] != "")
                TargetMap[Char].D := Layout[r+1][c]
            if (c > 1 && Layout[r][c-1] != "")
                TargetMap[Char].L := Layout[r][c-1]
            if (c < MaxCols && Layout[r][c+1] != "")
                TargetMap[Char].R := Layout[r][c+1]
        }
    }
}

; ==============================================================================
; STATE TRACKING
; ==============================================================================
global GlobalTextBuffer := ""

ih := InputHook("V L0")
ih.OnChar := OnCharCallback
ih.OnKeyDown := OnKeyDownCallback
ih.KeyOpt("{Space}{Enter}{Tab}{Escape}{Backspace}{Delete}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}", "N")
ih.Start()

OnCharCallback(ih, char) {
    global GlobalTextBuffer
    GlobalTextBuffer .= char
    if (StrLen(GlobalTextBuffer) > 5)
        GlobalTextBuffer := SubStr(GlobalTextBuffer, -5) 
}

OnKeyDownCallback(ih, vk, sc) {
    global GlobalTextBuffer
    GlobalTextBuffer := ""
}

~LButton::
~RButton::
~MButton:: {
    global GlobalTextBuffer := ""
}

; ==============================================================================
; HOTKEYS
; ==============================================================================
$Up::   Navigate("U")
$Down:: Navigate("D")
$Left:: Navigate("L")
$Right::Navigate("R")

!Left:: Send("{Left}")
!Right::Send("{Right}")
!Up::   Send("{Up}")
!Down:: Send("{Down}")

:?*:o+e:: {
    global GlobalTextBuffer
    Send("{Text}œ")
    GlobalTextBuffer .= "œ" 
}

; ==============================================================================
; NAVIGATION, SHADOW GRID, FUSION
; ==============================================================================
Navigate(Dir) {
    global GlobalTextBuffer
    
    if (GlobalTextBuffer = "")
        return

    BufferLen := StrLen(GlobalTextBuffer)
    LastChar := SubStr(GlobalTextBuffer, -1)
    
    ; Surrogate pair check
    if (Ord(LastChar) >= 0xDC00 && Ord(LastChar) <= 0xDFFF && BufferLen >= 2) {
        LastChar := SubStr(GlobalTextBuffer, -2)
    }

    PrevChar := ""
    if (BufferLen >= StrLen(LastChar) + 1) {
        PrevChar := SubStr(GlobalTextBuffer, -(StrLen(LastChar) + 1), 1)
    }

    ; --- STATE 1: TRAVERSING THE SHADOW GRID ---
    ; User is already moving around within the Shadow Grid
    if (CombiningLettersAbove.Has(LastChar) && ShadowGridMap.Has(PrevChar)) {
        Target := ""
        if (Dir = "U") {
            Target := ShadowGridMap[PrevChar].U
        } else if (Dir = "D") {
            Target := ShadowGridMap[PrevChar].D
        } else if (Dir = "L") {
            Target := ShadowGridMap[PrevChar].L
        } else if (Dir = "R") {
            Target := ShadowGridMap[PrevChar].R
        }

        if (Target != "") {
            Send("{Backspace 2}")
            Send("{Text}" . Target . LastChar)
            GlobalTextBuffer := SubStr(GlobalTextBuffer, 1, BufferLen - StrLen(LastChar) - StrLen(PrevChar)) . Target . LastChar
            CheckCedillaSwap()
        }
        return ; Ends here to prevent falling into standard navigation
    }

    ; --- STATE 2: ENTERING SHADOW GRID ---
    ; User has hit a trigger (like '.') directly after a combining letter
    if (CombiningLettersAbove.Has(PrevChar) && GridMap.Has(LastChar)) {
        StandardTarget := ""
        if (Dir = "U") {
            StandardTarget := GridMap[LastChar].U
        } else if (Dir = "D") {
            StandardTarget := GridMap[LastChar].D
        } else if (Dir = "L") {
            StandardTarget := GridMap[LastChar].L
        } else if (Dir = "R") {
            StandardTarget := GridMap[LastChar].R
        }

        if (StandardTarget != "" && ShadowEntryMap.Has(StandardTarget)) {
            ShadowTarget := ShadowEntryMap[StandardTarget]
            
            Send("{Backspace 2}")
            Send("{Text}" . ShadowTarget . PrevChar)
            GlobalTextBuffer := SubStr(GlobalTextBuffer, 1, BufferLen - StrLen(LastChar) - StrLen(PrevChar)) . ShadowTarget . PrevChar
            CheckCedillaSwap()
            return
        }
    }

    ; --- STATE 3: STANDARD NAVIGATION ---
    if (GridMap.Has(LastChar)) {
        Target := ""
        if (Dir = "U") {
            Target := GridMap[LastChar].U
        } else if (Dir = "D") {
            Target := GridMap[LastChar].D
        } else if (Dir = "L") {
            Target := GridMap[LastChar].L
        } else if (Dir = "R") {
            Target := GridMap[LastChar].R
        }
            
        if (Target != "") {
            Send("{Backspace}")
            Send("{Text}" . Target)
            GlobalTextBuffer := SubStr(GlobalTextBuffer, 1, BufferLen - StrLen(LastChar)) . Target
            
            CheckFusionState()
            CheckCedillaSwap()
        }
    } else {
        GlobalTextBuffer := "" 
    }
}

CheckFusionState() {
    global GlobalTextBuffer
    
    if (StrLen(GlobalTextBuffer) < 2)
        return
        
    LastTwo := SubStr(GlobalTextBuffer, -2)
    
    if (FusionMap.Has(LastTwo)) {
        FusionChar := FusionMap[LastTwo]
        Send("{Backspace 2}")
        Send("{Text}" . FusionChar)
        GlobalTextBuffer := SubStr(GlobalTextBuffer, 1, StrLen(GlobalTextBuffer) - 2) . FusionChar
    }
}

CheckCedillaSwap() {
    global GlobalTextBuffer
    
    if (StrLen(GlobalTextBuffer) < 2)
        return
        
    LastChar := SubStr(GlobalTextBuffer, -1)
    PrevChar := SubStr(GlobalTextBuffer, -2, 1)
    
    ; 1. Standard cedilla check
    if (CedillaBases.Has(PrevChar) && LastChar = Chr(0x0326)) {
        Cedilla := Chr(0x0327)
        Send("{Backspace}")
        Send("{Text}" . Cedilla)
        GlobalTextBuffer := SubStr(GlobalTextBuffer, 1, StrLen(GlobalTextBuffer) - 1) . Cedilla
        return
    }

    ; 2. Shadow cedilla check (combining c + shadow comma)
    ; In the shadow grid, buffer is [shadow comma above] + [combining c]
    if (CedillaBases.Has(LastChar) && PrevChar = Chr(0xE184)) {
        ShadowCedilla := Chr(0xE183)
        Send("{Backspace 2}")
        Send("{Text}" . ShadowCedilla . LastChar)
        
        ; Clear the board to prevent stranded 'c'
        GlobalTextBuffer := "" 
    }
}

; ==============================================================================
; SMALLCAPS
; ==============================================================================
#HotIf GetKeyState("CapsLock", "T")
a::Send "{Text}ᴀ"
b::Send "{Text}ʙ"
c::Send "{Text}ᴄ"
d::Send "{Text}ᴅ"
e::Send "{Text}ᴇ"
f::Send "{Text}ꜰ"
g::Send "{Text}ɢ"
h::Send "{Text}ʜ"
i::Send "{Text}ɪ"
j::Send "{Text}ᴊ"
k::Send "{Text}ᴋ"
l::Send "{Text}ʟ"
m::Send "{Text}ᴍ"
n::Send "{Text}ɴ"
o::Send "{Text}ᴏ"
p::Send "{Text}ᴘ"
q::Send "{Text}ꞯ"
r::Send "{Text}ʀ"
s::Send "{Text}ꜱ"
t::Send "{Text}ᴛ"
u::Send "{Text}ᴜ"
v::Send "{Text}ᴠ"
w::Send "{Text}ᴡ"
x::Send "{Text}x"
y::Send "{Text}ʏ"
z::Send "{Text}ᴢ"
#HotIf