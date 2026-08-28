# Compact left sidebar for kitty.

from os.path import basename, normpath

import kitty.tab_bar as kitty_tab_bar
from kitty.fast_data_types import get_options, wcswidth
from kitty.tab_bar import TabAccessor, as_rgb
from kitty.utils import color_as_int

# kitty 0.48 vertical tabs allocate 2 rows per tab even for one-line titles.
kitty_tab_bar.MAX_VERTICAL_TAB_LINES = 1

DIVIDER = "│"


def _directory_title(tab):
    accessor = TabAccessor(tab.tab_id)
    if accessor.active_exe == "tmux":
        return tab.title or "tmux"
    working_directory = accessor.active_wd
    return basename(normpath(working_directory)) if working_directory else "tab"


def _truncate(text, width):
    if width <= 0 or not text:
        return ""
    if wcswidth(text) <= width:
        return text
    ellipsis = "…"
    while text and wcswidth(text + ellipsis) > width:
        text = text[:-1]
    return (text + ellipsis) if text else ""


def _fill_line(screen, columns):
    row = screen.cursor.y
    bg = screen.cursor.bg
    fg = screen.cursor.fg
    screen.cursor.x = 0
    screen.draw(" " * columns)
    screen.cursor.x = 0
    screen.cursor.y = row
    screen.cursor.bg = bg
    screen.cursor.fg = fg


def _badge(tab):
    if tab.needs_attention:
        return "!"
    if tab.has_activity_since_last_focus:
        return "•"
    return ""


def _divider_fg(opts):
    try:
        return as_rgb(color_as_int(opts.inactive_tab_foreground))
    except Exception:
        return as_rgb(0x4A4A4A)


def _draw_divider(screen, fg, bg):
    x = screen.cursor.x
    y = screen.cursor.y
    old_fg = screen.cursor.fg
    old_bg = screen.cursor.bg
    old_bold = screen.cursor.bold
    screen.cursor.bold = False
    screen.cursor.italic = False
    screen.cursor.fg = fg
    screen.cursor.bg = bg
    col = max(0, screen.columns - 1)
    for row in range(screen.lines):
        screen.cursor.y = row
        screen.cursor.x = col
        screen.draw(DIVIDER)
    screen.cursor.x = x
    screen.cursor.y = y
    screen.cursor.fg = old_fg
    screen.cursor.bg = old_bg
    screen.cursor.bold = old_bold


def draw_tab(
    draw_data,
    screen,
    tab,
    before,
    max_tab_length,
    index,
    is_last,
    extra_data,
):
    del draw_data, before, max_tab_length, is_last, extra_data
    opts = get_options()
    columns = max(1, screen.columns)
    content_width = max(1, columns - 1)
    title_fg = screen.cursor.fg
    tab_bg = screen.cursor.bg
    divider_fg = _divider_fg(opts)
    index_text = f"{index} "
    badge = _badge(tab)
    badge_width = wcswidth(badge) + (1 if badge else 0)
    title = _truncate(
        _directory_title(tab),
        max(0, content_width - 2 - wcswidth(index_text) - badge_width),
    )
    title_line = index_text + title
    if badge:
        pad = max(1, content_width - 2 - wcswidth(title_line) - wcswidth(badge))
        title_line += (" " * pad) + badge

    screen.cursor.bg = tab_bg
    screen.cursor.fg = title_fg
    screen.cursor.bold = bool(tab.is_active)
    screen.cursor.italic = False
    _fill_line(screen, content_width)
    screen.draw(" ")
    screen.cursor.fg = title_fg
    screen.cursor.bold = bool(tab.is_active)
    screen.draw(title_line)
    _draw_divider(screen, divider_fg, tab_bg)
    return screen.cursor.x
