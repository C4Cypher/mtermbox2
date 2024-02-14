%---------------------------------------------------------------------------%
% vim: ft=mercury ts=4 sw=4 et wm=0 tw=0
%-----------------------------------------------------------------------------%
% Copyright (C) 2024 C4Cypher.
% 
% MIT License
% 
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

/* Initializes the termbox library. This function should be called before any
 * other functions. tb_init() is equivalent to tb_init_file("/dev/tty"). After
 * successful initialization, the library must be finalized using the
 * tb_shutdown() function.
 */
 
 
	% int tb_init(void);
:- pred tb_init(io::di, io::uo) is det.

	% int tb_init_file(const char *path);
:- pred tb_init_file(string::in, io::di, io::uo) is det.

	% int tb_init_fd(int ttyfd);
:- pred tb_init_fd(int::in, io::di, io::uo) is det.

	% int tb_init_rwfd(int rfd, int wfd);
:- pred tb_init_rwfd(int::in, int::in, io::di, io::uo) is det.

	% int tb_shutdown(void);
:- pred tb_shutdown(io::di, io::uo) is det.

/* Returns the size of the internal back buffer (which is the same as terminal's
 * window size in rows and columns). The internal buffer can be resized after
 * tb_clear() or tb_present() function calls. Both dimensions have an
 * unspecified negative value when called before tb_init() or after
 * tb_shutdown().
 */
 
	% int tb_width(void);
:- pred tb_width(int::out, io::di, io::uo) is det.
:- func tb_width(io::di, io::uo) = int::out is det.

	% int tb_height(void);
:- pred tb_height(int::out, io::di, io::uo) is det.
:- func tb_height(io::di, io::uo) = int::out is det.

/* Clears the internal back buffer using TB_DEFAULT color or the
 * color/attributes set by tb_set_clear_attrs() function.
 */
 
 
	% int tb_clear(void);
:- pred tb_clear(io::di, io::uo) is det.

	% int tb_set_clear_attrs(uintattr_t fg, uintattr_t bg);
:- pred tb_set_clear_attrs(uint::in, uint::in, io::di, io::uo) is det.

:- implementation.

