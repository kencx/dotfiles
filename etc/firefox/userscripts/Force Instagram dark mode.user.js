// ==UserScript==
// @name        Force Instagram dark mode
// @description Forces instagram dark mode on desktop
// @match       https://www.instagram.com/*
// @author      suki
// @version     1.0
// @license     MIT
// @grant       none
// @run-at      document-start
// ==/UserScript==


const urlParams = new URLSearchParams(window.location.search);
const url = window.location.search;

if(!url.includes("theme=dark")) {
  urlParams.set('theme', 'dark');
  window.location.search = urlParams;
}