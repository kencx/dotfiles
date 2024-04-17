// ==UserScript==
// @name         Youtube Shorts Redirect
// @namespace    http://tampermonkey.net/
// @version      0.3
// @description  Youtuebe shorts > watch redirect
// @author       Fuim
// @match        *://*.youtube.com/*
// @icon         https://www.google.com/s2/favicons?domain=youtube.com
// @grant        none
// @run-at       document-start
// @license      GNU GPLv2
// @downloadURL https://update.greasyfork.org/scripts/439993/Youtube%20shorts%20redirect.user.js
// @updateURL https://update.greasyfork.org/scripts/439993/Youtube%20shorts%20redirect.meta.js
// ==/UserScript==
let oldHref = document.location.href;
if (window.location.href.indexOf('youtube.com/shorts') > -1) {
    window.location.replace(window.location.toString().replace('/shorts/', '/watch?v='));
}
window.onload = function() {
    let bodyList = document.querySelector("body");
    let observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (oldHref !== document.location.href) {
                oldHref = document.location.href;
                if (window.location.href.indexOf('youtube.com/shorts') > -1) {
                    window.location.replace(window.location.toString().replace('/shorts/', '/watch?v='));
                }
            }
        });
    });
    let config = {
        childList: true,
        subtree: true
    };
    observer.observe(bodyList, config);
};