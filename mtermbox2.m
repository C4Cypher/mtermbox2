%---------------------------------------------------------------------------%
% vim: ft=mercury ts=4 sw=4 et wm=0 tw=0
%-----------------------------------------------------------------------------%
% 
% MIT License
% 
% Copyright (c) 2010-2020 nsf <no.smile.face@gmail.com>
%              2015-2024 Adam Saponara <as@php.net>
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
% 
%----------------------------------------------------------------------------%
%
% File:          termbox2.m
% Main author:   C4Cypher
% Maintained by: C4Cypher
% Stability:     Low
% 
% Direct binding to the termbox2 library. 
% I intend to implement a single module for this, following the 
% single header intent of the termbox2 library itself.
% 
% This mercury module is written as a direct binding, allowing one to adapt
% their own interface to handle interact with the termbox2 library header.
%
% The overwhelming majority of the comments are directly from the header.
%
% Note that almost all of the function calls return an int error value, which
% I've included as an int::out return value
%
% I've decided not to implement the features for TB_OPT_EGC
% This includes the extended declaration for tb_cell and the calls
% tb_set_cell_ex and tb_extend_cell
%
% Full credit for the termbox2 library belongs to nsf and Adam Saponara
%
%---------------------------------------------------------------------------%
%---------------------------------------------------------------------------%

:- module termbox2.
:- interface.

:- import_module io.
:- import_module char.
:- import_module string.
:- import_module bool.
:- import_module uint.
:- import_module uint16.
:- import_module uint32.

/* ASCII key constants (tb_event.key) */
:- func tb_key_ctrl_tilde = uint16 is det.
:- func tb_key_ctrl_2 = uint16 is det. /* clash with 'ctrl_tilde'     */
:- func tb_key_ctrl_a = uint16 is det.
:- func tb_key_ctrl_b = uint16 is det.
:- func tb_key_ctrl_c = uint16 is det.
:- func tb_key_ctrl_d = uint16 is det.
:- func tb_key_ctrl_e = uint16 is det.
:- func tb_key_ctrl_f = uint16 is det.
:- func tb_key_ctrl_g = uint16 is det.
:- func tb_key_backspace = uint16 is det.
:- func tb_key_ctrl_h = uint16 is det. /* clash with 'ctrl_backspace' */
:- func tb_key_tab = uint16 is det.
:- func tb_key_ctrl_i = uint16 is det. /* clash with 'tab'            */
:- func tb_key_ctrl_j = uint16 is det.
:- func tb_key_ctrl_k = uint16 is det.
:- func tb_key_ctrl_l = uint16 is det.
:- func tb_key_enter = uint16 is det.
:- func tb_key_ctrl_m = uint16 is det. /* clash with 'enter'          */
:- func tb_key_ctrl_n = uint16 is det.
:- func tb_key_ctrl_o = uint16 is det.
:- func tb_key_ctrl_p = uint16 is det.
:- func tb_key_ctrl_q = uint16 is det.
:- func tb_key_ctrl_r = uint16 is det.
:- func tb_key_ctrl_s = uint16 is det.
:- func tb_key_ctrl_t = uint16 is det.
:- func tb_key_ctrl_u = uint16 is det.
:- func tb_key_ctrl_v = uint16 is det.
:- func tb_key_ctrl_w = uint16 is det.
:- func tb_key_ctrl_x = uint16 is det.
:- func tb_key_ctrl_y = uint16 is det.
:- func tb_key_ctrl_z = uint16 is det.
:- func tb_key_esc = uint16 is det.
:- func tb_key_ctrl_lsq_bracket = uint16 is det. /* clash with 'esc'            */
:- func tb_key_ctrl_3 = uint16 is det. /* clash with 'esc'            */
:- func tb_key_ctrl_4 = uint16 is det.
:- func tb_key_ctrl_backslash = uint16 is det. /* clash with 'ctrl_4'         */
:- func tb_key_ctrl_5 = uint16 is det.
:- func tb_key_ctrl_rsq_bracket = uint16 is det. /* clash with 'ctrl_5'         */
:- func tb_key_ctrl_6 = uint16 is det.
:- func tb_key_ctrl_7 = uint16 is det.
:- func tb_key_ctrl_slash = uint16 is det. /* clash with 'ctrl_7'         */
:- func tb_key_ctrl_underscore = uint16 is det. /* clash with 'ctrl_7'         */
:- func tb_key_space = uint16 is det.
:- func tb_key_backspace2 = uint16 is det.
:- func tb_key_ctrl_8 = uint16 is det. /* clash with 'backspace2'     */

:- func tb_key_i(int) = uint16 is det.

/* terminal-dependent key constants (tb_event.key) and terminfo capabilities */

:- func tb_key_f1 = uint16 is det.
:- func tb_key_f2 = uint16 is det.
:- func tb_key_f3 = uint16 is det.
:- func tb_key_f4 = uint16 is det.
:- func tb_key_f5 = uint16 is det.
:- func tb_key_f6 = uint16 is det.
:- func tb_key_f7 = uint16 is det.
:- func tb_key_f8 = uint16 is det.
:- func tb_key_f9 = uint16 is det.
:- func tb_key_f10 = uint16 is det.
:- func tb_key_f11 = uint16 is det.
:- func tb_key_f12 = uint16 is det.
:- func tb_key_insert = uint16 is det.
:- func tb_key_delete = uint16 is det.
:- func tb_key_home = uint16 is det.
:- func tb_key_end = uint16 is det.
:- func tb_key_pgup = uint16 is det.
:- func tb_key_pgdn = uint16 is det.
:- func tb_key_arrow_up = uint16 is det.
:- func tb_key_arrow_down = uint16 is det.
:- func tb_key_arrow_left = uint16 is det.
:- func tb_key_arrow_right = uint16 is det.
:- func tb_key_back_tab = uint16 is det.
:- func tb_key_mouse_left = uint16 is det.
:- func tb_key_mouse_right = uint16 is det.
:- func tb_key_mouse_middle = uint16 is det.
:- func tb_key_mouse_release = uint16 is det.
:- func tb_key_mouse_wheel_up = uint16 is det.
:- func tb_key_mouse_wheel_down = uint16 is det.

:- func tb_cap_f1 = uint16 is det.
:- func tb_cap_f2 = uint16 is det.
:- func tb_cap_f3 = uint16 is det.
:- func tb_cap_f4 = uint16 is det.
:- func tb_cap_f5 = uint16 is det.
:- func tb_cap_f6 = uint16 is det.
:- func tb_cap_f7 = uint16 is det.
:- func tb_cap_f8 = uint16 is det.
:- func tb_cap_f9 = uint16 is det.
:- func tb_cap_f10 = uint16 is det.
:- func tb_cap_f11 = uint16 is det.
:- func tb_cap_f12 = uint16 is det.
:- func tb_cap_insert = uint16 is det.
:- func tb_cap_delete = uint16 is det.
:- func tb_cap_home = uint16 is det.
:- func tb_cap_end = uint16 is det.
:- func tb_cap_pgup = uint16 is det.
:- func tb_cap_pgdn = uint16 is det.
:- func tb_cap_arrow_up = uint16 is det.
:- func tb_cap_arrow_down = uint16 is det.
:- func tb_cap_arrow_left = uint16 is det.
:- func tb_cap_arrow_right = uint16 is det.
:- func tb_cap_back_tab = uint16 is det.
:- func tb_cap_count_keys = uint16 is det.
:- func tb_cap_enter_ca = uint16 is det.
:- func tb_cap_exit_ca = uint16 is det.
:- func tb_cap_show_cursor = uint16 is det.
:- func tb_cap_hide_cursor = uint16 is det.
:- func tb_cap_clear_screen = uint16 is det.
:- func tb_cap_sgr0 = uint16 is det.
:- func tb_cap_underline = uint16 is det.
:- func tb_cap_bold = uint16 is det.
:- func tb_cap_blink = uint16 is det.
:- func tb_cap_italic = uint16 is det.
:- func tb_cap_reverse = uint16 is det.
:- func tb_cap_enter_keypad = uint16 is det.
:- func tb_cap_exit_keypad = uint16 is det.
:- func tb_cap_dim = uint16 is det.
:- func tb_cap_invisible = uint16 is det.
:- func tb_cap_count = uint16 is det.

/* Some hard-coded caps */
:- func tb_hardcap_enter_mouse = string is det.
:- func tb_hardcap_exit_mouse = string is det.
:- func tb_hardcap_strikeout = string is det.
:- func tb_hardcap_underline_2 = string is det.
:- func tb_hardcap_overline = string is det.

/* Colors (numeric) and attributes (bitwise) (tb_cell.fg, tb_cell.bg) */
:- func tb_default = uintattr is det.
:- func tb_black = uintattr is det.
:- func tb_red = uintattr is det.
:- func tb_green = uintattr is det.
:- func tb_yellow = uintattr is det.
:- func tb_blue = uintattr is det.
:- func tb_magenta = uintattr is det.
:- func tb_cyan = uintattr is det.
:- func tb_white = uintattr is det.

:- func tb_bold = uintattr is det.
:- func tb_underline = uintattr is det.
:- func tb_reverse = uintattr is det.
:- func tb_italic = uintattr is det.
:- func tb_blink = uintattr is det.
:- func tb_hi_black = uintattr is det.
:- func tb_bright = uintattr is det.
:- func tb_dim = uintattr is det.

/* Event types (tb_event.type) */
:- func tb_event_key = uint8 is det.
:- func tb_event_resize = uint8 is det.
:- func tb_event_mouse = uint8 is det.

/* key modifiers (bitwise) (tb_event.mod) */
:- func tb_mod_alt = uint8 is det.
:- func tb_mod_ctrl = uint8 is det.
:- func tb_mod_shift = uint8 is det.
:- func tb_mod_motion = uint8 is det.

/* input modes (bitwise) (tb_set_input_mode) */
:- func tb_input_current = uint8 is det.
:- func tb_input_esc = uint8 is det.
:- func tb_input_alt = uint8 is det.
:- func tb_input_mouse = uint8 is det.

/* output modes (tb_set_output_mode) */
:- func tb_output_current = uint8 is det.
:- func tb_output_normal = uint8 is det.
:- func tb_output_256 = uint8 is det.
:- func tb_output_216 = uint8 is det.
:- func tb_output_grayscale = uint8 is det.
:- func tb_output_truecolor = uint8 is det.




/* Common function return values unless otherwise noted.
 *
 * Library behavior is undefined after receiving TB_ERR_MEM. Callers may
 * attempt reinitializing by freeing memory, invoking tb_shutdown, then
 * tb_init.
 */
:- func tb_ok = int is det.
:- func tb_err = int is det.
:- func tb_err_need_more = int is det.
:- func tb_err_init_already = int is det.
:- func tb_err_init_open = int is det.
:- func tb_err_mem = int is det.
:- func tb_err_no_event = int is det.
:- func tb_err_no_term = int is det.
:- func tb_err_not_init = int is det.
:- func tb_err_out_of_bounds = int is det.
:- func tb_err_read = int is det.
:- func tb_err_resize_ioctl = int is det.
:- func tb_err_resize_pipe = int is det.
:- func tb_err_resize_sigaction = int is det.
:- func tb_err_poll = int is det.
:- func tb_err_tcgetattr = int is det.
:- func tb_err_tcsetattr = int is det.
:- func tb_err_unsupported_term = int is det.
:- func tb_err_resize_write = int is det.
:- func tb_err_resize_poll = int is det.
:- func tb_err_resize_read = int is det.
:- func tb_err_resize_sscanf = int is det.
:- func tb_err_cap_collision = int is det.
:- func tb_err_select = int is det.
:- func tb_err_resize_select = int is det.

% By default this library calls termbox2.h with TB_OPT_ATTR_W = 32
% If you want to call this library with a different width, be sure to adjust
% the # define TB_OPT_ATTR_W in the declaration at the top of the 
% implementation of this module.
:- type uintattr == uint32.

/* The terminal screen is represented as 2d array of cells. The structure is
 * optimized for dealing with single-width (wcwidth()==1) Unicode codepoints,
 * however some support for grapheme clusters (e.g., combining diacritical
 * marks) and wide codepoints (e.g., Hiragana) is provided through ech, nech,
 * cech via tb_set_cell_ex(). ech is only valid when nech>0, otherwise ch is
 * used.
 *
 * For non-single-width codepoints, given N=wcwidth(ch)/wcswidth(ech):
 *
 *   when N==0: termbox forces a single-width cell. Callers should avoid this
 *              if aiming to render text accurately.
 *
 *    when N>1: termbox zeroes out the following N-1 cells and skips sending
 *              them to the tty. So, e.g., if the caller sets x=0,y=0 to an N==2
 *              codepoint, the caller's next set should be at x=2,y=0. Anything
 *              set at x=1,y=0 will be ignored. If there are not enough columns
 *              remaining on the line to render N width, spaces are sent
 *              instead.
 *
 * See tb_present() for implementation.
 */

:- type tb_cell.

:- func init_tb_cell = tb_cell is det.
:- func tb_cell(uint32, uintattr, uintattr) = tb_cell is det.

:- func ch(tb_cell) = uint32 is det.   /* a Unicode codepoint */
:- func fg(tb_cell) = uintattr is det. /* bitwise foreground attributes */
:- func bg(tb_cell) = uintattr is det. /* bitwise background attributes */

:- func 'ch :='(tb_cell, uint32) = tb_cell is det.
:- func 'fg :='(tb_cell, uintattr) = tb_cell is det.
:- func 'bg :='(tb_cell, uintattr) = tb_cell is det.

/* An incoming event from the tty.
 *
 * Given the event type, the following fields are relevant:
 *
 *      when TB_EVENT_KEY: (key XOR ch, one will be zero), mod. Note there is
 *                         overlap between TB_MOD_CTRL and TB_KEY_CTRL_*.
 *                         TB_MOD_CTRL and TB_MOD_SHIFT are only set as
 *                         modifiers to TB_KEY_ARROW_*.
 *
 *   when TB_EVENT_RESIZE: w, h
 *
 *    when TB_EVENT_MOUSE: key (TB_KEY_MOUSE_*), x, y
 */

:- type tb_event. 

:- pred init_tb_event(tb_event::out) is det.
:- func init_tb_event = tb_event is det.

:- func event_type(tb_event) = uint8 is det. /* one of TB_EVENT_* constants */
:- func event_mod(tb_event) = uint8 is det. /* bitwise TB_MOD_* constants */
:- func event_key(tb_event) = uint16 is det. /* one of TB_KEY_* constants */
:- func event_ch(tb_event) = uint32 is det. /* a Unicode codepoint */
:- func event_w(tb_event) = uint32 is det. /* resize width */
:- func event_h(tb_event) = uint32 is det. /* resize height */
:- func event_x(tb_event) = uint32 is det. /* mouse x */
:- func event_y(tb_event) = uint32 is det. /* mouse y */


/* Initializes the termbox library. This function should be called before any
 * other functions. tb_init() is equivalent to tb_init_file("/dev/tty"). After
 * successful initialization, the library must be finalized using the
 * tb_shutdown() function.
 */
 
 
	% int tb_init(void);
:- pred tb_init(int::out, io::di, io::uo) is det.

:- impure pred tb_init(int::out) is det.

	% int tb_init_file(const char *path);
:- pred tb_init_file(string::in, int::out, io::di, io::uo) is det.

:- impure pred tb_init_file(string::in, int::out) is det.

	% int tb_init_fd(int ttyfd);
:- pred tb_init_fd(int::in, int::out, io::di, io::uo) is det.

:- impure pred tb_init_fd(int::in, int::out) is det.

	% int tb_init_rwfd(int rfd, int wfd);
:- pred tb_init_rwfd(int::in, int::in, int::out, io::di, io::uo) is det.

:- impure pred tb_init_rwfd(int::in, int::in, int::out) is det.

	% int tb_shutdown(void);
:- pred tb_shutdown(int::out, io::di, io::uo) is det.

:- impure pred tb_shutdown(int::out) is det.

/* Returns the size of the internal back buffer (which is the same as terminal's
 * window size in rows and columns). The internal buffer can be resized after
 * tb_clear() or tb_present() function calls. Both dimensions have an
 * unspecified negative value when called before tb_init() or after
 * tb_shutdown().
 */
 
	% int tb_width(void);
:- pred tb_width(int::out, io::di, io::uo) is det.

:- semipure func tb_width = int is det.

	% int tb_height(void);
:- pred tb_height(int::out, io::di, io::uo) is det.

:- semipure func tb_height = int is det.

/* Clears the internal back buffer using TB_DEFAULT color or the
 * color/attributes set by tb_set_clear_attrs() function.
 */
 
 
	% int tb_clear(void);
:- pred tb_clear(int::out, io::di, io::uo) is det.

:- impure pred tb_clear(int::out) is det.


	% int tb_set_clear_attrs(uintattr_t fg, uintattr_t bg);
:- pred tb_set_clear_attrs(uintattr::in, uintattr::in,
	int::out, io::di, io::uo) is det.

:- impure pred tb_set_clear_attrs(uintattr::in, uintattr::in, int::out) is det.

/* Synchronizes the internal back buffer with the terminal by writing to tty. */

	% int tb_present(void);
 :- pred tb_present(int::out, io::di, io::uo) is det.
 
 :- impure pred tb_present(int::out) is det.
 
 /* Clears the internal front buffer effectively forcing a complete re-render of
 * the back buffer to the tty. It is not necessary to call this under normal
 * circumstances. */

	% int tb_invalidate(void);
:- pred tb_invalidate(int::out, io::di, io::uo) is det.

:- impure pred tb_invalidate(int::out) is det.

/* Sets the position of the cursor. Upper-left character is (0, 0). */

	% int tb_set_cursor(int cx, int cy);
:- pred tb_set_cursor(int::in, int::in, int::out, io::di, io::uo) is det.

:- impure pred tb_set_cursor(int::in, int::in, int::out) is det.
	
	%int tb_hide_cursor(void);
:- pred tb_hide_cursor(int::out, io::di, io::uo) is det.

:- impure pred tb_hide_cursor(int::out) is det.

/* Set cell contents in the internal back buffer at the specified position.
 *
 * Use tb_set_cell_ex() for rendering grapheme clusters (e.g., combining
 * diacritical marks). *NOT IMPLEMENTED FOR MERCURY*
 *
 * Function tb_set_cell(x, y, ch, fg, bg) is equivalent to
 * tb_set_cell_ex(x, y, &ch, 1, fg, bg).
 *
 * Function tb_extend_cell() is a shortcut for appending 1 codepoint to
 * cell->ech. *NOT IMPLEMENTED FOR MERCURY*
 */
 
	% int tb_set_cell(int x, int y, uint32_t ch, uintattr_t fg, uintattr_t bg);
:- pred tb_set_cell(int::in, int::in, uint32::in, uintattr::in, uintattr::in,
	int::out, io::di, io::uo) is det.
	
:- impure pred tb_set_cell(int::in, int::in, uint32::in, uintattr::in, 
	uintattr::in, int::out) is det.



/* Sets the input mode. Termbox has two input modes:
 *
 * 1. TB_INPUT_ESC
 *    When escape (\x1b) is in the buffer and there's no match for an escape
 *    sequence, a key event for TB_KEY_ESC is returned.
 *
 * 2. TB_INPUT_ALT
 *    When escape (\x1b) is in the buffer and there's no match for an escape
 *    sequence, the next keyboard event is returned with a TB_MOD_ALT modifier.
 *
 * You can also apply TB_INPUT_MOUSE via bitwise OR operation to either of the
 * modes (e.g., TB_INPUT_ESC | TB_INPUT_MOUSE) to receive TB_EVENT_MOUSE events.
 * If none of the main two modes were set, but the mouse mode was, TB_INPUT_ESC
 * mode is used. If for some reason you've decided to use
 * (TB_INPUT_ESC | TB_INPUT_ALT) combination, it will behave as if only
 * TB_INPUT_ESC was selected.
 *
 * If mode is TB_INPUT_CURRENT, the function returns the current input mode.
 *
 * The default input mode is TB_INPUT_ESC.
 */
 
	% int tb_set_input_mode(int mode);
:- pred tb_set_input_mode(int::in, int::out, io::di, io::uo) is det.

:- impure pred tb_set_input_mode(int::in, int::out) is det.

%% TODO: funcs for the builtin input modes

/* Sets the termbox output mode. Termbox has multiple output modes:
 *
 * 1. TB_OUTPUT_NORMAL     => [0..8]
 *
 *    This mode provides 8 different colors:
 *      TB_BLACK, TB_RED, TB_GREEN, TB_YELLOW,
 *      TB_BLUE, TB_MAGENTA, TB_CYAN, TB_WHITE
 *
 *    Plus TB_DEFAULT which skips sending a color code (i.e., uses the
 *    terminal's default color).
 *
 *    Colors (including TB_DEFAULT) may be bitwise OR'd with attributes:
 *      TB_BOLD, TB_UNDERLINE, TB_REVERSE, TB_ITALIC, TB_BLINK, TB_BRIGHT,
 *      TB_DIM
 *
 *    The following style attributes are also available if compiled with
 *    TB_OPT_ATTR_W set to 64:
 *      TB_STRIKEOUT, TB_UNDERLINE_2, TB_OVERLINE, TB_INVISIBLE
 *
 *    As in all modes, the value 0 is interpreted as TB_DEFAULT for
 *    convenience.
 *
 *    Some notes: TB_REVERSE can be applied as either fg or bg attributes for
 *    the same effect. TB_BRIGHT can be applied to either fg or bg. The rest of
 *    the attributes apply to fg only and are ignored as bg attributes.
 *
 *    Example usage:
 *      tb_set_cell(x, y, '@', TB_BLACK | TB_BOLD, TB_RED);
 *
 * 2. TB_OUTPUT_256        => [0..255] + TB_HI_BLACK
 *
 *    In this mode you get 256 distinct colors (plus default):
 *                0x00   (1): TB_DEFAULT
 *         TB_HI_BLACK   (1): TB_BLACK in TB_OUTPUT_NORMAL
 *          0x01..0x07   (7): the next 7 colors as in TB_OUTPUT_NORMAL
 *          0x08..0x0f   (8): bright versions of the above
 *          0x10..0xe7 (216): 216 different colors
 *          0xe8..0xff  (24): 24 different shades of gray
 *
 *    All TB_* style attributes except TB_BRIGHT may be bitwise OR'd as in
 *    TB_OUTPUT_NORMAL.
 *
 *    Note TB_HI_BLACK must be used for black, as 0x00 represents default.
 *
 * 3. TB_OUTPUT_216        => [0..216]
 *
 *    This mode supports the 216-color range of TB_OUTPUT_256 only, but you
 *    don't need to provide an offset:
 *                0x00   (1): TB_DEFAULT
 *          0x01..0xd8 (216): 216 different colors
 *
 * 4. TB_OUTPUT_GRAYSCALE  => [0..24]
 *
 *    This mode supports the 24-color range of TB_OUTPUT_256 only, but you
 *    don't need to provide an offset:
 *                0x00   (1): TB_DEFAULT
 *          0x01..0x18  (24): 24 different shades of gray
 *
 * 5. TB_OUTPUT_TRUECOLOR  => [0x000000..0xffffff] + TB_HI_BLACK
 *
 *    This mode provides 24-bit color on supported terminals. The format is
 *    0xRRGGBB.
 *
 *    All TB_* style attributes except TB_BRIGHT may be bitwise OR'd as in
 *    TB_OUTPUT_NORMAL.
 *
 *    Note TB_HI_BLACK must be used for black, as 0x000000 represents default.
 *
 * If mode is TB_OUTPUT_CURRENT, the function returns the current output mode.
 *
 * The default output mode is TB_OUTPUT_NORMAL.
 *
 * To use the terminal default color (i.e., to not send an escape code), pass
 * TB_DEFAULT. For convenience, the value 0 is interpreted as TB_DEFAULT in
 * all modes.
 *
 * Note, cell attributes persist after switching output modes. Any translation
 * between, for example, TB_OUTPUT_NORMAL's TB_RED and TB_OUTPUT_TRUECOLOR's
 * 0xff0000 must be performed by the caller. Also note that cells previously
 * rendered in one mode may persist unchanged until the front buffer is cleared
 * (such as after a resize event) at which point it will be re-interpreted and
 * flushed according to the current mode. Callers may invoke tb_invalidate if
 * it is desirable to immediately re-interpret and flush the entire screen
 * according to the current mode.
 *
 * Note, not all terminals support all output modes, especially beyond
 * TB_OUTPUT_NORMAL. There is also no very reliable way to determine color
 * support dynamically. If portability is desired, callers are recommended to
 * use TB_OUTPUT_NORMAL or make output mode end-user configurable. The same
 * advice applies to style attributes.
 */
 
	% int tb_set_output_mode(int mode);
:- pred tb_set_output_mode(int::in, int::out, io::di, io::uo) is det.

:- impure pred tb_set_output_mode(int::in, int::out) is det.






/* Wait for an event up to timeout_ms milliseconds and fill the event structure
 * with it. If no event is available within the timeout period, TB_ERR_NO_EVENT
 * is returned. On a resize event, the underlying select(2) call may be
 * interrupted, yielding a return code of TB_ERR_POLL. In this case, you may
 * check errno via tb_last_errno(). If it's EINTR, you can safely ignore that
 * and call tb_peek_event() again.
 */

	% int tb_peek_event(struct tb_event *event, int timeout_ms);
:- pred tb_peek_event(tb_event::in, int::in, int::out,
	io::di, io::uo)	is det.

:- impure pred tb_peek_event(tb_event::in, int::in, int::out) is det.

/* Same as tb_peek_event except no timeout. */
	
	% int tb_poll_event(struct tb_event *event);
:- pred tb_poll_event(tb_event::in, int::out, 
	io::di, io::uo) is det. 
	
:- impure pred tb_poll_event(tb_event::in, int::out) is det.
	
/* Internal termbox FDs that can be used with poll() / select(). Must call
 * tb_poll_event() / tb_peek_event() if activity is detected. */
	% int tb_get_fds(int *ttyfd, int *resizefd);	
	
% Not sure how to use this call, or if I want to implement it yet, backburner

/* Print and printf functions. Specify param out_w to determine width of printed
 * string. Incomplete trailing UTF-8 byte sequences are replaced with U+FFFD.
 * For finer control, use tb_set_cell().
 */

% int tb_print(int x, int y, uintattr_t fg, uintattr_t bg, const char *str);
:- pred tb_print(int::in, int::in, uintattr::in, uintattr::in, string::in, 
	int::out, io::di, io::uo) is det.
	
:- impure pred tb_print(int::in, int::in, uintattr::in, uintattr::in,
	string::in, int::out) is det.

% int tb_printf(int x, int y, uintattr_t fg, uintattr_t bg, const char *fmt, ...);
% Mercury does not support variadic function calls, and calls string.format on
% output before sending it to the output api calls

% int tb_print_ex(int x, int y, uintattr_t fg, uintattr_t bg, size_t *out_w,
%    const char *str);
:- pred tb_print_ex(int::in, int::in, uintattr::in, uintattr::in, uint::out,
	string::in, int::out, io::di, io::uo) is det.
	
:- impure pred tb_print_ex(int::in, int::in, uintattr::in, uintattr::in, 
	uint::out, string::in, int::out) is det.

%int tb_printf_ex(int x, int y, uintattr_t fg, uintattr_t bg, size_t *out_w,
%    const char *fmt, ...);
% As above, can't properly call printf from mercury

/* Send raw bytes to terminal. */

	% int tb_send(const char *buf, size_t nbuf);
:- pred tb_send(string::in, uint::in, int::out, io::di, io::uo) is det.

:- impure pred tb_send(string::in, uint::in, int::out) is det.

% int tb_sendf(const char *fmt, ...);
% Again, not implemented.

% TODO: adress whether or not I want to adress custom functions, it's possible
% I've done it with my Appolo Mercury-Lua bridge

/* Return byte length of codepoint given first byte of UTF-8 sequence (1-6). */
% int tb_utf8_char_length(char c);
:- func tb_utf8_char_length(char) = int is det. % Ignore error code

/* Convert UTF-8 null-terminated byte sequence to UTF-32 codepoint.
 *
 * If `c` is an empty C string, return 0. `out` is left unchanged.
 *
 * If a null byte is encountered in the middle of the codepoint, return a
 * negative number indicating how many bytes were processed. `out` is left
 * unchanged.
 *
 * Otherwise, return byte length of codepoint (1-6).
 */
% int tb_utf8_char_to_unicode(uint32_t *out, const char *c);
:- pred tb_utf8_char_to_unicode(uint32::out, string::in, int::out) is det.

/* Convert UTF-32 codepoint to UTF-8 null-terminated byte sequence.
 *
 * `out` must be char[7] or greater. Return byte length of codepoint (1-6).
 */
%int tb_utf8_unicode_to_char(char *out, uint32_t c);
:- pred tb_utf8_unicode_to_char(string::out, uint32::in, int::out) is det.
:- func tb_utf8_unicode_to_char(uint32) = string is det. % Discard byte length

/* Library utility functions */

% int tb_last_errno(void);
:- pred tb_last_errno(int::out, io::di, io::uo) is det.
:- semipure func tb_last_errno = int is det.

% const char *tb_strerror(int err);
:- func tb_strerror(int) = string is det.


% int tb_has_truecolor(void);
:- pred tb_has_truecolor(bool::out, io::di, io::uo) is det.

:- semipure pred tb_has_truecolor is semidet.

% int tb_has_egc(void);
:- pred tb_has_egc(bool::out, io::di, io::uo) is det.

:- semipure pred tb_has_egc is semidet.

% int tb_attr_width(void);
:- func tb_attr_width = int is det.

%const char *tb_version(void);
:- func tb_version = string is det.

:- implementation.

:- pragma require_feature_set([conservative_gc]).

:- pragma foreign_decl("C", "
	/* Ensure that the termbox2.h library plays nice with the Mercury GC */
	#define tb_malloc 	MR_GC_malloc
	#define tb_realloc	MR_GC_realloc
	#define tb_free 	MR_GC_free
	
	/* This libary assumes that uintattr_t is a 32 bit unsigned integer
		if you want to change this, be sure to change the declaration of the
		:- type uintatrr mercury type above accordingly. I haven't yet included
		support for the 64 bit graphics options. We'll see if I do so after
		I get this library working. */
	#define TB_OPT_ATTR_W 32
	
	/* Declarations that modify termbox compile time options need to be made
		before this point. */
	#include ""termbox2.h"" 
").

/* ASCII key constants (tb_event.key) */

:- pragma foreign_proc("C", tb_key_ctrl_tilde = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_TILDE;").
:- pragma inline(tb_key_ctrl_tilde/0).

:- pragma foreign_proc("C", tb_key_ctrl_2 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_2;").
:- pragma inline(tb_key_ctrl_2/0).

:- pragma foreign_proc("C", tb_key_ctrl_a = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_A;").
:- pragma inline(tb_key_ctrl_a/0).

:- pragma foreign_proc("C", tb_key_ctrl_b = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_B;").
:- pragma inline(tb_key_ctrl_b/0).

:- pragma foreign_proc("C", tb_key_ctrl_c = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_C;").
:- pragma inline(tb_key_ctrl_c/0).

:- pragma foreign_proc("C", tb_key_ctrl_d = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_D;").
:- pragma inline(tb_key_ctrl_d/0).

:- pragma foreign_proc("C", tb_key_ctrl_e = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_E;").
:- pragma inline(tb_key_ctrl_e/0).

:- pragma foreign_proc("C", tb_key_ctrl_f = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_F;").
:- pragma inline(tb_key_ctrl_f/0).

:- pragma foreign_proc("C", tb_key_ctrl_g = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_G;").
:- pragma inline(tb_key_ctrl_g/0).

:- pragma foreign_proc("C", tb_key_backspace = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_BACKSPACE;").
:- pragma inline(tb_key_backspace/0).

:- pragma foreign_proc("C", tb_key_ctrl_h = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_H;").
:- pragma inline(tb_key_ctrl_h/0).

:- pragma foreign_proc("C", tb_key_tab = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_TAB;").
:- pragma inline(tb_key_tab/0).

:- pragma foreign_proc("C", tb_key_ctrl_i = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_I;").
:- pragma inline(tb_key_ctrl_i/0).

:- pragma foreign_proc("C", tb_key_ctrl_j = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_J;").
:- pragma inline(tb_key_ctrl_j/0).

:- pragma foreign_proc("C", tb_key_ctrl_k = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_K;").
:- pragma inline(tb_key_ctrl_k/0).

:- pragma foreign_proc("C", tb_key_ctrl_l = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_L;").
:- pragma inline(tb_key_ctrl_l/0).

:- pragma foreign_proc("C", tb_key_enter = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_ENTER;").
:- pragma inline(tb_key_enter/0).

:- pragma foreign_proc("C", tb_key_ctrl_m = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_M;").
:- pragma inline(tb_key_ctrl_m/0).

:- pragma foreign_proc("C", tb_key_ctrl_n = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_N;").
:- pragma inline(tb_key_ctrl_n/0).

:- pragma foreign_proc("C", tb_key_ctrl_o = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_O;").
:- pragma inline(tb_key_ctrl_o/0).

:- pragma foreign_proc("C", tb_key_ctrl_p = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_P;").
:- pragma inline(tb_key_ctrl_p/0).

:- pragma foreign_proc("C", tb_key_ctrl_q = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_Q;").
:- pragma inline(tb_key_ctrl_q/0).

:- pragma foreign_proc("C", tb_key_ctrl_r = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_R;").
:- pragma inline(tb_key_ctrl_r/0).

:- pragma foreign_proc("C", tb_key_ctrl_s = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_S;").
:- pragma inline(tb_key_ctrl_s/0).

:- pragma foreign_proc("C", tb_key_ctrl_t = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_T;").
:- pragma inline(tb_key_ctrl_t/0).

:- pragma foreign_proc("C", tb_key_ctrl_u = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_U;").
:- pragma inline(tb_key_ctrl_u/0).

:- pragma foreign_proc("C", tb_key_ctrl_v = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_V;").
:- pragma inline(tb_key_ctrl_v/0).

:- pragma foreign_proc("C", tb_key_ctrl_w = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_W;").
:- pragma inline(tb_key_ctrl_w/0).

:- pragma foreign_proc("C", tb_key_ctrl_x = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_X;").
:- pragma inline(tb_key_ctrl_x/0).

:- pragma foreign_proc("C", tb_key_ctrl_y = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_Y;").
:- pragma inline(tb_key_ctrl_y/0).

:- pragma foreign_proc("C", tb_key_ctrl_z = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_Z;").
:- pragma inline(tb_key_ctrl_z/0).

:- pragma foreign_proc("C", tb_key_esc = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_ESC;").
:- pragma inline(tb_key_esc/0).

:- pragma foreign_proc("C", tb_key_ctrl_lsq_bracket = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_LSQ_BRACKET;").
:- pragma inline(tb_key_ctrl_lsq_bracket/0).

:- pragma foreign_proc("C", tb_key_ctrl_3 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_3;").
:- pragma inline(tb_key_ctrl_3/0).

:- pragma foreign_proc("C", tb_key_ctrl_4 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_4;").
:- pragma inline(tb_key_ctrl_4/0).

:- pragma foreign_proc("C", tb_key_ctrl_backslash = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_BACKSLASH;").
:- pragma inline(tb_key_ctrl_backslash/0).

:- pragma foreign_proc("C", tb_key_ctrl_5 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_5;").
:- pragma inline(tb_key_ctrl_5/0).

:- pragma foreign_proc("C", tb_key_ctrl_rsq_bracket = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_RSQ_BRACKET;").
:- pragma inline(tb_key_ctrl_rsq_bracket/0).

:- pragma foreign_proc("C", tb_key_ctrl_6 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_6;").
:- pragma inline(tb_key_ctrl_6/0).

:- pragma foreign_proc("C", tb_key_ctrl_7 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_7;").
:- pragma inline(tb_key_ctrl_7/0).

:- pragma foreign_proc("C", tb_key_ctrl_slash = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_SLASH;").
:- pragma inline(tb_key_ctrl_slash/0).

:- pragma foreign_proc("C", tb_key_ctrl_underscore = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_UNDERSCORE;").
:- pragma inline(tb_key_ctrl_underscore/0).

:- pragma foreign_proc("C", tb_key_space = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_SPACE;").
:- pragma inline(tb_key_space/0).

:- pragma foreign_proc("C", tb_key_backspace2 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_BACKSPACE2;").
:- pragma inline(tb_key_backspace2/0).

:- pragma foreign_proc("C", tb_key_ctrl_8 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_CTRL_8;").
:- pragma inline(tb_key_ctrl_8/0).

:- pragma foreign_proc("C", tb_key_i(I::in) = (R::out),
	[will_not_call_mercury, promise_pure], "R = tb_key_i(I);").
:- pragma inline(tb_key_i/1).


/* terminal-dependent key constants (tb_event.key) and terminfo capabilities */
:- pragma foreign_proc("C", tb_key_f1 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_F1;").
:- pragma inline(tb_key_f1/0).

:- pragma foreign_proc("C", tb_key_f2 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_F2;").
:- pragma inline(tb_key_f2/0).

:- pragma foreign_proc("C", tb_key_f3 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_F3;").
:- pragma inline(tb_key_f3/0).

:- pragma foreign_proc("C", tb_key_f4 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_F4;").
:- pragma inline(tb_key_f4/0).

:- pragma foreign_proc("C", tb_key_f5 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_F5;").
:- pragma inline(tb_key_f5/0).

:- pragma foreign_proc("C", tb_key_f6 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_F6;").
:- pragma inline(tb_key_f6/0).

:- pragma foreign_proc("C", tb_key_f7 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_F7;").
:- pragma inline(tb_key_f7/0).

:- pragma foreign_proc("C", tb_key_f8 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_F8;").
:- pragma inline(tb_key_f8/0).

:- pragma foreign_proc("C", tb_key_f9 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_F9;").
:- pragma inline(tb_key_f9/0).

:- pragma foreign_proc("C", tb_key_f10 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_F10;").
:- pragma inline(tb_key_f10/0).

:- pragma foreign_proc("C", tb_key_f11 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_F11;").
:- pragma inline(tb_key_f11/0).

:- pragma foreign_proc("C", tb_key_f12 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_F12;").
:- pragma inline(tb_key_f12/0).

:- pragma foreign_proc("C", tb_key_insert = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_INSERT;").
:- pragma inline(tb_key_insert/0).

:- pragma foreign_proc("C", tb_key_delete = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_DELETE;").
:- pragma inline(tb_key_delete/0).

:- pragma foreign_proc("C", tb_key_home = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_HOME;").
:- pragma inline(tb_key_home/0).

:- pragma foreign_proc("C", tb_key_end = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_END;").
:- pragma inline(tb_key_end/0).

:- pragma foreign_proc("C", tb_key_pgup = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_PGUP;").
:- pragma inline(tb_key_pgup/0).

:- pragma foreign_proc("C", tb_key_pgdn = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_PGDN;").
:- pragma inline(tb_key_pgdn/0).

:- pragma foreign_proc("C", tb_key_arrow_up = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_ARROW_UP;").
:- pragma inline(tb_key_arrow_up/0).

:- pragma foreign_proc("C", tb_key_arrow_down = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_ARROW_DOWN;").
:- pragma inline(tb_key_arrow_down/0).

:- pragma foreign_proc("C", tb_key_arrow_left = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_ARROW_LEFT;").
:- pragma inline(tb_key_arrow_left/0).

:- pragma foreign_proc("C", tb_key_arrow_right = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_ARROW_RIGHT;").
:- pragma inline(tb_key_arrow_right/0).

:- pragma foreign_proc("C", tb_key_back_tab = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_BACK_TAB;").
:- pragma inline(tb_key_back_tab/0).

:- pragma foreign_proc("C", tb_key_mouse_left = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_MOUSE_LEFT;").
:- pragma inline(tb_key_mouse_left/0).

:- pragma foreign_proc("C", tb_key_mouse_right = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_MOUSE_RIGHT;").
:- pragma inline(tb_key_mouse_right/0).

:- pragma foreign_proc("C", tb_key_mouse_middle = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_MOUSE_MIDDLE;").
:- pragma inline(tb_key_mouse_middle/0).

:- pragma foreign_proc("C", tb_key_mouse_release = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_MOUSE_RELEASE;").
:- pragma inline(tb_key_mouse_release/0).

:- pragma foreign_proc("C", tb_key_mouse_wheel_up = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_MOUSE_WHEEL_UP;").
:- pragma inline(tb_key_mouse_wheel_up/0).

:- pragma foreign_proc("C", tb_key_mouse_wheel_down = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_KEY_MOUSE_WHEEL_DOWN;").
:- pragma inline(tb_key_mouse_wheel_down/0).

:- pragma foreign_proc("C", tb_cap_f1 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_F1;").
:- pragma inline(tb_cap_f1/0).

:- pragma foreign_proc("C", tb_cap_f2 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_F2;").
:- pragma inline(tb_cap_f2/0).

:- pragma foreign_proc("C", tb_cap_f3 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_F3;").
:- pragma inline(tb_cap_f3/0).

:- pragma foreign_proc("C", tb_cap_f4 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_F4;").
:- pragma inline(tb_cap_f4/0).

:- pragma foreign_proc("C", tb_cap_f5 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_F5;").
:- pragma inline(tb_cap_f5/0).

:- pragma foreign_proc("C", tb_cap_f6 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_F6;").
:- pragma inline(tb_cap_f6/0).

:- pragma foreign_proc("C", tb_cap_f7 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_F7;").
:- pragma inline(tb_cap_f7/0).

:- pragma foreign_proc("C", tb_cap_f8 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_F8;").
:- pragma inline(tb_cap_f8/0).

:- pragma foreign_proc("C", tb_cap_f9 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_F9;").
:- pragma inline(tb_cap_f9/0).

:- pragma foreign_proc("C", tb_cap_f10 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_F10;").
:- pragma inline(tb_cap_f10/0).

:- pragma foreign_proc("C", tb_cap_f11 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_F11;").
:- pragma inline(tb_cap_f11/0).

:- pragma foreign_proc("C", tb_cap_f12 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_F12;").
:- pragma inline(tb_cap_f12/0).

:- pragma foreign_proc("C", tb_cap_insert = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_INSERT;").
:- pragma inline(tb_cap_insert/0).

:- pragma foreign_proc("C", tb_cap_delete = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_DELETE;").
:- pragma inline(tb_cap_delete/0).

:- pragma foreign_proc("C", tb_cap_home = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_HOME;").
:- pragma inline(tb_cap_home/0).

:- pragma foreign_proc("C", tb_cap_end = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_END;").
:- pragma inline(tb_cap_end/0).

:- pragma foreign_proc("C", tb_cap_pgup = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_PGUP;").
:- pragma inline(tb_cap_pgup/0).

:- pragma foreign_proc("C", tb_cap_pgdn = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_PGDN;").
:- pragma inline(tb_cap_pgdn/0).

:- pragma foreign_proc("C", tb_cap_arrow_up = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_ARROW_UP;").
:- pragma inline(tb_cap_arrow_up/0).

:- pragma foreign_proc("C", tb_cap_arrow_down = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_ARROW_DOWN;").
:- pragma inline(tb_cap_arrow_down/0).

:- pragma foreign_proc("C", tb_cap_arrow_left = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_ARROW_LEFT;").
:- pragma inline(tb_cap_arrow_left/0).

:- pragma foreign_proc("C", tb_cap_arrow_right = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_ARROW_RIGHT;").
:- pragma inline(tb_cap_arrow_right/0).

:- pragma foreign_proc("C", tb_cap_back_tab = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_BACK_TAB;").
:- pragma inline(tb_cap_back_tab/0).

:- pragma foreign_proc("C", tb_cap_count_keys = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP__COUNT_KEYS;").
:- pragma inline(tb_cap_count_keys/0).

:- pragma foreign_proc("C", tb_cap_enter_ca = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_ENTER_CA;").
:- pragma inline(tb_cap_enter_ca/0).

:- pragma foreign_proc("C", tb_cap_exit_ca = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_EXIT_CA;").
:- pragma inline(tb_cap_exit_ca/0).

:- pragma foreign_proc("C", tb_cap_show_cursor = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_SHOW_CURSOR;").
:- pragma inline(tb_cap_show_cursor/0).

:- pragma foreign_proc("C", tb_cap_hide_cursor = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_HIDE_CURSOR;").
:- pragma inline(tb_cap_hide_cursor/0).

:- pragma foreign_proc("C", tb_cap_clear_screen = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_CLEAR_SCREEN;").
:- pragma inline(tb_cap_clear_screen/0).

:- pragma foreign_proc("C", tb_cap_sgr0 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_SGR0;").
:- pragma inline(tb_cap_sgr0/0).

:- pragma foreign_proc("C", tb_cap_underline = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_UNDERLINE;").
:- pragma inline(tb_cap_underline/0).

:- pragma foreign_proc("C", tb_cap_bold = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_BOLD;").
:- pragma inline(tb_cap_bold/0).

:- pragma foreign_proc("C", tb_cap_blink = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_BLINK;").
:- pragma inline(tb_cap_blink/0).

:- pragma foreign_proc("C", tb_cap_italic = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_ITALIC;").
:- pragma inline(tb_cap_italic/0).

:- pragma foreign_proc("C", tb_cap_reverse = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_REVERSE;").
:- pragma inline(tb_cap_reverse/0).

:- pragma foreign_proc("C", tb_cap_enter_keypad = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_ENTER_KEYPAD;").
:- pragma inline(tb_cap_enter_keypad/0).

:- pragma foreign_proc("C", tb_cap_exit_keypad = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_EXIT_KEYPAD;").
:- pragma inline(tb_cap_exit_keypad/0).

:- pragma foreign_proc("C", tb_cap_dim = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_DIM;").
:- pragma inline(tb_cap_dim/0).

:- pragma foreign_proc("C", tb_cap_invisible = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP_INVISIBLE;").
:- pragma inline(tb_cap_invisible/0).

:- pragma foreign_proc("C", tb_cap_count = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CAP__COUNT;").
:- pragma inline(tb_cap_count/0).

/* Some hard-coded caps */
:- pragma foreign_proc("C", tb_hardcap_enter_mouse = (R::out),
	[will_not_call_mercury, promise_pure], 
	"R = (MR_String) TB_HARDCAP_ENTER_MOUSE;").
:- pragma inline(tb_hardcap_enter_mouse/0).

:- pragma foreign_proc("C", tb_hardcap_exit_mouse = (R::out),
	[will_not_call_mercury, promise_pure], 
	"R = (MR_String) TB_HARDCAP_EXIT_MOUSE;").
:- pragma inline(tb_hardcap_exit_mouse/0).

:- pragma foreign_proc("C", tb_hardcap_strikeout = (R::out),
	[will_not_call_mercury, promise_pure], 
	"R = (MR_String) TB_HARDCAP_STRIKEOUT;").
:- pragma inline(tb_hardcap_strikeout/0).

:- pragma foreign_proc("C", tb_hardcap_underline_2 = (R::out),
	[will_not_call_mercury, promise_pure], 
	"R = (MR_String) TB_HARDCAP_UNDERLINE_2;").
:- pragma inline(tb_hardcap_underline_2/0).

:- pragma foreign_proc("C", tb_hardcap_overline = (R::out),
	[will_not_call_mercury, promise_pure], 
	"R = (MR_String) TB_HARDCAP_OVERLINE;").
:- pragma inline(tb_hardcap_overline/0).

/* Colors (numeric) and attributes (bitwise) (tb_cell.fg, tb_cell.bg) */
:- pragma foreign_proc("C", tb_default = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_DEFAULT;").
:- pragma inline(tb_default/0).

:- pragma foreign_proc("C", tb_black = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_BLACK;").
:- pragma inline(tb_black/0).

:- pragma foreign_proc("C", tb_red = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_RED;").
:- pragma inline(tb_red/0).

:- pragma foreign_proc("C", tb_green = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_GREEN;").
:- pragma inline(tb_green/0).

:- pragma foreign_proc("C", tb_yellow = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_YELLOW;").
:- pragma inline(tb_yellow/0).

:- pragma foreign_proc("C", tb_blue = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_BLUE;").
:- pragma inline(tb_blue/0).

:- pragma foreign_proc("C", tb_magenta = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_MAGENTA;").
:- pragma inline(tb_magenta/0).

:- pragma foreign_proc("C", tb_cyan = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_CYAN;").
:- pragma inline(tb_cyan/0).

:- pragma foreign_proc("C", tb_white = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_WHITE;").
:- pragma inline(tb_white/0).

:- pragma foreign_proc("C", tb_bold = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_BOLD;").
:- pragma inline(tb_bold/0).

:- pragma foreign_proc("C", tb_underline = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_UNDERLINE;").
:- pragma inline(tb_underline/0).

:- pragma foreign_proc("C", tb_reverse = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_REVERSE;").
:- pragma inline(tb_reverse/0).

:- pragma foreign_proc("C", tb_italic = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ITALIC;").
:- pragma inline(tb_italic/0).

:- pragma foreign_proc("C", tb_blink = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_BLINK;").
:- pragma inline(tb_blink/0).

:- pragma foreign_proc("C", tb_hi_black = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_HI_BLACK;").
:- pragma inline(tb_hi_black/0).

:- pragma foreign_proc("C", tb_bright = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_BRIGHT;").
:- pragma inline(tb_bright/0).

:- pragma foreign_proc("C", tb_dim = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_DIM;").
:- pragma inline(tb_dim/0).

/* Event types (tb_event.type) */
:- pragma foreign_proc("C", tb_event_key = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_EVENT_KEY;").
:- pragma inline(tb_event_key/0).

:- pragma foreign_proc("C", tb_event_resize = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_EVENT_RESIZE;").
:- pragma inline(tb_event_resize/0).

:- pragma foreign_proc("C", tb_event_mouse = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_EVENT_MOUSE;").
:- pragma inline(tb_event_mouse/0).

/* key modifiers (bitwise) (tb_event.mod) */
:- pragma foreign_proc("C", tb_mod_alt = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_MOD_ALT;").
:- pragma inline(tb_mod_alt/0).

:- pragma foreign_proc("C", tb_mod_ctrl = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_MOD_CTRL;").
:- pragma inline(tb_mod_ctrl/0).

:- pragma foreign_proc("C", tb_mod_shift = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_MOD_SHIFT;").
:- pragma inline(tb_mod_shift/0).

:- pragma foreign_proc("C", tb_mod_motion = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_MOD_MOTION;").
:- pragma inline(tb_mod_motion/0).

/* input modes (bitwise) (tb_set_input_mode) */
:- pragma foreign_proc("C", tb_input_current = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_INPUT_CURRENT;").
:- pragma inline(tb_input_current/0).

:- pragma foreign_proc("C", tb_input_esc = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_INPUT_ESC;").
:- pragma inline(tb_input_esc/0).

:- pragma foreign_proc("C", tb_input_alt = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_INPUT_ALT;").
:- pragma inline(tb_input_alt/0).

:- pragma foreign_proc("C", tb_input_mouse = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_INPUT_MOUSE;").
:- pragma inline(tb_input_mouse/0).

/* output modes (tb_set_output_mode) */
:- pragma foreign_proc("C", tb_output_current = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_OUTPUT_CURRENT;").
:- pragma inline(tb_output_current/0).

:- pragma foreign_proc("C", tb_output_normal = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_OUTPUT_NORMAL;").
:- pragma inline(tb_output_normal/0).

:- pragma foreign_proc("C", tb_output_256 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_OUTPUT_256;").
:- pragma inline(tb_output_256/0).

:- pragma foreign_proc("C", tb_output_216 = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_OUTPUT_216;").
:- pragma inline(tb_output_216/0).

:- pragma foreign_proc("C", tb_output_grayscale = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_OUTPUT_GRAYSCALE;").
:- pragma inline(tb_output_grayscale/0).

:- pragma foreign_proc("C", tb_output_truecolor = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_OUTPUT_TRUECOLOR;").
:- pragma inline(tb_output_truecolor/0).

/* Common function return values unless otherwise noted.
 *
 * Library behavior is undefined after receiving TB_ERR_MEM. Callers may
 * attempt reinitializing by freeing memory, invoking tb_shutdown, then
 * tb_init.
 */
:- pragma foreign_proc("C", tb_ok = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_OK;").
:- pragma inline(tb_ok/0).

:- pragma foreign_proc("C", tb_err = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR;").
:- pragma inline(tb_err/0).

:- pragma foreign_proc("C", tb_err_need_more = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_NEED_MORE;").
:- pragma inline(tb_err_need_more/0).

:- pragma foreign_proc("C", tb_err_init_already = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_INIT_ALREADY;").
:- pragma inline(tb_err_init_already/0).

:- pragma foreign_proc("C", tb_err_init_open = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_INIT_OPEN;").
:- pragma inline(tb_err_init_open/0).

:- pragma foreign_proc("C", tb_err_mem = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_MEM;").
:- pragma inline(tb_err_mem/0).

:- pragma foreign_proc("C", tb_err_no_event = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_NO_EVENT;").
:- pragma inline(tb_err_no_event/0).

:- pragma foreign_proc("C", tb_err_no_term = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_NO_TERM;").
:- pragma inline(tb_err_no_term/0).

:- pragma foreign_proc("C", tb_err_not_init = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_NOT_INIT;").
:- pragma inline(tb_err_not_init/0).

:- pragma foreign_proc("C", tb_err_out_of_bounds = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_OUT_OF_BOUNDS;").
:- pragma inline(tb_err_out_of_bounds/0).

:- pragma foreign_proc("C", tb_err_read = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_READ;").
:- pragma inline(tb_err_read/0).

:- pragma foreign_proc("C", tb_err_resize_ioctl = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_RESIZE_IOCTL;").
:- pragma inline(tb_err_resize_ioctl/0).

:- pragma foreign_proc("C", tb_err_resize_pipe = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_RESIZE_PIPE;").
:- pragma inline(tb_err_resize_pipe/0).

:- pragma foreign_proc("C", tb_err_resize_sigaction = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_RESIZE_SIGACTION;").
:- pragma inline(tb_err_resize_sigaction/0).

:- pragma foreign_proc("C", tb_err_poll = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_POLL;").
:- pragma inline(tb_err_poll/0).

:- pragma foreign_proc("C", tb_err_tcgetattr = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_TCGETATTR;").
:- pragma inline(tb_err_tcgetattr/0).

:- pragma foreign_proc("C", tb_err_tcsetattr = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_TCSETATTR;").
:- pragma inline(tb_err_tcsetattr/0).

:- pragma foreign_proc("C", tb_err_unsupported_term = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_UNSUPPORTED_TERM;").
:- pragma inline(tb_err_unsupported_term/0).

:- pragma foreign_proc("C", tb_err_resize_write = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_RESIZE_WRITE;").
:- pragma inline(tb_err_resize_write/0).

:- pragma foreign_proc("C", tb_err_resize_poll = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_RESIZE_POLL;").
:- pragma inline(tb_err_resize_poll/0).

:- pragma foreign_proc("C", tb_err_resize_read = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_RESIZE_READ;").
:- pragma inline(tb_err_resize_read/0).

:- pragma foreign_proc("C", tb_err_resize_sscanf = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_RESIZE_SSCANF;").
:- pragma inline(tb_err_resize_sscanf/0).

:- pragma foreign_proc("C", tb_err_cap_collision = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_CAP_COLLISION;").
:- pragma inline(tb_err_cap_collision/0).

:- pragma foreign_proc("C", tb_err_select = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_SELECT;").
:- pragma inline(tb_err_select/0).

:- pragma foreign_proc("C", tb_err_resize_select = (R::out),
	[will_not_call_mercury, promise_pure], "R = TB_ERR_RESIZE_SELECT;").
:- pragma inline(tb_err_resize_select/0).



/* tb_cell */
:- pragma foreign_type("C", tb_cell, "struct tb_cell").

:- pragma foreign_code("C", "static const struct tb_cell new_tb_cell;").

:- pragma foreign_proc("C", init_tb_cell = (C::out),
	[will_not_call_mercury, promise_pure], "C = new_tb_cell;").
:- pragma inline(init_tb_cell/0).

:- pragma foreign_proc("C", tb_cell(Ch::in, Fg::in, Bg::in) = (Cell::out),
	[will_not_call_mercury, promise_pure], 
	"struct tb_cell new_cell = { Ch, Fg, Bg }; Cell = new_cell;").
:- pragma inline(tb_cell/3).

:- pragma foreign_proc("C", ch(Cell::in) = (Ch::out), [will_not_call_mercury,
	promise_pure], "Ch = Cell.ch;").
:- pragma inline(ch/1).

:- pragma foreign_proc("C", fg(Cell::in) = (Fg::out), [will_not_call_mercury,
	promise_pure], "Fg = Cell.fg;").
:- pragma inline(ch/1).

:- pragma foreign_proc("C", bg(Cell::in) = (Bg::out), [will_not_call_mercury,
	promise_pure], "Bg = Cell.bg;").
:- pragma inline(ch/1).

'ch :='(C0, Ch) = tb_cell(Ch, fg(C0), bg(C0)).
'fg :='(C0, Fg) = tb_cell(ch(C0), Fg, bg(C0)).
'bg :='(C0, Bg) = tb_cell(ch(C0), fg(C0), Bg).

/* tb_event */
:- pragma foreign_type("C", tb_event, "struct tb_event").

:- pragma foreign_code("C", "static const struct tb_event new_tb_event;").

:- pragma foreign_proc("C", init_tb_event = (C::out),
	[will_not_call_mercury, promise_pure], "C = new_tb_event;").
:- pragma inline(init_tb_event/0).

init_tb_event(init_tb_event).

:- pragma foreign_proc("C", event_type(Event::in) = (I::out), 
	[will_not_call_mercury, promise_pure], "I = Event.type;").
:- pragma inline(event_type/1).
	
:- pragma foreign_proc("C", event_mod(Event::in) = (I::out), 
	[will_not_call_mercury, promise_pure], "I = Event.mod;").
:- pragma inline(event_mod/1).
	
:- pragma foreign_proc("C", event_key(Event::in) = (I::out),
	[will_not_call_mercury, promise_pure], "I = Event.key;").
:- pragma inline(event_key/1).
	
:- pragma foreign_proc("C", event_ch(Event::in) = (I::out), 
	[will_not_call_mercury, promise_pure], "I = Event.ch;").
:- pragma inline(event_ch/1).

:- pragma foreign_proc("C", event_w(Event::in) = (I::out), 
	[will_not_call_mercury, promise_pure], "I = Event.w;").
:- pragma inline(event_w/1).
	
:- pragma foreign_proc("C", event_h(Event::in) = (I::out), 
	[will_not_call_mercury, promise_pure], "I = Event.h;").
:- pragma inline(event_h/1).
	
:- pragma foreign_proc("C", event_x(Event::in) = (I::out),
	[will_not_call_mercury, promise_pure], "I = Event.x;").
:- pragma inline(event_x/1).
	
:- pragma foreign_proc("C", event_y(Event::in) = (I::out), 
	[will_not_call_mercury, promise_pure],"I = Event.y;").
:- pragma inline(event_y/1).
	

:- pragma foreign_proc("C", tb_init(Err::out), [will_not_call_mercury],
	"Err = tb_init();").
:- pragma inline(tb_init/1).

tb_init(Err, !IO) :- impure tb_init(Err).
:- pragma promise_pure(tb_init/3).

:- pragma foreign_proc("C", tb_init_file(Path::in, Err::out), 
	[will_not_call_mercury], "Err = tb_init_file(Path);").
:- pragma inline(tb_init_file/2).

tb_init_file(Path, Err, !IO) :- impure tb_init_file(Path, Err).
:- pragma promise_pure(tb_init_file/4).

:- pragma foreign_proc("C", tb_init_fd(Ttyfd::in, Err::out), 
	[will_not_call_mercury], "Err = tb_init_fd(Ttyfd);").
:- pragma inline(tb_init_fd/2).

tb_init_fd(Ttyfd, Err, !IO) :- impure tb_init_fd(Ttyfd, Err).
:- pragma promise_pure(tb_init_fd/4).

:- pragma foreign_proc("C", tb_init_rwfd(Rfd::in, Wfd::in, Err::out), 
	[will_not_call_mercury], "Err = tb_init_rwfd(Rfd, Wfd);").
:- pragma inline(tb_init_rwfd/3).

tb_init_rwfd(Rfd, Wfd, Err, !IO) :- impure tb_init_rwfd(Rfd, Wfd, Err).
:- pragma promise_pure(tb_init_rwfd/5).

:- pragma foreign_proc("C", tb_shutdown(Err::out), [will_not_call_mercury],
	"Err = tb_shutdown();").
:- pragma inline(tb_shutdown/1).

tb_shutdown(Err, !IO) :- impure tb_shutdown(Err).
:- pragma promise_pure(tb_shutdown/3).

:- pragma foreign_proc("C", tb_width = (W::out), 
	[promise_semipure, will_not_call_mercury], "W = tb_width();").
:- pragma inline(tb_width/0).

tb_width(W, !IO) :- semipure W = tb_width.
:- pragma promise_pure(tb_width/3).

:- pragma foreign_proc("C", tb_height = (H::out), 
	[promise_semipure, will_not_call_mercury], "H = tb_height();").
:- pragma inline(tb_height/0).

tb_height(H, !IO) :- semipure H = tb_height.
:- pragma promise_pure(tb_height/3).

:- pragma foreign_proc("C", tb_clear(Err::out), [will_not_call_mercury],
	"Err = tb_clear();").
:- pragma inline(tb_clear/1).

tb_clear(Err, !IO) :- impure tb_clear(Err).
:- pragma promise_pure(tb_clear/3).

:- pragma foreign_proc("C", tb_set_clear_attrs(Fg::in, Bg::in, Err::out), 
	[will_not_call_mercury], "Err = tb_set_clear_attrs(Fg, Bg);").
:- pragma inline(tb_set_clear_attrs/3).

tb_set_clear_attrs(Fg, Bg, Err, !IO) :- impure tb_set_clear_attrs(Fg, Bg, Err).
:- pragma promise_pure(tb_set_clear_attrs/5).

:- pragma foreign_proc("C", tb_present(Err::out), [will_not_call_mercury],
	"Err = tb_present();").
:- pragma inline(tb_present/1).

tb_present(Err, !IO) :- impure tb_present(Err).
:- pragma promise_pure(tb_present/3).

:- pragma foreign_proc("C", tb_invalidate(Err::out), [will_not_call_mercury],
	"Err = tb_invalidate();").
:- pragma inline(tb_invalidate/1).

tb_invalidate(Err, !IO) :- impure tb_invalidate(Err).
:- pragma promise_pure(tb_invalidate/3).


:- pragma foreign_proc("C", tb_set_cursor(Cx::in, Cy::in, Err::out), 
	[will_not_call_mercury], "Err = tb_set_cursor(Cx, Cy);").
:- pragma inline(tb_set_cursor/3).

tb_set_cursor(Cx, Cy, Err, !IO) :- impure tb_set_cursor(Cx, Cy, Err).
:- pragma promise_pure(tb_set_cursor/5).

:- pragma foreign_proc("C", tb_hide_cursor(Err::out), [will_not_call_mercury],
	"Err = tb_hide_cursor();").
:- pragma inline(tb_hide_cursor/1).

tb_hide_cursor(Err, !IO) :- impure tb_hide_cursor(Err).
:- pragma promise_pure(tb_hide_cursor/3).

:- pragma foreign_proc("C", tb_set_cell(X::in, Y::in, Ch::in, Fg::in, Bg::in, 
	Err::out), [will_not_call_mercury], 
	"Err = tb_set_cell(X, Y, Ch, Fg, Bg);").
:- pragma inline(tb_set_cell/6).

tb_set_cell(X, Y, Ch, Fg, Bg, Err, !IO) 
	:- impure tb_set_cell(X, Y, Ch, Fg, Bg, Err).
:- pragma promise_pure(tb_set_cell/8).

:- pragma foreign_proc("C", tb_set_input_mode(Mode::in, Err::out), 
	[will_not_call_mercury], "Err = tb_set_input_mode(Mode);").
	
tb_set_input_mode(Mode, Err, !IO) :- impure tb_set_input_mode(Mode, Err).
:- pragma promise_pure(tb_set_input_mode/4).

:- pragma foreign_proc("C", tb_set_output_mode(Mode::in, Err::out), 
	[will_not_call_mercury], "Err = tb_set_output_mode(Mode);").
	
tb_set_output_mode(Mode, Err, !IO) 
	:- impure tb_set_output_mode(Mode, Err).
:- pragma promise_pure(tb_set_output_mode/4).

:- pragma foreign_proc("C", tb_peek_event(Event::in, Time::in, Err::out), 
	[will_not_call_mercury], "Err = tb_peek_event(&Event, Time);").
	
tb_peek_event(Event, Time, Err, !IO) 
	:- impure tb_peek_event(Event, Time, Err).
:- pragma promise_pure(tb_peek_event/5).

:- pragma foreign_proc("C", tb_poll_event(Event::in, Err::out), 
	[will_not_call_mercury], "Err = tb_poll_event(&Event);").
	
tb_poll_event(Event, Err, !IO) 
	:- impure tb_poll_event(Event, Err).
:- pragma promise_pure(tb_poll_event/4).

:- pragma foreign_proc("C", tb_print(X::in, Y::in, Fg::in, Bg::in, String::in,
	Err::out), [will_not_call_mercury], 
	"Err = tb_print(X, Y, Fg, Bg, String);").

tb_print(X, Y, Fg, Bg, String, Err, !IO) 
	:- impure tb_print(X, Y, Fg, Bg, String, Err).
:- pragma promise_pure(tb_print/8).

:- pragma foreign_proc("C", tb_print_ex(X::in, Y::in, Fg::in, Bg::in, 
	Out::out, String::in, Err::out), [will_not_call_mercury], 
	"Err = tb_print_ex(X, Y, Fg, Bg, &Out, String);").

tb_print_ex(X, Y, Fg, Bg, Out, String, Err, !IO) 
	:- impure tb_print_ex(X, Y, Fg, Bg, Out, String, Err).
:- pragma promise_pure(tb_print_ex/9).

:- pragma foreign_proc("C", tb_send(String::in, Nbuf::in, Err::out), 
	[will_not_call_mercury], "Err = tb_send(String, Nbuf);").

tb_send(String, Nbuf, Err, !IO) 
	:- impure tb_send(String, Nbuf, Err).
:- pragma promise_pure(tb_send/5).

:- pragma foreign_proc("C", tb_utf8_char_length(Char::in) = (Len::out),
	[will_not_call_mercury, promise_pure], "Len = tb_utf8_char_length(Char);").
	
:- pragma foreign_proc("C", tb_utf8_char_to_unicode(Out::out, String::in, 
	Len::out), [will_not_call_mercury, promise_pure], 
	"Len = tb_utf8_char_to_unicode(&Out, String);").
		
:- pragma foreign_proc("C", tb_utf8_unicode_to_char(Out::out, C::in, Len::out),
	[will_not_call_mercury, promise_pure], % Can I get away with passing Out?  
	"Len = tb_utf8_unicode_to_char(Out, C);").
	
tb_utf8_unicode_to_char(C) = Out :- tb_utf8_unicode_to_char(Out, C, _).
	
:- pragma foreign_proc("C", tb_last_errno = (Err::out), 
	[will_not_call_mercury,	promise_semipure], "Err = tb_last_errno();").
	
tb_last_errno(Err, !IO) :- semipure Err = tb_last_errno.
:- pragma promise_pure(tb_last_errno/3).

:- pragma foreign_proc("C", tb_strerror(Err::in) = (String::out),
	[will_not_call_mercury,	promise_pure], 
	"String = (MR_String) tb_strerror(Err);").
	
:- pragma foreign_proc("C", tb_has_truecolor, [will_not_call_mercury,
	promise_semipure], "SUCCESS_INDICATOR = tb_has_truecolor();").
	
tb_has_truecolor(Has, !IO) :-
	if semipure tb_has_truecolor then Has = yes else Has = no.
:- pragma promise_pure(tb_has_truecolor/3).

:- pragma foreign_proc("C", tb_has_egc, [will_not_call_mercury,
	promise_semipure], "SUCCESS_INDICATOR = tb_has_egc();").
	
tb_has_egc(Has, !IO) :-
	if semipure tb_has_egc then Has = yes else Has = no.
:- pragma promise_pure(tb_has_egc/3).


:- pragma foreign_proc("C", tb_attr_width = (Width::out),
	[will_not_call_mercury, promise_pure], "Width = tb_attr_width();").
:- pragma inline(tb_attr_width/0).

:- pragma foreign_proc("C", tb_version = (V::out),
	[will_not_call_mercury, promise_pure], "V = (MR_String) tb_version();").
:- pragma inline(tb_version/0).