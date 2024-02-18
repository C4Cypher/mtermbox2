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
% File:          mtermbox2.m
% Main author:   C4Cypher
% Maintained by: C4Cypher
% Stability:     Low
% 
% TODO Write a short summary for here and the Github readme
% Direct binding to the termbox2 library, plus whatever utilities I decide
% to include. I intend to implement a single module for this, following the 
% single header intent of the termbox2 library itself.
%
% I'll try to keep things documented, either with my intent, or with comments
% from the original header. 
%
%---------------------------------------------------------------------------%
%
% Naming conventions:
%
% Direct one to one calls will have the tb prefix wheras my addditions will
% use the mtb prefix
%
%---------------------------------------------------------------------------%
%---------------------------------------------------------------------------%

:- module mtermbox2.
:- interface.

:- import_module io.
:- import_module string.
:- import_module bool.
:- import_module uint.
:- import_module uint16.
:- import_module uint32.

/* ASCII key constants (tb_event.key) */
:- func tb_key_ctrl_tilde = uint16.
:- func tb_key_ctrl_2 = uint16. /* clash with 'ctrl_tilde'     */
:- func tb_key_ctrl_a = uint16.
:- func tb_key_ctrl_b = uint16.
:- func tb_key_ctrl_c = uint16.
:- func tb_key_ctrl_d = uint16.
:- func tb_key_ctrl_e = uint16.
:- func tb_key_ctrl_f = uint16.
:- func tb_key_ctrl_g = uint16.
:- func tb_key_backspace = uint16.
:- func tb_key_ctrl_h = uint16. /* clash with 'ctrl_backspace' */
:- func tb_key_tab = uint16.
:- func tb_key_ctrl_i = uint16. /* clash with 'tab'            */
:- func tb_key_ctrl_j = uint16.
:- func tb_key_ctrl_k = uint16.
:- func tb_key_ctrl_l = uint16.
:- func tb_key_enter = uint16.
:- func tb_key_ctrl_m = uint16. /* clash with 'enter'          */
:- func tb_key_ctrl_n = uint16.
:- func tb_key_ctrl_o = uint16.
:- func tb_key_ctrl_p = uint16.
:- func tb_key_ctrl_q = uint16.
:- func tb_key_ctrl_r = uint16.
:- func tb_key_ctrl_s = uint16.
:- func tb_key_ctrl_t = uint16.
:- func tb_key_ctrl_u = uint16.
:- func tb_key_ctrl_v = uint16.
:- func tb_key_ctrl_w = uint16.
:- func tb_key_ctrl_x = uint16.
:- func tb_key_ctrl_y = uint16.
:- func tb_key_ctrl_z = uint16.
:- func tb_key_esc = uint16.
:- func tb_key_ctrl_lsq_bracket = uint16. /* clash with 'esc'            */
:- func tb_key_ctrl_3 = uint16. /* clash with 'esc'            */
:- func tb_key_ctrl_4 = uint16.
:- func tb_key_ctrl_backslash = uint16. /* clash with 'ctrl_4'         */
:- func tb_key_ctrl_5 = uint16.
:- func tb_key_ctrl_rsq_bracket = uint16. /* clash with 'ctrl_5'         */
:- func tb_key_ctrl_6 = uint16.
:- func tb_key_ctrl_7 = uint16.
:- func tb_key_ctrl_slash = uint16. /* clash with 'ctrl_7'         */
:- func tb_key_ctrl_underscore = uint16. /* clash with 'ctrl_7'         */
:- func tb_key_space = uint16.
:- func tb_key_backspace2 = uint16.
:- func tb_key_ctrl_8 = uint16. /* clash with 'backspace2'     */

:- func tb_key_i(int) = uint16.
/* terminal-dependent key constants (tb_event.key) and terminfo capabilities */

:- func tb_key_f1 = uint16.
:- func tb_key_f2 = uint16.
:- func tb_key_f3 = uint16.
:- func tb_key_f4 = uint16.
:- func tb_key_f5 = uint16.
:- func tb_key_f6 = uint16.
:- func tb_key_f7 = uint16.
:- func tb_key_f8 = uint16.
:- func tb_key_f9 = uint16.
:- func tb_key_f10 = uint16.
:- func tb_key_f11 = uint16.
:- func tb_key_f12 = uint16.
:- func tb_key_insert = uint16.
:- func tb_key_delete = uint16.
:- func tb_key_home = uint16.
:- func tb_key_end = uint16.
:- func tb_key_pgup = uint16.
:- func tb_key_pgdn = uint16.
:- func tb_key_arrow_up = uint16.
:- func tb_key_arrow_down = uint16.
:- func tb_key_arrow_left = uint16.
:- func tb_key_arrow_right = uint16.
:- func tb_key_back_tab = uint16.
:- func tb_key_mouse_left = uint16.
:- func tb_key_mouse_right = uint16.
:- func tb_key_mouse_middle = uint16.
:- func tb_key_mouse_release = uint16.
:- func tb_key_mouse_wheel_up = uint16.
:- func tb_key_mouse_wheel_down = uint16.

:- func tb_cap_f1 = uint16.
:- func tb_cap_f2 = uint16.
:- func tb_cap_f3 = uint16.
:- func tb_cap_f4 = uint16.
:- func tb_cap_f5 = uint16.
:- func tb_cap_f6 = uint16.
:- func tb_cap_f7 = uint16.
:- func tb_cap_f8 = uint16.
:- func tb_cap_f9 = uint16.
:- func tb_cap_f10 = uint16.
:- func tb_cap_f11 = uint16.
:- func tb_cap_f12 = uint16.
:- func tb_cap_insert = uint16.
:- func tb_cap_delete = uint16.
:- func tb_cap_home = uint16.
:- func tb_cap_end = uint16.
:- func tb_cap_pgup = uint16.
:- func tb_cap_pgdn = uint16.
:- func tb_cap_arrow_up = uint16.
:- func tb_cap_arrow_down = uint16.
:- func tb_cap_arrow_left = uint16.
:- func tb_cap_arrow_right = uint16.
:- func tb_cap_back_tab = uint16.
:- func tb_cap__count_keys = uint16.
:- func tb_cap_enter_ca = uint16.
:- func tb_cap_exit_ca = uint16.
:- func tb_cap_show_cursor = uint16.
:- func tb_cap_hide_cursor = uint16.
:- func tb_cap_clear_screen = uint16.
:- func tb_cap_sgr0 = uint16.
:- func tb_cap_underline = uint16.
:- func tb_cap_bold = uint16.
:- func tb_cap_blink = uint16.
:- func tb_cap_italic = uint16.
:- func tb_cap_reverse = uint16.
:- func tb_cap_enter_keypad = uint16.
:- func tb_cap_exit_keypad = uint16.
:- func tb_cap_dim = uint16.
:- func tb_cap_invisible = uint16.
:- func tb_cap__count = uint16.

/* Some hard-coded caps */
:- func tb_hardcap_enter_mouse = string.
:- func tb_hardcap_exit_mouse = string.
:- func tb_hardcap_strikeout = string.
:- func tb_hardcap_underline_2 = string.
:- func tb_hardcap_overline = string.

/* Colors (numeric) and attributes (bitwise) (tb_cell.fg, tb_cell.bg) */
:- func tb_default = uintattr.
:- func tb_black = uintattr.
:- func tb_red = uintattr.
:- func tb_green = uintattr.
:- func tb_yellow = uintattr.
:- func tb_blue = uintattr.
:- func tb_magenta = uintattr.
:- func tb_cyan = uintattr.
:- func tb_white = uintattr.

:- func tb_bold = uintattr.
:- func tb_underline = uintattr.
:- func tb_reverse = uintattr.
:- func tb_italic = uintattr.
:- func tb_blink = uintattr.
:- func tb_hi_black = uintattr.
:- func tb_bright = uintattr.
:- func tb_dim = uintattr.

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
:- func init_tb_event = tb_event.

:- func type(tb_event) = uint8. /* one of TB_EVENT_* constants */
:- func mod(tb_event) = uint8. /* bitwise TB_MOD_* constants */
:- func key(tb_event) = uint16. /* one of TB_KEY_* constants */
:- func ch(tb_event) = uint32. /* a Unicode codepoint */
:- func w(tb_event) = uint32. /* resize width */
:- func h(tb_event) = uint32. /* resize height */
:- func x(tb_event) = uint32. /* mouse x */
:- func y(tb_event) = uint32. /* mouse y */

/* Initializes the termbox library. This function should be called before any
 * other functions. tb_init() is equivalent to tb_init_file("/dev/tty"). After
 * successful initialization, the library must be finalized using the
 * tb_shutdown() function.
 */
 
 
	% int tb_init(void);
:- pred tb_init(io::di, io::uo) is det.

:- impure pred tb_init is det.

	% int tb_init_file(const char *path);
:- pred tb_init_file(string::in, io::di, io::uo) is det.

:- impure pred tb_init(string::in) is det.

	% int tb_init_fd(int ttyfd);
:- pred tb_init_fd(int::in, io::di, io::uo) is det.

:- impure pred tb_init_fd(int::in) is det.

	% int tb_init_rwfd(int rfd, int wfd);
:- pred tb_init_rwfd(int::in, int::in, io::di, io::uo) is det.

:- impure pred tb_init_rwfd(int::in, int::in) is det.

	% int tb_shutdown(void);
:- pred tb_shutdown(io::di, io::uo) is det.

:- impure pred tb_shutdown is det.

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
:- pred tb_clear(io::di, io::uo) is det.

:- impure pred tb_clear is det.

:- type uintattr == uint32.

	% int tb_set_clear_attrs(uintattr_t fg, uintattr_t bg);
:- pred tb_set_clear_attrs(uintattr::in, uintattr::in, io::di, io::uo) is det.

:- impure pred tb_set_clear_attrs(uintattr::in, uintattr::in) is det.

/* Synchronizes the internal back buffer with the terminal by writing to tty. */

	% int tb_present(void);
 :- pred tb_present(io::di, io::uo) is det.
 
 :- impure pred tb_present is det.
 
 /* Clears the internal front buffer effectively forcing a complete re-render of
 * the back buffer to the tty. It is not necessary to call this under normal
 * circumstances. */

	% int tb_invalidate(void);
:- pred tb_invalidate(io::di, io::uo) is det.

:- impure pred tb_invalidate is det.

/* Sets the position of the cursor. Upper-left character is (0, 0). */

	% int tb_set_cursor(int cx, int cy);
:- pred tb_set_cursor(int::in, int::in, io::di, io::uo) is det.

:- impure tb_set_cursor(int::in, int::in) is det.
	
	%int tb_hide_cursor(void);
:- pred tb_hide_cursor(io::di, io::uo) is det.

:- impure pred tb_hide_cursor is det.

/* Set cell contents in the internal back buffer at the specified position.
 *
 * Use tb_set_cell_ex() for rendering grapheme clusters (e.g., combining
 * diacritical marks).
 *
 * Function tb_set_cell(x, y, ch, fg, bg) is equivalent to
 * tb_set_cell_ex(x, y, &ch, 1, fg, bg).
 *
 * Function tb_extend_cell() is a shortcut for appending 1 codepoint to
 * cell->ech.
 */
 
	% int tb_set_cell(int x, int y, uint32_t ch, uintattr_t fg, uintattr_t bg);
:- pred tb_set_cell(int::in, int::in, uint32::in, uintattr::in, uintattr::in,
	io::di, io::uo) is det.
	
:- impure pred tb_set_cell(int::in, int::in, uint32::in, uintattr::in, 
	uintattr::in) is det.

	% int tb_set_cell_ex(int x, int y, uint32_t *ch, size_t nch, uintattr_t fg,
    % uintattr_t bg);
/*:- pred tb_set_cell_ex(int::in, int::in, XXX::in, uint::in, uint::in,
	uint::in, io::di, io::uo) is det.
	
:- impure pred tb_set_cell_ex(int::in, int::in, XXX::in, uint::in, uint::in,
	uint::in) is det.*/ 
	
% Haven't decided if I'm going to bother with tb_set_cell_ex until I'm ready to
% tackle natively passing array pointers back and forth to and from Mercury



	% int tb_extend_cell(int x, int y, uint32_t ch);
:- pred tb_extend_cell(int::in, int::in, uint32::in, io::di, io::uo) is det.

:- impure pred tb_extend_cell(int::in, int::in, uint32::in) is det.

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
:- pred tb_set_input_mode(int::in, io::di, io::uo) is det.

:- impure pred tb_set_input_mode(int::in) is det.

	% get the current input mode
:- pred mtb_get_input_mode(int::out, io::di, io::uo) is det.

:- semipure pred mtb_get_input_mode(int::out) is det.

:- semipure func mtb_get_input_mode = int is det.

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
:- pred tb_set_output_mode(int::in, io::di, io::uo) is det.

:- impure pred tb_set_output_mode(int::in) is det.


%% TODO: funcs for builtin output modes




/* Wait for an event up to timeout_ms milliseconds and fill the event structure
 * with it. If no event is available within the timeout period, TB_ERR_NO_EVENT
 * is returned. On a resize event, the underlying select(2) call may be
 * interrupted, yielding a return code of TB_ERR_POLL. In this case, you may
 * check errno via tb_last_errno(). If it's EINTR, you can safely ignore that
 * and call tb_peek_event() again.
 */

	% int tb_peek_event(struct tb_event *event, int timeout_ms);
:- pred tb_peek_event(tb_event::in, tb_event::out, int::in, int::out,
	io::di, io::uo)	is det.

:- impure pred tb_peek_event(tb_event::in, int::in, int::out) is det.
:- impure func tb_peek_event(tb_event, int) = int.

/* Same as tb_peek_event except no timeout. */
	
	% int tb_poll_event(struct tb_event *event);
:- pred tb_poll_event(tb_event::in, tb_event::out, int::out, 
	io::di, io::uo) is det. 
	
:- impure pred tb_poll_event(tb_event::in, int::out) is det.
:- impure func tb_poll_event(tb_event) = int.
	
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
	io::di, io::uo) is det.
	
:- impure pred tb_print(int::in, int::in, uintattr::in, uintattr::in,
	string::in) is det.

% int tb_printf(int x, int y, uintattr_t fg, uintattr_t bg, const char *fmt, ...);
% Mercury does not support variadic function calls, and calls string.format on
% output before sending it to the output api calls

% int tb_print_ex(int x, int y, uintattr_t fg, uintattr_t bg, size_t *out_w,
%    const char *str);
:- pred tb_print_ex(int::in, int::in, uintattr::in, uintattr::in, uint::in,
	string::in, io::di, io::uo) is det.
	
:- impure pred tb_print_ex(int::in, int::in, uintattr::in, uintattr::in, 
	uint::in, string::in) is det.

%int tb_printf_ex(int x, int y, uintattr_t fg, uintattr_t bg, size_t *out_w,
%    const char *fmt, ...);
% As above, can't properly call printf from mercury

/* Send raw bytes to terminal. */

	% int tb_send(const char *buf, size_t nbuf);
:- pred tb_send(string::in, uint::in, io::di, io::uo) is det.

:- impure pred tb_send(string::in, uint::in) is det.

% int tb_sendf(const char *fmt, ...);
% Again, not implemented.

% TODO: adress whether or not I want to adress custom functions, it's possible
% I've done it with my Appolo Mercury-Lua bridge

/* Return byte length of codepoint given first byte of UTF-8 sequence (1-6). */
% int tb_utf8_char_length(char c);
:- pred tb_utf8_char_length(char::in, int::out) is det.
:- func tb_utf8_char_length(char) = int.

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
:- func tb_utf8_unicode_to_char(uint32) = string. % Discard byte length

/* Library utility functions */

% int tb_last_errno(void);
:- pred tb_last_errno(int::out, io::di, io::uo) is det.
:- semipure func tb_last_errno = int.

% const char *tb_strerror(int err);
:- func tb_strerror(int) = string.

% struct tb_cell *tb_cell_buffer(void);
%TODO: the tb_cell foreign type

% int tb_has_truecolor(void);
:- pred tb_has_truecolor(bool::out, io::di, io::uo) is det.

:- semipure pred tb_has_truecolor is semidet.

% int tb_has_egc(void);
:- pred tb_has_egc(bool::out, io::di, io::uo) is det.

:- semipure pred tb_has_egc is semidet.

% int tb_attr_width(void);
:- func tb_attr_width = int.

%const char *tb_version(void);
:- func tb_version = string.

:- implementation.

