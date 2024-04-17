// ==UserScript==
// @name          Always Redlib
// @version       1.0
// @description   Redirect to Redlib
// @match         *://*.reddit.com/*
// @match         *://old.reddit.com/*
// @run-at        document-start
// @grant         none
// ==/UserScript==

window.location.replace("https://l.opnxng.com/" + window.location.pathname + window.location.search);