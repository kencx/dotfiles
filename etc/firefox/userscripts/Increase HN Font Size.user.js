// ==UserScript==
// @name         Increase HN Font Size
// @namespace    https://greasyfork.org/zh-TW/users/79288
// @version      1.1
// @description  A user script to increase Hacker News's font size
// @author       jlhg
// @match        https://news.ycombinator.com/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    let titles = document.getElementsByClassName('title');
    [].forEach.call(titles, function(e) {
        e.style.fontSize = '16px';
    });

    let comments = document.getElementsByClassName('comment');
    [].forEach.call(comments, function(e) {
        e.style.fontSize = '14px';
        e.style.lineHeight = '1.5';
    });

    let comheads = document.getElementsByClassName('comhead');
    [].forEach.call(comheads, function(e) {
        e.style.fontSize = '14px';
        e.style.lineHeight = '1.5';
    });

    let subtexts = document.getElementsByClassName('subtext');
    [].forEach.call(subtexts, function(e) {
        e.style.fontSize = '14px';
        e.style.lineHeight = '1.5';
    });
})();
