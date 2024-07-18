/* Copyright 2020 tominabox1
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include "./json-keymap.c"

// called after firmware init
void keyboard_post_init_user(void) {
    // disable auto-shift
    autoshift_disable();
    // rgb_matrix_mode_noeeprom(RGB_MATRIX_REACTIVE_MULTIWIDE);
}

void rgb_matrix_set_hsv_range(uint8_t start, uint8_t nb, uint8_t hue, uint8_t sat, uint8_t val) {
    if (val > rgb_matrix_get_val()) {
        val = rgb_matrix_get_val();
    }
    HSV hsv = {hue, sat, val};
    RGB rgb = hsv_to_rgb(hsv);
    while (nb) {
        rgb_matrix_set_color(start, rgb.r, rgb.g, rgb.b);
        start++;
        nb--;
    }
}

void set_indicator(uint8_t hue, uint8_t sat, uint8_t val) {
    rgb_matrix_set_color_all(RGB_OFF); // rest of keys
    rgb_matrix_set_hsv_range(28, 4, hue, sat, val);
    rgb_matrix_set_hsv_range(40, 3, hue, sat, val);
}

// called for each animation frame before being flushed to the LED.
// Return: true: continue running current animation
//         false: stop current animation (user should set LED colors)
bool rgb_matrix_indicators_user(void) {
    if (is_caps_word_on()) {
        set_indicator(HSV_RED);
        return false;
    }
    uint8_t layer = biton32(layer_state);
    switch (layer) {
        case 0:
            return true;
            break;
        case 1:
            set_indicator(HSV_BLUE);
            break;
        case 2:
            set_indicator(HSV_GREEN);
            break;
        case 3:
            set_indicator(HSV_PURPLE);
            break;
    }
    return false;
}
