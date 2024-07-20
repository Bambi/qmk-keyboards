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

#include "./json-keymap.c"

#ifdef RGBLIGHT_LAYERS
// Leds are indexed from left to right
// Light LEDs 1 & 2 red when caps lock is active.
const rgblight_segment_t PROGMEM my_capslock_layer[] = RGBLIGHT_LAYER_SEGMENTS(
    {1, 2, HSV_RED}       // Light 4 LEDs, starting with LED 6
);
// Light LEDs 9 & 10 in cyan when keyboard layer 1 is active
const rgblight_segment_t PROGMEM my_layer1_layer[] = RGBLIGHT_LAYER_SEGMENTS(
    {1, 2, HSV_BLUE}
);
// Light LEDs 11 & 12 in purple when keyboard layer 2 is active
const rgblight_segment_t PROGMEM my_layer2_layer[] = RGBLIGHT_LAYER_SEGMENTS(
    {1, 2, HSV_GREEN}
);
// Light LEDs 13 & 14 in green when keyboard layer 3 is active
const rgblight_segment_t PROGMEM my_layer3_layer[] = RGBLIGHT_LAYER_SEGMENTS(
    {1, 2, HSV_PURPLE}
);

#ifdef RGBLIGHT_LAYER_BLINK
// layer blink when auto shift state change
const rgblight_segment_t PROGMEM my_caps_word_layer[] = RGBLIGHT_LAYER_SEGMENTS(
    {1, 2, HSV_ORANGE}
);
void post_process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case QK_AUTO_SHIFT_TOGGLE:
            rgblight_blink_layer(4, 500);
            break;
    }
}
#endif

// Now define the array of layers. Later layers take precedence
const rgblight_segment_t* const PROGMEM my_rgb_layers[] = RGBLIGHT_LAYERS_LIST(
    my_capslock_layer,
    my_layer1_layer,    // Overrides caps lock layer
    my_layer2_layer,    // Overrides other layers
    my_layer3_layer     // Overrides other layers
    #ifdef RGBLIGHT_LAYER_BLINK
    ,my_caps_word_layer
    #endif
);

// called after firmware init
void keyboard_post_init_user(void) {
    // Enable the LED layers
    rgblight_layers = my_rgb_layers;
    // disable auto-shift
    autoshift_disable();
}

// called when led_state (num lock, caps lock, scroll lock, ...) is changed
bool led_update_user(led_t led_state) {
    rgblight_set_layer_state(0, led_state.caps_lock);
    return true;
}

// called when layer state change
layer_state_t layer_state_set_user(layer_state_t state) {
    rgblight_set_layer_state(1, layer_state_cmp(state, _LOWER));
    rgblight_set_layer_state(2, layer_state_cmp(state, _RAISE));
    rgblight_set_layer_state(3, layer_state_cmp(state, _ADJUST));
    return state;
}

#ifdef CAPS_WORD_ENABLE
// called when caps word state change
void caps_word_set_user(bool active) {
    rgblight_set_layer_state(0, active);
}
#endif

#endif
