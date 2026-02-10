#Requires AutoHotkey v2.0
#SingleInstance Force

; ==============================================================================
; DATA: THE BLOCKS
; ==============================================================================
csvBlocks := "
(
; --- Block 1: a ---
1DE7,0363,E100
1D45,1D43,1D44;
03B1,0061,0250
E340,2090,E300

; --- Block 2: b ---
1DE9,1DE8,E101,E102
1D5D,1D47,1DFD2,E200
03B2,0062,0180,E000
1D66,E301,E302,E303

; --- Block 3: c ---
0368,E103
1D9C,E201
0063,A793
E304,E305

; --- Block 4: d ---
E141,0369,E104,E105
1D5F,1D48,1DFD3,E202
03B4,0064,0111,E001
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
03B3,0067,01E5,E002
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
019B,03BB,006C,0142,E003,019A
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
03C1,0072,0279,0281,AB4B,E004
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
VOID,VOID,VOID,E181,VOID,VOID,VOID,VOID,VOID,0361
VOID,1AE8,1DD1,0308,VOID,E180,VOID,030B,030C,0311
VOID,0304,0303,0307,030A,0313,030D,0301,0302,0306
002B,002D,007E,002E,00B0,002C,0027,002F,005E,0030
031F,0331,0330,0323,0325,0326,0329,0300,032C,032F
VOID,0347,1AB6,0324,VOID,1AB7,VOID,030F,VOID,032E
VOID,VOID,VOID,VOID,VOID,1AB8,VOID,VOID,VOID,035C
)"

; ==============================================================================
; INITIALIZATION
; ==============================================================================
GridMap := Map() 
FusionMap := Map()

; --- DEFINE FUSION RULES ---
; l + Combining Tilde (0303) -> ɫ (026B)
FusionMap[Chr(0x006C) . Chr(0x0303)] := Chr(0x026B)

; Parse the text
CurrentGrid := []
Loop Parse, csvBlocks, "`n", "`r" {
    Line := Trim(A_LoopField)
    if (SubStr(Line, 1, 1) = ";")
        continue

    if (Line = "") {
        if (CurrentGrid.Length > 0) {
            ProcessGrid(CurrentGrid)
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
    ProcessGrid(CurrentGrid)

; ==============================================================================
; PROCESSOR
; ==============================================================================
ProcessGrid(Layout) {
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
                
            if (!GridMap.Has(Char))
                GridMap[Char] := {U: "", D: "", L: "", R: ""}
            
            if (r > 1 && c <= Layout[r-1].Length && Layout[r-1][c] != "")
                GridMap[Char].U := Layout[r-1][c]
            if (r < MaxRows && c <= Layout[r+1].Length && Layout[r+1][c] != "")
                GridMap[Char].D := Layout[r+1][c]
            if (c > 1 && Layout[r][c-1] != "")
                GridMap[Char].L := Layout[r][c-1]
            if (c < MaxCols && Layout[r][c+1] != "")
                GridMap[Char].R := Layout[r][c+1]
        }
    }
}

; ==============================================================================
; HOTKEYS
; ==============================================================================
SetCapsLockState "AlwaysOff"

; Vertical: Naked Arrows
$Up::   Navigate("U")
$Down:: Navigate("D")
$Left:: Navigate("L")
$Right::Navigate("R")

; Horizontal: Alt + Arrows
!Left:: Send("{Left}")
!Right::Send("{Right}")
!Up::   Send("{Up}")
!Down:: Send("{Down}")

; LIGATURE: o + e -> œ
:?*:o+e::{Text}œ

; ==============================================================================
; NAVIGATION ENGINE
; ==============================================================================
Navigate(Dir) {
    SavedClip := ClipboardAll()
    A_Clipboard := "" 
    
    Send("+{Left}^c")
    if !ClipWait(0.1) {
        DoStandard(Dir)
        A_Clipboard := SavedClip
        return
    }
    
    Full := A_Clipboard
    if (Full == "") {
        DoStandard(Dir)
        A_Clipboard := SavedClip
        return
    }

    Tail := SubStr(Full, -1)
    if (Ord(Tail) >= 0xDC00 && Ord(Tail) <= 0xDFFF) {
        LastChar := SubStr(Full, -2)
        Stem     := SubStr(Full, 1, StrLen(Full)-2)
    } else {
        LastChar := Tail
        Stem     := SubStr(Full, 1, StrLen(Full)-1)
    }

    if (GridMap.Has(LastChar)) {
        Target := ""
        if (Dir = "U")      
            Target := GridMap[LastChar].U
        else if (Dir = "D") 
            Target := GridMap[LastChar].D
        else if (Dir = "L") 
            Target := GridMap[LastChar].L
        else if (Dir = "R") 
            Target := GridMap[LastChar].R
            
        if (Target != "") {
            Send("{Text}" . Stem . Target)
            CheckFusion()
        } else {
            Send("{Right}") 
        }
    } else {
        Send("{Right}") 
        DoStandard(Dir)
    }
    
    A_Clipboard := SavedClip
}

DoStandard(Dir) {
    if (Dir = "U") 
        Send("{Up}")
    else if (Dir = "D") 
        Send("{Down}")
    else if (Dir = "L") 
        Send("{Left}")
    else if (Dir = "R") 
        Send("{Right}")
}

CheckFusion() {
    SavedClip := ClipboardAll()
    A_Clipboard := ""
    
    Send("+{Left}^c")
    if !ClipWait(0.05) {
        Send("{Right}") 
        A_Clipboard := SavedClip
        return
    }
    
    CurrentSelect := A_Clipboard
    TargetSequence := Chr(0x006C) . Chr(0x0303) ; l + ~
    
    if (CurrentSelect = TargetSequence) {
        Send("{Text}" . Chr(0x026B))
    } 
    else if (CurrentSelect = Chr(0x0303)) {
        ; Partial match. We need to grab one more char left.
        Send("+{Left}^c")
        if !ClipWait(0.05) {
            Send("{Right}") 
            A_Clipboard := SavedClip
            return
        }
        
        CurrentSelect := A_Clipboard
        if (CurrentSelect = TargetSequence) {
            Send("{Text}" . Chr(0x026B))
        } else {
            Send("{Right}") ; Not a match, revert cursor
        }
    } 
    else {
        ; No match (or something else selected), put cursor back
        Send("{Right}")
    }
    
    A_Clipboard := SavedClip
}