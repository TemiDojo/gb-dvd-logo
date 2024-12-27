INCLUDE "hardware.inc" ; Import used to interact with hardware components like (graphics system)
SECTION "Header", ROM0[$100]
    jp Init
    ds $150 - @, 0 ; Make room for the header
Init: ld a, [rLY] ; Wait for scanlines
    cp 144
    jp c, Init
    xor a
    ld [rLCDC], a ; Turn off the LCD display
    ld de, Tiles
    ld hl, $8000 ; Load where to draw tile data in Vram
    ld bc, TilesEnd-Tiles
.memcopy: ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .memcopy
    ld hl, _OAMRAM
    ld b, 160
.clear: xor a ; Clearing of OAM before enabling objects for first time
    ld [hli], a
    dec b
    jr nz, .clear
    ld hl, _OAMRAM
    ld de, SpriteData
    ld b, 9
.initSprites: ld a, [de] ; Initialize the sprites
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    ld [hli], a
    inc de
    dec b
    jr nz, .initSprites ; Loop until all sprites are initialized
    ld a, 1 ; Set global variables
    ld [wMomX], a
    ld a, -1
    ld [wMomY], a
    ld a, LCDCF_ON | LCDCF_OBJON ; Turn on the LCD
    ld [rLCDC], a
Main: ld a, [rLY] ; Wait until its not VBlank
    cp 144
    jp nc, Main
.wait: ld a, [rLY] ; Wait for VBlank to start
    cp 144
    jp c, .wait ; Keep waiting if not VBlank
    ld a, [wMomX] ; Else we start updating sprite location
    ld b, a
    ld a, [wMomY]
    ld c, a
    ld hl, _OAMRAM
    ld d, 9
.update: ld a, [hl] ; Start the sprite update
    add a, c
    ld [hl], a
    cp 16 ; Check the top boundary
    jr c, .revY ; Reverse y, if a < 16
    cp 147 ; Check bottom boundadry
    jr nc, .revY ; Reverse y, if a >= 147
.contY: inc hl ; Move to x position
    ld a, [hl]
    add a, b
    ld [hl], a
    cp 10 ; Check the left boundary
    jr c, .revX ; Reverse x, if a < 10
    cp 148 ; Check the right boundary
    jr nc, .revX ; Reverse x, if a >= 148
.contX: ld a, l ; Get current position
    add a, 3
    ld l, a
    dec d
    jr nz, .update
    jp Main
.revX: ld a, [wMomX] ; Reverse x direction
    cpl
    inc a
    ld [wMomX], a
    jr .contX
.revY: ld a, [wMomY] ; Reverse y direction
    cpl
    inc a
    ld [wMomY], a 
    jr .contY ; Continue to update
SpriteData: DB 71,68,0, 63,68,1, 63,76,2, 71,76,3, 76,68,4, 76,76,5, 76,84,6, 71,84,0, 63,84,1  ; Sprite initial positions and Tile numbers
Tiles: ; Tile graphic data
    dw `33000033,`33333333,`33333300,`00000000,`00000000,`00000000,`00000000,`00000000, `33333300,`33333333,`33000033,`00000033,`00000033,`33000033,`33000033,`33000033, `00000000,`33000033,`33000033,`33300330,`03300330,`03300330,`03300330,`03300330, `03333330,`00333300,`00333300,`00033000,`00033000,`00000000,`00000000,`00000000, `00000000,`00003333,`00333330,`33333300,`33333300,`00333330,`00003333,`00000000, `33333333,`33333333,`00000000,`00000000,`00000000,`00000000,`33333333,`33333333, `00000000,`33330000,`03333300,`00333333,`00333333,`03333300,`33330000,`00000000
TilesEnd:
SECTION "Logo Data", WRAM0
wMomX: db
wMomY: db



	
; References
; -> https://gbdev.io/gb-asm-tutorial/index.html
; Entire project can be found on my github at `https://github.com/TemiDojo/gb-dvd-logo/tree/main`
;



