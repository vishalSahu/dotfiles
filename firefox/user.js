// Mozilla User Preferences
//
// File should go under `profile` directory
// format: user_pref($prefname, $value)
// See https://github.com/ghacksuserjs/ghacks-user.js/wiki/1.1-Overview
//
// Source is https://github.com/ghacksuserjs/ghacks-user.js/blob/master/user.js
// with some custom overrides.

// START: internal custom pref to test for syntax errors
user_pref("_user.js.parrot", "START: Oh yes, the Norwegian Blue... what's wrong with it?");

// 0000: disable about:config warning
user_pref("browser.aboutConfig.showWarning", false); // HTML version [FF71+]


/*** [SECTION 0100]: STARTUP ***/
user_pref("_user.js.parrot", "0100 syntax error: the parrot's dead!");
/* 0101: disable default browser check
 * [SETTING] General>Startup>Always check if Firefox is your default browser ***/
user_pref("browser.shell.checkDefaultBrowser", false);
/* 0102: set START page (0=blank, 1=home, 2=last visited page, 3=resume previous session)
 * [NOTE] Session Restore is not used in PB mode (0110) and is cleared with history (2803, 2804)
 * [SETTING] General>Startup>Restore previous session
 * [NOTE] Don't set it to 0 otherwise you get a white page with dark themes
 * ***/
user_pref("browser.startup.page", 1);
/* 0103: set HOME+NEWWINDOW page
 * about:home=Activity Stream (default, see 0105), custom URL, about:blank
 * [SETTING] Home>New Windows and Tabs>Homepage and new windows ***/
//user_pref("browser.startup.homepage", "about:blank");
/* 0104: set NEWTAB page
 * true=Activity Stream (default, see 0105), false=blank page
 * [SETTING] Home>New Windows and Tabs>New tabs
 * [NOTE] Keep it enabled otherwise you get a white page with dark themes
 * ***/
user_pref("browser.newtabpage.enabled", true);
user_pref("browser.newtab.preload", false);

/* 0105: disable Activity Stream stuff (AS)
 * AS is the default homepage/newtab in FF57+, based on metadata and browsing behavior.
 * [SETTING] Home>Firefox Home Content>...  to show/hide what you want ***/
/* 0105a: disable Activity Stream telemetry ***/
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
/* 0105b: disable Activity Stream Snippets
 * Runs code received from a server (aka Remote Code Execution) and sends information back to a metrics server
 * [1] https://abouthome-snippets-service.readthedocs.io/ ***/
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.asrouter.providers.snippets", "");
/* 0105c: disable Activity Stream Top Stories, Pocket-based and/or sponsored content ***/
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.feeds.discoverystreamfeed", false); // [FF66+]
/* 0105d: disable Activity Stream recent Highlights in the Library [FF57+] ***/
user_pref("browser.library.activity-stream.enabled", false);


/*** [SECTION 0200]: GEOLOCATION / LANGUAGE / LOCALE ***/
user_pref("_user.js.parrot", "0200 syntax error: the parrot's definitely deceased!");
/** GEOLOCATION ***/
/* 0201: disable Location-Aware Browsing
 * [NOTE] Best left at default "true", fingerprintable, is already behind a prompt (see 0202)
 * [1] https://www.mozilla.org/firefox/geolocation/ ***/
// user_pref("geo.enabled", false);
/* 0202: set a default permission for Location (see 0201) [FF58+]
 * 0=always ask (default), 1=allow, 2=block
 * [NOTE] Best left at default "always ask", fingerprintable via Permissions API
 * [SETTING] to add site exceptions: Page Info>Permissions>Access Your Location
 * [SETTING] to manage site exceptions: Options>Privacy & Security>Permissions>Location>Settings ***/
user_pref("permissions.default.geo", 2);
/* 0203: use Mozilla geolocation service instead of Google when geolocation is enabled [FF74+]
 * Optionally enable logging to the console (defaults to false) ***/
user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
// user_pref("geo.provider.network.logging.enabled", true); // [HIDDEN PREF]
/* 0204: disable using the OS's geolocation service ***/
user_pref("geo.provider.ms-windows-location", false); // [WINDOWS]
user_pref("geo.provider.use_corelocation", false); // [MAC]
user_pref("geo.provider.use_gpsd", false); // [LINUX]
/* 0206: disable geographically specific results/search engines e.g. "browser.search.*.US"
 * i.e. ignore all of Mozilla's various search engines in multiple locales ***/
user_pref("browser.search.geoSpecificDefaults", false);
user_pref("browser.search.geoSpecificDefaults.url", "");


/** LANGUAGE / LOCALE ***/
/* 0210: set preferred language for displaying web pages
 * [TEST] https://addons.mozilla.org/about ***/
 user_pref("intl.accept_languages", "en-US, en");
 /* 0211: enforce US English locale regardless of the system locale
  * [SETUP-WEB] May break some input methods e.g xim/ibus for CJK languages, see [2]
  * [1] https://bugzilla.mozilla.org/867501
  * [2] https://bugzilla.mozilla.org/1629630 ***/
 user_pref("javascript.use_us_english_locale", true); // [HIDDEN PREF]
 /* 0212: enforce fallback text encoding to match en-US
  * When the content or server doesn't declare a charset the browser will
  * fallback to the "Current locale" based on your application language
  * [SETTING] General>Language and Appearance>Fonts and Colors>Advanced>Text Encoding for Legacy Content
  * [TEST] https://hsivonen.com/test/moz/check-charset.htm
  * [1] https://trac.torproject.org/projects/tor/ticket/20025 ***/
 user_pref("intl.charset.fallback.override", "windows-1252");


/*** [SECTION 0300]: QUIET FOX
   Starting in user.js v67, we only disable the auto-INSTALL of Firefox. You still get prompts
   to update, in one click. We have NEVER disabled auto-CHECKING, and highly discourage that.
   Previously we also disabled auto-INSTALLING of extensions (302b).
   There are many legitimate reasons to turn off auto-INSTALLS, including hijacked or monetized
   extensions, time constraints, legacy issues, dev/testing, and fear of breakage/bugs. It is
   still important to do updates for security reasons, please do so manually if you make changes.
***/
user_pref("_user.js.parrot", "0300 syntax error: the parrot's not pinin' for the fjords!");
/* 0301b: disable auto-CHECKING for extension and theme updates ***/
// user_pref("extensions.update.enabled", false);
/* 0302a: disable auto-INSTALLING Firefox updates [NON-WINDOWS FF65+]
 * [NOTE] In FF65+ on Windows this SETTING (below) is now stored in a file and the pref was removed
 * [SETTING] General>Firefox Updates>Check for updates but let you choose to install them ***/
user_pref("app.update.auto", false);
/* 0302b: disable auto-INSTALLING extension and theme updates (after the check in 0301b)
 * [SETTING] about:addons>Extensions>[cog-wheel-icon]>Update Add-ons Automatically (toggle) ***/
// user_pref("extensions.update.autoUpdateDefault", false);
/* 0306: disable extension metadata
 * used when installing/updating an extension, and in daily background update checks:
 * when false, extension detail tabs will have no description ***/
// user_pref("extensions.getAddons.cache.enabled", false);
/* 0308: disable search engine updates (e.g. OpenSearch)
 * [NOTE] This does not affect Mozilla's built-in or Web Extension search engines
 * [SETTING] General>Firefox Updates>Automatically update search engines ***/
user_pref("browser.search.update", false);
/* 0309: disable sending Flash crash reports ***/
user_pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled", false);
/* 0310: disable sending the URL of the website where a plugin crashed ***/
user_pref("dom.ipc.plugins.reportCrashURL", false);
/* 0320: disable about:addons' Recommendations pane (uses Google Analytics) ***/
user_pref("extensions.getAddons.showPane", false); // [HIDDEN PREF]
/* 0321: disable recommendations in about:addons' Extensions and Themes panes [FF68+] ***/
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);

/* 0330: disable telemetry
 * the pref (.unified) affects the behaviour of the pref (.enabled)
 * IF unified=false then .enabled controls the telemetry module
 * IF unified=true then .enabled ONLY controls whether to record extended data
 * so make sure to have both set as false
 * [NOTE] FF58+ 'toolkit.telemetry.enabled' is now LOCKED to reflect prerelease
 * or release builds (true and false respectively), see [2]
 * [1] https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/telemetry/internals/preferences.html
 * [2] https://medium.com/georg-fritzsche/data-preference-changes-in-firefox-58-2d5df9c428b5 ***/
 user_pref("toolkit.telemetry.unified", false);
 user_pref("toolkit.telemetry.enabled", false); // see [NOTE] above FF58+
 user_pref("toolkit.telemetry.server", "data:,");
 user_pref("toolkit.telemetry.archive.enabled", false);
 user_pref("toolkit.telemetry.newProfilePing.enabled", false); // [FF55+]
 user_pref("toolkit.telemetry.shutdownPingSender.enabled", false); // [FF55+]
 user_pref("toolkit.telemetry.updatePing.enabled", false); // [FF56+]
 user_pref("toolkit.telemetry.bhrPing.enabled", false); // [FF57+] Background Hang Reporter
 user_pref("toolkit.telemetry.firstShutdownPing.enabled", false); // [FF57+]
 /* 0331: disable Telemetry Coverage
  * [1] https://blog.mozilla.org/data/2018/08/20/effectively-measuring-search-in-firefox/ ***/
 user_pref("toolkit.telemetry.coverage.opt-out", true); // [HIDDEN PREF]
 user_pref("toolkit.coverage.opt-out", true); // [FF64+] [HIDDEN PREF]
 user_pref("toolkit.coverage.endpoint.base", "");
 /* 0340: disable Health Reports
  * [SETTING] Privacy & Security>Firefox Data Collection & Use>Allow Firefox to send technical... data ***/
 user_pref("datareporting.healthreport.uploadEnabled", false);
 /* 0341: disable new data submission, master kill switch [FF41+]
  * If disabled, no policy is shown or upload takes place, ever
  * [1] https://bugzilla.mozilla.org/1195552 ***/
 user_pref("datareporting.policy.dataSubmissionEnabled", false);
 /* 0342: disable Studies (see 0503)
  * [SETTING] Privacy & Security>Firefox Data Collection & Use>Allow Firefox to install and run studies ***/
 user_pref("app.shield.optoutstudies.enabled", false);
 /* 0343: disable personalized Extension Recommendations in about:addons and AMO [FF65+]
  * [NOTE] This pref has no effect when Health Reports (0340) are disabled
  * [SETTING] Privacy & Security>Firefox Data Collection & Use>Allow Firefox to make personalized extension recommendations
  * [1] https://support.mozilla.org/kb/personalized-extension-recommendations ***/
 user_pref("browser.discovery.enabled", false);
 /* 0350: disable Crash Reports ***/
 user_pref("breakpad.reportURL", "");
 user_pref("browser.tabs.crashReporting.sendReport", false); // [FF44+]
 user_pref("browser.crashReports.unsubmittedCheck.enabled", false); // [FF51+]
 /* 0351: disable backlogged Crash Reports
  * [SETTING] Privacy & Security>Firefox Data Collection & Use>Allow Firefox to send backlogged crash reports  ***/
 user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false); // [FF58+]
 /* 0390: disable Captive Portal detection
  * [1] https://www.eff.org/deeplinks/2017/08/how-captive-portals-interfere-wireless-security-and-privacy
  * [2] https://wiki.mozilla.org/Necko/CaptivePortal ***/
 user_pref("captivedetect.canonicalURL", "");
 user_pref("network.captive-portal-service.enabled", false); // [FF52+]
 /* 0391: disable Network Connectivity checks [FF65+]
  * [1] https://bugzilla.mozilla.org/1460537 ***/
 user_pref("network.connectivity-service.enabled", false);


/*** [SECTION 0400]: BLOCKLISTS / SAFE BROWSING (SB) ***/
user_pref("_user.js.parrot", "0400 syntax error: the parrot's passed on!");
/** BLOCKLISTS ***/
/* 0401: enforce Firefox blocklist, but sanitize blocklist url
 * [NOTE] It includes updates for "revoked certificates"
 * [1] https://blog.mozilla.org/security/2015/03/03/revoking-intermediate-certificates-introducing-onecrl/
 * [2] https://trac.torproject.org/projects/tor/ticket/16931 ***/
user_pref("extensions.blocklist.enabled", true); // [DEFAULT: true]
user_pref("extensions.blocklist.url", "https://blocklists.settings.services.mozilla.com/v1/blocklist/3/%APP_ID%/%APP_VERSION%/");

/** SAFE BROWSING (SB)
    Safe Browsing has taken many steps to preserve privacy. *IF* required, a full url is never
    sent to Google, only a PART-hash of the prefix, and this is hidden with noise of other real
    PART-hashes. Google also swear it is anonymized and only used to flag malicious sites.
    Firefox also takes measures such as striping out identifying parameters and since SBv4 (FF57+)
    doesn't even use cookies. (#Turn on browser.safebrowsing.debug to monitor this activity)
    #Required reading [#] https://feeding.cloud.geek.nz/posts/how-safe-browsing-works-in-firefox/
    [1] https://wiki.mozilla.org/Security/Safe_Browsing
    [2] https://support.mozilla.org/en-US/kb/how-does-phishing-and-malware-protection-work
***/
/* 0410: disable SB (Safe Browsing)
 * [WARNING] Do this at your own risk! These are the master switches.
 * [SETTING] Privacy & Security>Security>... "Block dangerous and deceptive content" ***/
// user_pref("browser.safebrowsing.malware.enabled", false);
// user_pref("browser.safebrowsing.phishing.enabled", false);
/* 0411: disable SB checks for downloads (both local lookups + remote)
 * This is the master switch for the safebrowsing.downloads* prefs (0412, 0413)
 * [SETTING] Privacy & Security>Security>... "Block dangerous downloads" ***/
// user_pref("browser.safebrowsing.downloads.enabled", false);
/* 0412: disable SB checks for downloads (remote)
 * To verify the safety of certain executable files, Firefox may submit some information about the
 * file, including the name, origin, size and a cryptographic hash of the contents, to the Google
 * Safe Browsing service which helps Firefox determine whether or not the file should be blocked
 * [SETUP-SECURITY] If you do not understand this, or you want this protection, then override it ***/
// user_pref("browser.safebrowsing.downloads.remote.enabled", false);
// user_pref("browser.safebrowsing.downloads.remote.url", "");
/* 0413: disable SB checks for unwanted software
 * [SETTING] Privacy & Security>Security>... "Warn you about unwanted and uncommon software" ***/
// user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
// user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
/* 0419: disable 'ignore this warning' on SB warnings
 * If clicked, it bypasses the block for that session. This is a means for admins to enforce SB
 * [TEST] see github wiki APPENDIX A: Test Sites: Section 5
 * [1] https://bugzilla.mozilla.org/1226490 ***/
// user_pref("browser.safebrowsing.allowOverride", false);


/*** [SECTION 0500]: SYSTEM ADD-ONS / EXPERIMENTS
     System Add-ons are a method for shipping extensions, considered to be
     built-in features to Firefox, that are hidden from the about:addons UI.
     To view your System Add-ons go to about:support, they are listed under "Firefox Features"
     Some System Add-ons have no on-off prefs. Instead you can manually remove them. Note that app
     updates will restore them. They may also be updated and possibly restored automatically (see 0505)
     * Portable: "...\App\Firefox64\browser\features\" (or "App\Firefox\etc" for 32bit)
     * Windows: "...\Program Files\Mozilla\browser\features" (or "Program Files (X86)\etc" for 32bit)
     * Mac: "...\Applications\Firefox\Contents\Resources\browser\features\"
            [NOTE] On Mac you can right-click on the application and select "Show Package Contents"
     * Linux: "/usr/lib/firefox/browser/features" (or similar)
     [1] https://firefox-source-docs.mozilla.org/toolkit/mozapps/extensions/addon-manager/SystemAddons.html
     [2] https://dxr.mozilla.org/mozilla-central/source/browser/extensions
***/
user_pref("_user.js.parrot", "0500 syntax error: the parrot's cashed in 'is chips!");
/* 0503: disable Normandy/Shield [FF60+]
 * Shield is an telemetry system (including Heartbeat) that can also push and test "recipes"
 * [1] https://wiki.mozilla.org/Firefox/Shield
 * [2] https://github.com/mozilla/normandy ***/
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");
/* 0505: disable System Add-on updates ***/
user_pref("extensions.systemAddon.update.enabled", false); // [FF62+]
user_pref("extensions.systemAddon.update.url", ""); // [FF44+]
/* 0506: disable PingCentre telemetry (used in several System Add-ons) [FF57+]
 * Currently blocked by 'datareporting.healthreport.uploadEnabled' (see 0340) ***/
user_pref("browser.ping-centre.telemetry", false);
/* 0515: disable Screenshots
 * alternatively in FF60+, disable uploading to the Screenshots server
 * [1] https://github.com/mozilla-services/screenshots
 * [2] https://www.ghacks.net/2017/05/28/firefox-screenshots-integrated-in-firefox-nightly/ ***/
// user_pref("extensions.screenshots.disabled", true); // [FF55+]
// user_pref("extensions.screenshots.upload-disabled", true); // [FF60+]
/* 0517: disable Form Autofill
 * [NOTE] Stored data is NOT secure (uses a JSON file)
 * [NOTE] Heuristics controls Form Autofill on forms without @autocomplete attributes
 * [SETTING] Privacy & Security>Forms and Autofill>Autofill addresses (FF74+)
 * [1] https://wiki.mozilla.org/Firefox/Features/Form_Autofill
 * [2] https://www.ghacks.net/2017/05/24/firefoxs-new-form-autofill-is-awesome/ ***/
user_pref("extensions.formautofill.addresses.enabled", false); // [FF55+]
user_pref("extensions.formautofill.available", "off"); // [FF56+]
user_pref("extensions.formautofill.creditCards.enabled", false); // [FF56+]
user_pref("extensions.formautofill.heuristics.enabled", false); // [FF55+]
/* 0518: disable Web Compatibility Reporter [FF56+]
 * Web Compatibility Reporter adds a "Report Site Issue" button to send data to Mozilla ***/
user_pref("extensions.webcompat-reporter.enabled", false);


/*** [SECTION 0600]: BLOCK IMPLICIT OUTBOUND [not explicitly asked for - e.g. clicked on] ***/
user_pref("_user.js.parrot", "0600 syntax error: the parrot's no more!");
/* 0601: disable link prefetching
 * [1] https://developer.mozilla.org/docs/Web/HTTP/Link_prefetching_FAQ ***/
user_pref("network.prefetch-next", false);
/* 0602: disable DNS prefetching
 * [1] https://www.ghacks.net/2013/04/27/firefox-prefetching-what-you-need-to-know/
 * [2] https://developer.mozilla.org/docs/Web/HTTP/Headers/X-DNS-Prefetch-Control ***/
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true); // [HIDDEN PREF ESR] [DEFAULT: true FF70+]
/* 0603: disable predictor / prefetching ***/
user_pref("network.predictor.enabled", false);
user_pref("network.predictor.enable-prefetch", false); // [FF48+]
/* 0605: disable link-mouseover opening connection to linked server
 * [1] https://news.slashdot.org/story/15/08/14/2321202/how-to-quash-firefoxs-silent-requests
 * [2] https://www.ghacks.net/2015/08/16/block-firefox-from-connecting-to-sites-when-you-hover-over-links/ ***/
user_pref("network.http.speculative-parallel-limit", 0);
/* 0606: disable "Hyperlink Auditing" (click tracking) and enforce same host in case
 * [1] https://www.bleepingcomputer.com/news/software/major-browsers-to-prevent-disabling-of-click-tracking-privacy-risk/ ***/
user_pref("browser.send_pings", false); // [DEFAULT: false]
user_pref("browser.send_pings.require_same_host", true);

/*** [SECTION 0700]: HTTP* / TCP/IP / DNS / PROXY / SOCKS etc ***/
/*** SKIPPED ***/


/*** [SECTION 0800]: LOCATION BAR / SEARCH BAR / SUGGESTIONS / HISTORY / FORMS
     Change items 0850 and above to suit for privacy vs convenience and functionality. Consider
     your environment (no unwanted eyeballs), your device (restricted access), your device's
     unattended state (locked, encrypted, forensic hardened). Likewise, you may want to check
     the items cleared on shutdown in section 2800.
     [NOTE] The urlbar is also commonly referred to as the location bar and address bar
     #Required reading [#] https://xkcd.com/538/
***/
user_pref("_user.js.parrot", "0800 syntax error: the parrot's ceased to be!");
/* 0801: disable location bar using search
 * Don't leak URL typos to a search engine, give an error message instead.
 * Examples: "secretplace,com", "secretplace/com", "secretplace com", "secret place.com"
 * [NOTE] Search buttons in the dropdown work, but hitting 'enter' in the location bar will fail
 * [TIP] You can add keywords to search engines in options (e.g. 'd' for DuckDuckGo) and
 * the dropdown will now auto-select it and you can then hit 'enter' and it will work
 * [SETUP-CHROME] If you don't, or rarely, type URLs, or you use a default search
 * engine that respects privacy, then you probably don't need this ***/
// user_pref("keyword.enabled", false);
/* 0802: disable location bar domain guessing
 * domain guessing intercepts DNS "hostname not found errors" and resends a
 * request (e.g. by adding www or .com). This is inconsistent use (e.g. FQDNs), does not work
 * via Proxy Servers (different error), is a flawed use of DNS (TLDs: why treat .com
 * as the 411 for DNS errors?), privacy issues (why connect to sites you didn't
 * intend to), can leak sensitive data (e.g. query strings: e.g. Princeton attack),
 * and is a security risk (e.g. common typos & malicious sites set up to exploit this) ***/
user_pref("browser.fixup.alternate.enabled", false);
/* 0803: display all parts of the url in the location bar ***/
user_pref("browser.urlbar.trimURLs", false);
/* 0805: disable coloring of visited links - CSS history leak
 * [NOTE] This has NEVER been fully "resolved": in Mozilla/docs it is stated it's
 * only in 'certain circumstances', also see latest comments in [2]
 * [TEST] https://earthlng.github.io/testpages/visited_links.html (see github wiki APPENDIX A on how to use)
 * [1] https://dbaron.org/mozilla/visited-privacy
 * [2] https://bugzilla.mozilla.org/147777
 * [3] https://developer.mozilla.org/docs/Web/CSS/Privacy_and_the_:visited_selector ***/
// user_pref("layout.css.visited_links_enabled", false);
/* 0807: disable live search suggestions
/* [NOTE] Both must be true for the location bar to work
 * [SETUP-CHROME] Change these if you trust and use a privacy respecting search engine
 * [SETTING] Search>Provide search suggestions | Show search suggestions in address bar results ***/
// user_pref("browser.search.suggest.enabled", false);
// user_pref("browser.urlbar.suggest.searches", false);
/* 0809: disable location bar suggesting "preloaded" top websites [FF54+]
 * [1] https://bugzilla.mozilla.org/1211726 ***/
// user_pref("browser.urlbar.usepreloadedtopurls.enabled", false);
/* 0810: disable location bar making speculative connections [FF56+]
 * [1] https://bugzilla.mozilla.org/1348275 ***/
// user_pref("browser.urlbar.speculativeConnect.enabled", false);
/* 0850a: disable location bar suggestion types
 * If all three suggestion types are false, search engine keywords are disabled
 * [SETTING] Privacy & Security>Address Bar>When using the address bar, suggest ***/
// user_pref("browser.urlbar.suggest.history", false);
// user_pref("browser.urlbar.suggest.bookmark", false);
// user_pref("browser.urlbar.suggest.openpage", false);
/* 0850c: disable location bar dropdown
 * This value controls the total number of entries to appear in the location bar dropdown
 * [NOTE] Items (bookmarks/history/openpages) with a high "frecency"/"bonus" will always
 * be displayed (no we do not know how these are calculated or what the threshold is),
 * and this does not affect the search by search engine suggestion (see 0807)
 * [NOTE] This setting is only useful if you want to enable search engine keywords
 * (i.e. at least one of 0850a suggestion types must be true) but you want to *limit* suggestions shown ***/
// user_pref("browser.urlbar.maxRichResults", 0);
/* 0850d: disable location bar autofill
 * [1] https://support.mozilla.org/en-US/kb/address-bar-autocomplete-firefox#w_url-autocomplete ***/
   // user_pref("browser.urlbar.autoFill", false);
/* 0850e: disable location bar one-off searches [FF51+]
 * [1] https://www.ghacks.net/2016/08/09/firefox-one-off-searches-address-bar/ ***/
   // user_pref("browser.urlbar.oneOffSearches", false);
/* 0860: disable search and form history
 * [SETUP-WEB] Be aware thet autocomplete form data can be read by third parties, see [1] [2]
 * [NOTE] We also clear formdata on exit (see 2803)
 * [SETTING] Privacy & Security>History>Custom Settings>Remember search and form history
 * [1] https://blog.mindedsecurity.com/2011/10/autocompleteagain.html
 * [2] https://bugzilla.mozilla.org/381681 ***/
user_pref("browser.formfill.enable", false);
/* 0862: disable browsing and download history
 * [NOTE] We also clear history and downloads on exiting Firefox (see 2803)
 * [SETTING] Privacy & Security>History>Custom Settings>Remember browsing and download history ***/
   // user_pref("places.history.enabled", false);
/* 0870: disable Windows jumplist [WINDOWS] ***/
user_pref("browser.taskbar.lists.enabled", false);
user_pref("browser.taskbar.lists.frequent.enabled", false);
user_pref("browser.taskbar.lists.recent.enabled", false);
user_pref("browser.taskbar.lists.tasks.enabled", false);
/* 0871: disable Windows taskbar preview [WINDOWS] ***/
user_pref("browser.taskbar.previews.enable", false);


/*** [SECTION 0900]: PASSWORDS ***/
user_pref("_user.js.parrot", "0900 syntax error: the parrot's expired!");
/* 0901: disable saving passwords
 * [NOTE] This does not clear any passwords already saved
 * [SETTING] Privacy & Security>Logins and Passwords>Ask to save logins and passwords for websites ***/
user_pref("signon.rememberSignons", false);
/* 0905: disable auto-filling username & password form fields
 * can leak in cross-site forms *and* be spoofed
 * [NOTE] Username & password is still available when you enter the field
 * [SETTING] Privacy & Security>Logins and Passwords>Autofill logins and passwords ***/
user_pref("signon.autofillForms", false);
/* 0909: disable formless login capture for Password Manager [FF51+] ***/
user_pref("signon.formlessCapture.enabled", false);
/* 0912: limit (or disable) HTTP authentication credentials dialogs triggered by sub-resources [FF41+]
 * hardens against potential credentials phishing
 * 0=don't allow sub-resources to open HTTP authentication credentials dialogs
 * 1=don't allow cross-origin sub-resources to open HTTP authentication credentials dialogs
 * 2=allow sub-resources to open HTTP authentication credentials dialogs (default)
 * [1] https://www.fxsitecompat.com/en-CA/docs/2015/http-auth-dialog-can-no-longer-be-triggered-by-cross-origin-resources/ ***/
user_pref("network.auth.subresource-http-auth-allow", 1);


/*** [SECTION 1000]: CACHE / SESSION (RE)STORE / FAVICONS ***/
/*** SKIPPED ***/


/*** [SECTION 1200]: HTTPS (SSL/TLS / OCSP / CERTS / HPKP / CIPHERS) ***/
/*** SKIPPED EXCEPT UI PART ***/
/** UI (User Interface) ***/
/* 1270: display warning on the padlock for "broken security" (if 1201 is false)
 * Bug: warning padlock not indicated for subresources on a secure page! [2]
 * [1] https://wiki.mozilla.org/Security:Renegotiation
 * [2] https://bugzilla.mozilla.org/1353705 ***/
 user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
 /* 1271: control "Add Security Exception" dialog on SSL warnings
  * 0=do neither 1=pre-populate url 2=pre-populate url + pre-fetch cert (default)
  * [1] https://github.com/pyllyukko/user.js/issues/210 ***/
 user_pref("browser.ssl_override_behavior", 1);
 /* 1272: display advanced information on Insecure Connection warning pages
  * only works when it's possible to add an exception
  * i.e. it doesn't work for HSTS discrepancies (https://subdomain.preloaded-hsts.badssl.com/)
  * [TEST] https://expired.badssl.com/ ***/
 user_pref("browser.xul.error_pages.expert_bad_cert", true);
 /* 1273: display "insecure" icon and "Not Secure" text on HTTP sites ***/
 user_pref("security.insecure_connection_text.enabled", true); // [FF60+]


/*** [SECTION 1400]: FONTS ***/
/*** SKIPPED ***/

/*** [SECTION 1600]: HEADERS / REFERERS ***/
/*** SKIPPED ***/


/*** [SECTION 1700]: CONTAINERS
     If you want to *really* leverage containers, we highly recommend Temporary Containers [2].
     Read the article by the extension author [3], and check out the github wiki/repo [4].
     [1] https://wiki.mozilla.org/Security/Contextual_Identity_Project/Containers
     [2] https://addons.mozilla.org/firefox/addon/temporary-containers/
     [3] https://medium.com/@stoically/enhance-your-privacy-in-firefox-with-temporary-containers-33925cd6cd21
     [4] https://github.com/stoically/temporary-containers/wiki
***/
user_pref("_user.js.parrot", "1700 syntax error: the parrot's bit the dust!");
/* 1701: enable Container Tabs setting in preferences (see 1702) [FF50+]
 * [1] https://bugzilla.mozilla.org/1279029 ***/
user_pref("privacy.userContext.ui.enabled", true);
/* 1702: enable Container Tabs [FF50+]
 * [SETTING] General>Tabs>Enable Container Tabs ***/
user_pref("privacy.userContext.enabled", true);
/* 1703: set behaviour on "+ Tab" button to display container menu on left click [FF74+]
 * [NOTE] The menu is always shown on long press and right click
 * [SETTING] General>Tabs>Enable Container Tabs>Settings>Select a container for each new tab ***/
user_pref("privacy.userContext.newTabContainerOnLeftClick.enabled", false);


/*** [SECTION 1800]: PLUGINS ***/
user_pref("_user.js.parrot", "1800 syntax error: the parrot's pushing up daisies!");
/* 1803: disable Flash plugin
 * 0=deactivated, 1=ask, 2=enabled
 * ESR52.x is the last branch to *fully* support NPAPI, FF52+ stable only supports Flash
 * [NOTE] You can still override individual sites via site permissions
 * [1] https://www.ghacks.net/2013/07/09/how-to-make-sure-that-a-firefox-plugin-never-activates-again/ ***/
user_pref("plugin.state.flash", 0);


/*** [SECTION 2000]: MEDIA / CAMERA / MIC ***/
user_pref("_user.js.parrot", "2000 syntax error: the parrot's snuffed it!");
/* 2001: disable WebRTC (Web Real-Time Communication)
 * [SETUP-WEB] WebRTC can leak your IP address from behind your VPN, but if this is not
 * in your threat model, and you want Real-Time Communication, this is the pref for you
 * [1] https://www.privacytools.io/#webrtc ***/
user_pref("media.peerconnection.enabled", false);
/* 2024: set a default permission for Camera/Microphone [FF58+]
 * 0=always ask (default), 1=allow, 2=block
 * [SETTING] to add site exceptions: Page Info>Permissions>Use the Camera/Microphone
 * [SETTING] to manage site exceptions: Options>Privacy & Security>Permissions>Camera/Microphone>Settings ***/
user_pref("permissions.default.camera", 2);
user_pref("permissions.default.microphone", 2);
/* 2030: disable autoplay of HTML5 media [FF63+]
 * 0=Allow all, 1=Block non-muted media (default in FF67+), 2=Prompt (removed in FF66), 5=Block all (FF69+)
 * [NOTE] You can set exceptions under site permissions
 * [SETTING] Privacy & Security>Permissions>Autoplay>Settings>Default for all websites ***/
// user_pref("media.autoplay.default", 5);
/* 2031: disable autoplay of HTML5 media if you interacted with the site [FF66+] ***/
user_pref("media.autoplay.enabled.user-gestures-needed", false);


/*** [SECTION 2200]: WINDOW MEDDLING & LEAKS / POPUPS ***/
user_pref("_user.js.parrot", "2200 syntax error: the parrot's 'istory!");
/* 2201: prevent websites from disabling new window features ***/
user_pref("dom.disable_window_open_feature.close", true);
user_pref("dom.disable_window_open_feature.location", true); // [DEFAULT: true]
user_pref("dom.disable_window_open_feature.menubar", true);
user_pref("dom.disable_window_open_feature.minimizable", true);
user_pref("dom.disable_window_open_feature.personalbar", true); // bookmarks toolbar
user_pref("dom.disable_window_open_feature.resizable", true); // [DEFAULT: true]
user_pref("dom.disable_window_open_feature.status", true); // [DEFAULT: true]
user_pref("dom.disable_window_open_feature.titlebar", true);
user_pref("dom.disable_window_open_feature.toolbar", true);
/* 2202: prevent scripts from moving and resizing open windows ***/
user_pref("dom.disable_window_move_resize", true);
/* 2203: open links targeting new windows in a new tab instead
 * This stops malicious window sizes and some screen resolution leaks.
 * You can still right-click a link and open in a new window.
 * [TEST] https://ghacksuserjs.github.io/TorZillaPrint/TorZillaPrint.html#screen
 * [1] https://trac.torproject.org/projects/tor/ticket/9881 ***/
user_pref("browser.link.open_newwindow", 3);
user_pref("browser.link.open_newwindow.restriction", 0);
/* 2204: disable Fullscreen API (requires user interaction) to prevent screen-resolution leaks
 * [NOTE] You can still manually toggle the browser's fullscreen state (F11),
 * but this pref will disable embedded video/game fullscreen controls, e.g. youtube
 * [TEST] https://ghacksuserjs.github.io/TorZillaPrint/TorZillaPrint.html#screen ***/
// user_pref("full-screen-api.enabled", false);
/* 2210: block popup windows
 * [SETTING] Privacy & Security>Permissions>Block pop-up windows ***/
user_pref("dom.disable_open_during_load", true);
/* 2212: limit events that can cause a popup [SETUP-WEB]
 * default is "change click dblclick auxclick mouseup pointerup notificationclick reset submit touchend contextmenu" ***/
user_pref("dom.popup_allowed_events", "click dblclick");


/*** [SECTION 2300]: WEB WORKERS
     A worker is a JS "background task" running in a global context, i.e. it is different from
     the current window. Workers can spawn new workers (must be the same origin & scheme),
     including service and shared workers. Shared workers can be utilized by multiple scripts and
     communicate between browsing contexts (windows/tabs/iframes) and can even control your cache.
     [NOTE] uMatrix 1.2.0+ allows a per-scope control for workers (2301-deprecated) and service workers (2302)
              #Required reading [#] https://github.com/gorhill/uMatrix/releases/tag/1.2.0
     [1]    Web Workers: https://developer.mozilla.org/docs/Web/API/Web_Workers_API
     [2]         Worker: https://developer.mozilla.org/docs/Web/API/Worker
     [3] Service Worker: https://developer.mozilla.org/docs/Web/API/Service_Worker_API
     [4]   SharedWorker: https://developer.mozilla.org/docs/Web/API/SharedWorker
     [5]   ChromeWorker: https://developer.mozilla.org/docs/Web/API/ChromeWorker
     [6]  Notifications: https://support.mozilla.org/questions/1165867#answer-981820
***/
user_pref("_user.js.parrot", "2300 syntax error: the parrot's off the twig!");
/* 2302: disable service workers [FF32, FF44-compat]
 * Service workers essentially act as proxy servers that sit between web apps, and the
 * browser and network, are event driven, and can control the web page/site it is associated
 * with, intercepting and modifying navigation and resource requests, and caching resources.
 * [NOTE] Service worker APIs are hidden (in Firefox) and cannot be used when in PB mode.
 * [NOTE] Service workers only run over HTTPS. Service workers have no DOM access.
 * [SETUP-WEB] Disabling service workers will break some sites. This pref is required true for
 * service worker notifications (2304), push notifications (disabled, 2305) and service worker
 * cache (2740). If you enable this pref, then check those settings as well ***/
// user_pref("dom.serviceWorkers.enabled", false);
/* 2304: disable Web Notifications
 * [NOTE] Web Notifications can also use service workers (2302) and are behind a prompt (2306)
 * [1] https://developer.mozilla.org/docs/Web/API/Notifications_API ***/
   // user_pref("dom.webnotifications.enabled", false); // [FF22+]
   // user_pref("dom.webnotifications.serviceworker.enabled", false); // [FF44+]
/* 2305: disable Push Notifications [FF44+]
 * Push is an API that allows websites to send you (subscribed) messages even when the site
 * isn't loaded, by pushing messages to your userAgentID through Mozilla's Push Server.
 * [NOTE] Push requires service workers (2302) to subscribe to and display, and is behind
 * a prompt (2306). Disabling service workers alone doesn't stop Firefox polling the
 * Mozilla Push Server. To remove all subscriptions, reset your userAgentID (in about:config
 * or on start), and you will get a new one within a few seconds.
 * [1] https://support.mozilla.org/en-US/kb/push-notifications-firefox
 * [2] https://developer.mozilla.org/en-US/docs/Web/API/Push_API ***/
user_pref("dom.push.enabled", false);
   // user_pref("dom.push.userAgentID", "");
/* 2306: set a default permission for Notifications (both 2304 and 2305) [FF58+]
 * 0=always ask (default), 1=allow, 2=block
 * [NOTE] Best left at default "always ask", fingerprintable via Permissions API
 * [SETTING] to add site exceptions: Page Info>Permissions>Receive Notifications
 * [SETTING] to manage site exceptions: Options>Privacy & Security>Permissions>Notifications>Settings ***/
// user_pref("permissions.default.desktop-notification", 2);


/*** [SECTION 2400]: DOM (DOCUMENT OBJECT MODEL) & JAVASCRIPT ***/
/*** SKIPPED ***/


/*** [SECTION 2500]: HARDWARE FINGERPRINTING ***/
user_pref("_user.js.parrot", "2500 syntax error: the parrot's shuffled off 'is mortal coil!");
/* 2502: disable Battery Status API
 * Initially a Linux issue (high precision readout) that was fixed.
 * However, it is still another metric for fingerprinting, used to raise entropy.
 * e.g. do you have a battery or not, current charging status, charge level, times remaining etc
 * [NOTE] From FF52+ Battery Status API is only available in chrome/privileged code. see [1]
 * [1] https://bugzilla.mozilla.org/1313580 ***/
   // user_pref("dom.battery.enabled", false);
/* 2505: disable media device enumeration [FF29+]
 * [NOTE] media.peerconnection.enabled should also be set to false (see 2001)
 * [1] https://wiki.mozilla.org/Media/getUserMedia
 * [2] https://developer.mozilla.org/docs/Web/API/MediaDevices/enumerateDevices ***/
user_pref("media.navigator.enabled", false);
/* 2508: disable hardware acceleration to reduce graphics fingerprinting [SETUP-HARDEN]
 * [WARNING] Affects text rendering (fonts will look different), impacts video performance,
 * and parts of Quantum that utilize the GPU will also be affected as they are rolled out
 * [SETTING] General>Performance>Custom>Use hardware acceleration when available
 * [1] https://wiki.mozilla.org/Platform/GFX/HardwareAcceleration ***/
   // user_pref("gfx.direct2d.disabled", true); // [WINDOWS]
   // user_pref("layers.acceleration.disabled", true);
/* 2510: disable Web Audio API [FF51+]
 * [1] https://bugzilla.mozilla.org/1288359 ***/
user_pref("dom.webaudio.enabled", false);
/* 2517: disable Media Capabilities API [FF63+]
 * [WARNING] This *may* affect media performance if disabled, no one is sure
 * [1] https://github.com/WICG/media-capabilities
 * [2] https://wicg.github.io/media-capabilities/#security-privacy-considerations ***/
   // user_pref("media.media-capabilities.enabled", false);
/* 2520: disable virtual reality devices
 * Optional protection depending on your connected devices
 * [1] https://developer.mozilla.org/docs/Web/API/WebVR_API ***/
user_pref("dom.vr.enabled", false);
/* 2521: set a default permission for Virtual Reality (see 2520) [FF73+]
 * 0=always ask (default), 1=allow, 2=block
 * [SETTING] to add site exceptions: Page Info>Permissions>Access Virtual Reality Devices
 * [SETTING] to manage site exceptions: Options>Privacy & Security>Permissions>Virtual Reality>Settings ***/
user_pref("permissions.default.xr", 2);


/*** [SECTION 2600]: MISCELLANEOUS ***/
user_pref("_user.js.parrot", "2600 syntax error: the parrot's run down the curtain!");
/* 2601: prevent accessibility services from accessing your browser [RESTART]
 * [SETTING] Privacy & Security>Permissions>Prevent accessibility services from accessing your browser
 * [1] https://support.mozilla.org/kb/accessibility-services ***/
user_pref("accessibility.force_disabled", 1);
/* 2602: disable sending additional analytics to web servers
 * [1] https://developer.mozilla.org/docs/Web/API/Navigator/sendBeacon ***/
user_pref("beacon.enabled", false);
/* 2603: remove temp files opened with an external application
 * [1] https://bugzilla.mozilla.org/302433 ***/
user_pref("browser.helperApps.deleteTempFileOnExit", true);
/* 2604: disable page thumbnail collection
 * look in profile/thumbnails directory - you may want to clean that out ***/
user_pref("browser.pagethumbnails.capturing_disabled", true); // [HIDDEN PREF]
/* 2605: block web content in file processes [FF55+]
 * [SETUP-WEB] You may want to disable this for corporate or developer environments
 * [1] https://bugzilla.mozilla.org/1343184 ***/
user_pref("browser.tabs.remote.allowLinkedWebInFileUriProcess", false);
/* 2606: disable UITour backend so there is no chance that a remote page can use it ***/
user_pref("browser.uitour.enabled", false);
user_pref("browser.uitour.url", "");
/* 2607: disable various developer tools in browser context
 * [SETTING] Devtools>Advanced Settings>Enable browser chrome and add-on debugging toolboxes
 * [1] https://github.com/pyllyukko/user.js/issues/179#issuecomment-246468676 ***/
user_pref("devtools.chrome.enabled", false);
/* 2608: disable remote debugging
 * [1] https://trac.torproject.org/projects/tor/ticket/16222 ***/
user_pref("devtools.debugger.remote-enabled", false);
/* 2609: disable MathML (Mathematical Markup Language) [FF51+] [SETUP-HARDEN]
 * [TEST] https://ghacksuserjs.github.io/TorZillaPrint/TorZillaPrint.html#misc
 * [1] https://bugzilla.mozilla.org/1173199 ***/
   // user_pref("mathml.disabled", true);
/* 2610: disable in-content SVG (Scalable Vector Graphics) [FF53+]
 * [NOTE] In FF70+ and ESR68.1.0+ this no longer affects extensions (1564208)
 * [WARNING] Expect breakage incl. youtube player controls. Best left for a "hardened" profile.
 * [1] https://bugzilla.mozilla.org/1216893 ***/
   // user_pref("svg.disabled", true);
/* 2611: disable middle mouse click opening links from clipboard
 * [1] https://trac.torproject.org/projects/tor/ticket/10089 ***/
user_pref("middlemouse.contentLoadURL", false);
/* 2614: limit HTTP redirects (this does not control redirects with HTML meta tags or JS)
 * [NOTE] A low setting of 5 or under will probably break some sites (e.g. gmail logins)
 * To control HTML Meta tag and JS redirects, use an extension. Default is 20 ***/
user_pref("network.http.redirection-limit", 10);
/* 2615: disable websites overriding Firefox's keyboard shortcuts [FF58+]
 * 0 (default) or 1=allow, 2=block
 * [SETTING] to add site exceptions: Page Info>Permissions>Override Keyboard Shortcuts ***/
   // user_pref("permissions.default.shortcuts", 2);
/* 2616: remove special permissions for certain mozilla domains [FF35+]
 * [1] resource://app/defaults/permissions ***/
user_pref("permissions.manager.defaultsUrl", "");
/* 2617: remove webchannel whitelist ***/
user_pref("webchannel.allowObject.urlWhitelist", "");
/* 2619: enforce Punycode for Internationalized Domain Names to eliminate possible spoofing
 * Firefox has *some* protections, but it is better to be safe than sorry
 * [SETUP-WEB] Might be undesirable for non-latin alphabet users since legitimate IDN's are also punycoded
 * [TEST] https://www.xn--80ak6aa92e.com/ (www.apple.com)
 * [1] https://wiki.mozilla.org/IDN_Display_Algorithm
 * [2] https://en.wikipedia.org/wiki/IDN_homograph_attack
 * [3] CVE-2017-5383: https://www.mozilla.org/security/advisories/mfsa2017-02/
 * [4] https://www.xudongz.com/blog/2017/idn-phishing/ ***/
user_pref("network.IDN_show_punycode", true);
/* 2620: enforce Firefox's built-in PDF reader [SETUP-CHROME]
 * This setting controls if the option "Display in Firefox" is available in the setting below
 *   and by effect controls whether PDFs are handled in-browser or externally ("Ask" or "Open With")
 * PROS: pdfjs is lightweight, open source, and as secure/vetted as any pdf reader out there (more than most)
 *   Exploits are rare (1 serious case in 4 yrs), treated seriously and patched quickly.
 *   It doesn't break "state separation" of browser content (by not sharing with OS, independent apps).
 *   It maintains disk avoidance and application data isolation. It's convenient. You can still save to disk.
 * CONS: You may prefer a different pdf reader for security reasons
 * CAVEAT: JS can still force a pdf to open in-browser by bundling its own code (rare)
 * [SETTING] General>Applications>Portable Document Format (PDF) ***/
user_pref("pdfjs.disabled", false); // [DEFAULT: false]
/* 2621: disable links launching Windows Store on Windows 8/8.1/10 [WINDOWS]
 * [1] https://www.ghacks.net/2016/03/25/block-firefox-chrome-windows-store/ ***/
user_pref("network.protocol-handler.external.ms-windows-store", false);
/* 2622: enforce no system colors; they can be fingerprinted
 * [SETTING] General>Language and Appearance>Fonts and Colors>Colors>Use system colors ***/
user_pref("browser.display.use_system_colors", false); // [DEFAULT: false]
/* 2623: disable permissions delegation [FF73+]
 * Currently applies to cross-origin geolocation, camera, mic and screen-sharing
 * permissions, and fullscreen requests. Disabling delegation means any prompts
 * for these will show/use their correct 3rd party origin
 * [1] https://groups.google.com/forum/#!topic/mozilla.dev.platform/BdFOMAuCGW8/discussion */
user_pref("permissions.delegation.enabled", false);


/** DOWNLOADS ***/
/* 2650: discourage downloading to desktop
 * 0=desktop, 1=downloads (default), 2=last used
 * [SETTING] To set your default "downloads": General>Downloads>Save files to ***/
   // user_pref("browser.download.folderList", 2);
/* 2651: enforce user interaction for security by always asking where to download
 * [SETUP-CHROME] On Android this blocks longtapping and saving images
 * [SETTING] General>Downloads>Always ask you where to save files ***/
user_pref("browser.download.useDownloadDir", false);
/* 2652: disable adding downloads to the system's "recent documents" list ***/
user_pref("browser.download.manager.addToRecentDocs", false);
/* 2653: disable hiding mime types (Options>General>Applications) not associated with a plugin ***/
user_pref("browser.download.hide_plugins_without_extensions", false);
/* 2654: disable "open with" in download dialog [FF50+] [SETUP-HARDEN]
 * This is very useful to enable when the browser is sandboxed (e.g. via AppArmor)
 * in such a way that it is forbidden to run external applications.
 * [WARNING] This may interfere with some users' workflow or methods
 * [1] https://bugzilla.mozilla.org/1281959 ***/
   // user_pref("browser.download.forbid_open_with", true);

 /** SECURITY ***/
 /* 2680: enforce CSP (Content Security Policy)
  * [WARNING] CSP is a very important and widespread security feature. Don't disable it!
  * [1] https://developer.mozilla.org/docs/Web/HTTP/CSP ***/
 user_pref("security.csp.enable", true); // [DEFAULT: true]
 /* 2684: enforce a security delay on some confirmation dialogs such as install, open/save
  * [1] https://www.squarefree.com/2004/07/01/race-conditions-in-security-dialogs/ ***/
 user_pref("security.dialog_enable_delay", 700);


/*** [SECTION 2700]: PERSISTENT STORAGE
     Data SET by websites including
            cookies : profile\cookies.sqlite
       localStorage : profile\webappsstore.sqlite
          indexedDB : profile\storage\default
           appCache : profile\OfflineCache
     serviceWorkers :
     [NOTE] indexedDB and serviceWorkers are not available in Private Browsing Mode
     [NOTE] Blocking cookies also blocks websites access to: localStorage (incl. sessionStorage),
     indexedDB, sharedWorker, and serviceWorker (and therefore service worker cache and notifications)
     If you set a site exception for cookies (either "Allow" or "Allow for Session") then they become
     accessible to websites except shared/service workers where the cookie setting *must* be "Allow"
***/
user_pref("_user.js.parrot", "2700 syntax error: the parrot's joined the bleedin' choir invisible!");
/* 2701: disable 3rd-party cookies and site-data [SETUP-WEB]
 * 0=Accept cookies and site data, 1=(Block) All third-party cookies, 2=(Block) All cookies,
 * 3=(Block) Cookies from unvisited websites, 4=(Block) Cross-site and social media trackers (FF63+) (default FF69+)
 * [NOTE] You can set exceptions under site permissions or use an extension
 * [NOTE] Enforcing category to custom ensures ETP related prefs are always honored
 * [SETTING] Privacy & Security>Enhanced Tracking Protection>Custom>Cookies ***/
user_pref("network.cookie.cookieBehavior", 1);
user_pref("browser.contentblocking.category", "custom");
/* 2702: set third-party cookies (i.e ALL) (if enabled, see 2701) to session-only
   and (FF58+) set third-party non-secure (i.e HTTP) cookies to session-only
   [NOTE] .sessionOnly overrides .nonsecureSessionOnly except when .sessionOnly=false and
   .nonsecureSessionOnly=true. This allows you to keep HTTPS cookies, but session-only HTTP ones
 * [1] https://feeding.cloud.geek.nz/posts/tweaking-cookies-for-privacy-in-firefox/ ***/
user_pref("network.cookie.thirdparty.sessionOnly", true);
user_pref("network.cookie.thirdparty.nonsecureSessionOnly", true); // [FF58+]
/* 2703: delete cookies and site data on close
 * 0=keep until they expire (default), 2=keep until you close Firefox
 * [NOTE] The setting below is disabled (but not changed) if you block all cookies (2701 = 2)
 * [SETTING] Privacy & Security>Cookies and Site Data>Delete cookies and site data when Firefox is closed ***/
   // user_pref("network.cookie.lifetimePolicy", 2);
/* 2710: disable DOM (Document Object Model) Storage
 * [WARNING] This will break a LOT of sites' functionality AND extensions!
 * You are better off using an extension for more granular control ***/
   // user_pref("dom.storage.enabled", false);
/* 2730: disable offline cache ***/
user_pref("browser.cache.offline.enable", false);
/* 2740: disable service worker cache and cache storage
 * [NOTE] We clear service worker cache on exiting Firefox (see 2803)
 * [1] https://w3c.github.io/ServiceWorker/#privacy ***/
   // user_pref("dom.caches.enabled", false);
/* 2750: disable Storage API [FF51+]
 * The API gives sites the ability to find out how much space they can use, how much
 * they are already using, and even control whether or not they need to be alerted
 * before the user agent disposes of site data in order to make room for other things.
 * [1] https://developer.mozilla.org/docs/Web/API/StorageManager
 * [2] https://developer.mozilla.org/docs/Web/API/Storage_API
 * [3] https://blog.mozilla.org/l10n/2017/03/07/firefox-l10n-report-aurora-54/ ***/
   // user_pref("dom.storageManager.enabled", false);
/* 2755: disable Storage Access API [FF65+]
 * [1] https://developer.mozilla.org/en-US/docs/Web/API/Storage_Access_API ***/
   // user_pref("dom.storage_access.enabled", false);


/*** [SECTION 2800]: SHUTDOWN
     You should set the values to what suits you best.
     - "Offline Website Data" includes appCache (2730), localStorage (2710),
       service worker cache (2740), and QuotaManager (IndexedDB (2720), asm-cache)
     - In both 2803 + 2804, the 'download' and 'history' prefs are combined in the
       Firefox interface as "Browsing & Download History" and their values will be synced
***/
user_pref("_user.js.parrot", "2800 syntax error: the parrot's bleedin' demised!");
/* 2802: enable Firefox to clear items on shutdown (see 2803)
 * [SETTING] Privacy & Security>History>Custom Settings>Clear history when Firefox closes ***/
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
/* 2803: set what items to clear on shutdown (if 2802 is true) [SETUP-CHROME]
 * [NOTE] If 'history' is true, downloads will also be cleared regardless of the value
 * but if 'history' is false, downloads can still be cleared independently
 * However, this may not always be the case. The interface combines and syncs these
 * prefs when set from there, and the sanitize code may change at any time
 * [SETTING] Privacy & Security>History>Custom Settings>Clear history when Firefox closes>Settings ***/
user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.cookies", false);
user_pref("privacy.clearOnShutdown.downloads", true); // see note above
user_pref("privacy.clearOnShutdown.formdata", true); // Form & Search History
user_pref("privacy.clearOnShutdown.history", false); // Browsing & Download History
user_pref("privacy.clearOnShutdown.offlineApps", false); // Offline Website Data
user_pref("privacy.clearOnShutdown.sessions", true); // Active Logins
user_pref("privacy.clearOnShutdown.siteSettings", false); // Site Preferences
/* 2804: reset default items to clear with Ctrl-Shift-Del (to match 2803) [SETUP-CHROME]
 * This dialog can also be accessed from the menu History>Clear Recent History
 * Firefox remembers your last choices. This will reset them when you start Firefox.
 * [NOTE] Regardless of what you set privacy.cpd.downloads to, as soon as the dialog
 * for "Clear Recent History" is opened, it is synced to the same as 'history' ***/
user_pref("privacy.cpd.cache", true);
user_pref("privacy.cpd.cookies", true);
   // user_pref("privacy.cpd.downloads", true); // not used, see note above
user_pref("privacy.cpd.formdata", true); // Form & Search History
user_pref("privacy.cpd.history", true); // Browsing & Download History
user_pref("privacy.cpd.offlineApps", true); // Offline Website Data
user_pref("privacy.cpd.passwords", false); // this is not listed
user_pref("privacy.cpd.sessions", true); // Active Logins
user_pref("privacy.cpd.siteSettings", false); // Site Preferences
/* 2805: clear Session Restore data when sanitizing on shutdown or manually [FF34+]
 * [NOTE] Not needed if Session Restore is not used (see 0102) or is already cleared with history (see 2803)
 * [NOTE] privacy.clearOnShutdown.openWindows prevents resuming from crashes (see 1022)
 * [NOTE] privacy.cpd.openWindows has a bug that causes an additional window to open ***/
   // user_pref("privacy.clearOnShutdown.openWindows", true);
   // user_pref("privacy.cpd.openWindows", true);
/* 2806: reset default 'Time range to clear' for 'Clear Recent History' (see 2804)
 * Firefox remembers your last choice. This will reset the value when you start Firefox.
 * 0=everything, 1=last hour, 2=last two hours, 3=last four hours,
 * 4=today, 5=last five minutes, 6=last twenty-four hours
 * [NOTE] The values 5 + 6 are not listed in the dropdown, which will display a
 * blank value if they are used, but they do work as advertised ***/
user_pref("privacy.sanitize.timeSpan", 4);


/*** [SECTION 4000]: FPI (FIRST PARTY ISOLATION) ***/
/*** SKIPPED ***/


/*** [SECTION 4500]: RFP (RESIST FINGERPRINTING)
   This master switch will be used for a wide range of items, many of which will
   **override** existing prefs from FF55+, often providing a **better** solution
   IMPORTANT: As existing prefs become redundant, and some of them WILL interfere
   with how RFP works, they will be moved to section 4600 and made inactive
***/
user_pref("_user.js.parrot", "4500 syntax error: the parrot's popped 'is clogs");
/* 4501: enable privacy.resistFingerprinting [FF41+]
 * This pref is the master switch for all other privacy.resist* prefs unless stated
 * [SETUP-WEB] RFP can cause the odd website to break in strange ways, and has a few side affects,
 * but is largely robust nowadays. Give it a try. Your choice. Also see 4504 (letterboxing).
 * [1] https://bugzilla.mozilla.org/418986 ***/
user_pref("privacy.resistFingerprinting", true);
/* 4502: set new window sizes to round to hundreds [FF55+] [SETUP-CHROME]
 * Width will round down to multiples of 200s and height to 100s, to fit your screen.
 * The override values are a starting point to round from if you want some control
 * [1] https://bugzilla.mozilla.org/1330882
 * [2] https://hardware.metrics.mozilla.com/ ***/
   // user_pref("privacy.window.maxInnerWidth", 1000);
   // user_pref("privacy.window.maxInnerHeight", 1000);
/* 4503: disable mozAddonManager Web API [FF57+]
 * [NOTE] As a side-effect in FF57-59 this allowed extensions to work on AMO. In FF60+ you also need
 * to sanitize or clear extensions.webextensions.restrictedDomains (see 2662) to keep that side-effect
 * [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=1384330,1406795,1415644,1453988 ***/
user_pref("privacy.resistFingerprinting.block_mozAddonManager", true); // [HIDDEN PREF]
/* 4504: enable RFP letterboxing [FF67+]
 * Dynamically resizes the inner window (FF67; 200w x100h: FF68+; stepped ranges) by applying letterboxing,
 * using dimensions which waste the least content area, If you use the dimension pref, then it will only apply
 * those resolutions. The format is "width1xheight1, width2xheight2, ..." (e.g. "800x600, 1000x1000, 1600x900")
 * [SETUP-WEB] This does NOT require RFP (see 4501) **for now**, so if you're not using 4501, or you are but you're
 * not taking anti-fingerprinting seriously and a little visual change upsets you, then feel free to flip this pref
 * [WARNING] The dimension pref is only meant for testing, and we recommend you DO NOT USE it
 * [1] https://bugzilla.mozilla.org/1407366 ***/

   // Enabling it will lead to a border between inner window and outer window
   // user_pref("privacy.resistFingerprinting.letterboxing", true); // [HIDDEN PREF]
   // user_pref("privacy.resistFingerprinting.letterboxing.dimensions", ""); // [HIDDEN PREF]
/* 4510: disable showing about:blank as soon as possible during startup [FF60+]
 * When default true (FF62+) this no longer masks the RFP chrome resizing activity
 * [1] https://bugzilla.mozilla.org/1448423 ***/
user_pref("browser.startup.blankWindow", false);


/*** [SECTION 4600]: RFP ALTERNATIVES ***/
/*** NOT NEEDED ***/


/*** [SECTION 5000]: PERSONAL
   Non-project related but useful. If any of these interest you, add them to your overrides ***/
user_pref("_user.js.parrot", "5000 syntax error: this is an ex-parrot!");
/* WELCOME & WHAT's NEW NOTICES ***/
   // user_pref("browser.startup.homepage_override.mstone", "ignore"); // master switch
user_pref("startup.homepage_welcome_url", "");
user_pref("startup.homepage_welcome_url.additional", "");
   // user_pref("startup.homepage_override_url", ""); // What's New page after updates
/* WARNINGS ***/
   // user_pref("browser.tabs.warnOnCloseOtherTabs", false);
user_pref("browser.tabs.warnOnClose", true);
user_pref("browser.tabs.warnOnOpen", true);
   // user_pref("full-screen-api.warning.delay", 0);
   // user_pref("full-screen-api.warning.timeout", 0);
/* APPEARANCE ***/
   // user_pref("browser.download.autohideButton", false); // [FF57+]
   // user_pref("toolkit.cosmeticAnimations.enabled", false); // [FF55+]
   // user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); // [FF68+] allow userChrome/userContent
/* CONTENT BEHAVIOR ***/
// user_pref("accessibility.typeaheadfind", true); // enable "Find As You Type"
   // user_pref("clipboard.autocopy", false); // disable autocopy default [LINUX]
   // user_pref("layout.spellcheckDefault", 2); // 0=none, 1-multi-line, 2=multi-line & single-line
/* UX BEHAVIOR ***/
   // user_pref("browser.backspace_action", 2); // 0=previous page, 1=scroll up, 2=do nothing
   // user_pref("browser.urlbar.decodeURLsOnCopy", true); // see bugzilla 1320061 [FF53+]
user_pref("browser.tabs.closeWindowWithLastTab", true);
user_pref("browser.tabs.loadBookmarksInTabs", true); // open bookmarks in a new tab [FF57+]
user_pref("browser.ctrlTab.recentlyUsedOrder", false);
user_pref("browser.warnOnQuit", true);
// disable new urlbar
user_pref("browser.urlbar.update1", false);
user_pref("browser.urlbar.update1.interventions", false);
user_pref("browser.urlbar.update1.searchTips", false);
user_pref("browser.urlbar.update1.view.stripHttps", false);
   // user_pref("general.autoScroll", false); // middle-click enabling auto-scrolling [DEFAULT: false on Linux]
   // user_pref("ui.key.menuAccessKey", 0); // disable alt key toggling the menu bar [RESTART]
   // user_pref("view_source.tab", false); // view "page/selection source" in a new window [FF68+, FF59 and under]
/* UX FEATURES: disable and hide the icons and menus ***/
   // user_pref("browser.messaging-system.whatsNewPanel.enabled", false); // What's New [FF69+]
   // user_pref("extensions.pocket.enabled", false); // Pocket Account [FF46+]
   // user_pref("identity.fxaccounts.enabled", false); // Firefox Accounts & Sync [FF60+] [RESTART]
   // user_pref("reader.parse-on-load.enabled", false); // Reader View
user_pref("findbar.highlightAll", true);

user_pref("reader.color_scheme", "dark");
user_pref("reader.content_width", 6);
user_pref("reader.font_size", 4);
user_pref("reader.font_type", "serif");
user_pref("reader.line_height", 5);
/* OTHER ***/
   // user_pref("browser.bookmarks.max_backups", 2);
   // user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false); // disable CFR [FF67+]
      // [SETTING] General>Browsing>Recommend extensions as you browse
   // user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false); // disable CFR [FF67+]
      // [SETTING] General>Browsing>Recommend features as you browse
   // user_pref("network.manage-offline-status", false); // see bugzilla 620472
   // user_pref("xpinstall.signatures.required", false); // enforced extension signing (Nightly/ESR)
user_pref("privacy.donottrackheader.enabled", false);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("network.trr.custom_uri", "https://dns.nextdns.io/59719f");
user_pref("network.trr.mode", 2);
user_pref("network.trr.uri", "https://dns.nextdns.io/59719f");

/* sync settings */
user_pref("services.sync.declinedEngines", "tabs,passwords,history");
user_pref("services.sync.engine.forms", false);
user_pref("services.sync.engine.history", false);
user_pref("services.sync.engine.passwords", false);
user_pref("services.sync.engine.tabs", false);
user_pref("services.sync.syncInterval", 600000);
user_pref("services.sync.syncThreshold", 300);


/* END: internal custom pref to test for syntax errors ***/
user_pref("_user.js.parrot", "SUCCESS: No no he's not dead, he's, he's restin'!");
