// ==UserScript==
// @name         Overleaf Editor Custom VIM Keybindings
// @namespace    http://tampermonkey.net/
// @version      0.1
// @match        https://www.overleaf.com/project/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    // poll until editor is loaded
    const retry = setInterval(() => {
        if (window._debug_editors === undefined) return
        clearInterval(retry)
        // get current editor instance
        const editor = window._debug_editors[window._debug_editors.length -1]
        // vim keyboard plugin
        const vimKeyboard = window.ace.require("ace/keyboard/vim")
        // add custom keybindings - insert mode applies on insert

        vimKeyboard.Vim.mapCommand('i', 'motion', 'moveByCharacters', { forward: true })
        vimKeyboard.Vim.mapCommand('n', 'motion', 'moveByDisplayLines', { forward: true })
        vimKeyboard.Vim.mapCommand('e', 'motion', 'moveByDisplayLines', { forward: false })

        vimKeyboard.Vim.mapCommand('k', 'motion', 'findNext', { forward: true, toJumplist: true })
        vimKeyboard.Vim.mapCommand('K', 'motion', 'findNext', { forward: false, toJumplist: true })

        vimKeyboard.Vim.mapCommand('s', 'action', 'enterInsertMode', { insertAt: 'inplace' })
        vimKeyboard.Vim.mapCommand('S', 'action', 'enterInsertMode', { insertAt: 'firstNonBlank' })

        vimKeyboard.Vim.mapCommand('j', 'motion', 'moveByWords', { forward: true, wordEnd: true, inclusive: true })
        vimKeyboard.Vim.mapCommand('J', 'motion', 'moveByWords', { forward: true, wordEnd: true, bigWord: true, inclusive: true })

        vimKeyboard.Vim.map('l', '^', 'normal')
        vimKeyboard.Vim.map("L", "$", "normal")

        vimKeyboard.Vim.map("<Left>", 'h')
        vimKeyboard.Vim.map("<Right>", 'i')
        vimKeyboard.Vim.map("<Down>", 'n')
        vimKeyboard.Vim.map("<Up>", 'e')

        //vimKeyboard.Vim.map("jk", "<ESC>", "normal")
        editor.setKeyboardHandler(vimKeyboard.handler)
        console.log("Custom key bindings applied")
    }, 100)
})();

