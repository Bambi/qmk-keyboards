/*
Copyright 2022 Guillaume Gérard

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public LicensezZZ
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#pragma once

#define VIAL_KEYBOARD_UID {0xD9, 0x22, 0x84, 0x09, 0x86, 0xF2, 0x9F, 0xB0}
#define VIAL_UNLOCK_COMBO_ROWS { 0, 1 }
#define VIAL_UNLOCK_COMBO_COLS { 0, 11 }
#define DYNAMIC_KEYMAP_LAYER_COUNT 4
#undef RGBLIGHT_EFFECT_RGB_TEST
#undef RGBLIGHT_EFFECT_ALTERNATING
#undef RGBLIGHT_EFFECT_KNIGHT
#define DOUBLE_TAP_SHIFT_TURNS_ON_CAPS_WORD
#define RGBLIGHT_LAYERS
#define RGBLIGHT_LAYER_BLINK
#define RGBLIGHT_DEFAULT_MODE RGBLIGHT_MODE_BREATHING
#define RGBLIGHT_DEFAULT_HUE 120
#define RGBLIGHT_DEFAULT_SAT RGBLIGHT_LIMIT_VAL
#define RGBLIGHT_DEFAULT_VAL RGBLIGHT_LIMIT_VAL
// Space Cadet
#define LAPO_KEYS KC_LALT, KC_LSFT, KC_LBRC
#define RAPC_KEYS KC_RALT, KC_LSFT, KC_RBRC
