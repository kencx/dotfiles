// ==UserScript==
// @name          Always Old Reddit
// @version       1.0
// @description   Redirect to Old Reddit
// @match         *://*.reddit.com/*
// @exclude-match *://*.reddit.com/poll/*
// @exclude-match *://old.reddit.com/*
// @exclude-match *://i.reddit.com/*
// @exclude-match *://*.reddit.com/media*
// @run-at        document-start
// @grant         none
// ==/UserScript==

window.location.replace("https://old.reddit.com" + window.location.pathname + window.location.search);