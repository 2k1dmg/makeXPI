// https://github.com/mozilla-jetpack/jpm/blob/master/data/preferences.js
// common
user_pref("browser.dom.window.dump.enabled", true);
user_pref("javascript.options.strict", true);
user_pref("javascript.options.showInConsole", true);
user_pref("devtools.debugger.remote-enabled", true);
user_pref("extensions.sdk.console.logLevel", "info");
user_pref("extensions.checkCompatibility.nightly", false);
user_pref("extensions.update.enabled", false);
user_pref("extensions.update.notifyUser", false);
user_pref("extensions.enabledScopes", 5);
user_pref("extensions.getAddons.cache.enabled", false);
user_pref("extensions.installDistroAddons", false);
user_pref("extensions.autoDisableScopes", 10);
user_pref("extensions.logging.enabled", false);
user_pref("app.update.enabled", false);
user_pref("extensions.update.url", "http://localhost/extensions-dummy/updateURL");
user_pref("extensions.blocklist.url", "http://localhost/extensions-dummy/blocklistURL");
user_pref("extensions.webservice.discoverURL", "http://localhost/extensions-dummy/discoveryURL");
user_pref("xpinstall.signatures.required", false);
// thunderbird
user_pref("dom.max_chrome_script_run_time", 200);
user_pref("dom.max_script_run_time", 0);
user_pref("mail.shell.checkDefaultClient", false);
user_pref("mail.winsearch.enable", false);
user_pref("mail.winsearch.firstRunDone", true);
user_pref("mail.spotlight.enable", false);
user_pref("mail.spotlight.firstRunDone", true);
user_pref("ldap_2.servers.osx.position", 0);
user_pref("ldap_2.servers.oe.position", 0);
user_pref("mailnews.ui.junk.firstuse", false);
user_pref("mail.account.account1.server", "server1");
user_pref("mail.account.account2.identities", "id1");
user_pref("mail.account.account2.server", "server2");
user_pref("mail.accountmanager.accounts", "account1,account2");
user_pref("mail.accountmanager.defaultaccount", "account2");
user_pref("mail.accountmanager.localfoldersserver", "server1");
user_pref("mail.identity.id1.fullName", "Tinderbox");
user_pref("mail.identity.id1.smtpServer", "smtp1");
user_pref("mail.identity.id1.useremail", "tinderbox@invalid.com");
user_pref("mail.identity.id1.valid", true);
user_pref("mail.root.none-rel", "[ProfD]Mail");
user_pref("mail.root.pop3-rel", "[ProfD]Mail");
user_pref("mail.server.server1.directory-rel", "[ProfD]Mail/Local Folders");
user_pref("mail.server.server1.hostname", "Local Folders");
user_pref("mail.server.server1.name", "Local Folders");
user_pref("mail.server.server1.type", "none");
user_pref("mail.server.server1.userName", "nobody");
user_pref("mail.server.server2.check_new_mail", false);
user_pref("mail.server.server2.directory-rel", "[ProfD]Mail/tinderbox");
user_pref("mail.server.server2.download_on_biff", true);
user_pref("mail.server.server2.hostname", "tinderbox");
user_pref("mail.server.server2.login_at_startup", false);
user_pref("mail.server.server2.name", "tinderbox@invalid.com");
user_pref("mail.server.server2.type", "pop3");
user_pref("mail.server.server2.userName", "tinderbox");
user_pref("mail.smtp.defaultserver", "smtp1");
user_pref("mail.smtpserver.smtp1.hostname", "tinderbox");
user_pref("mail.smtpserver.smtp1.username", "tinderbox");
user_pref("mail.smtpservers", "smtp1");
user_pref("mail.startup.enabledMailCheckOnce", true);
user_pref("mailnews.start_page_override.mstone", "ignore");

user_pref("plugin.default.state", 1);
user_pref("plugin.state.flash", 1);
user_pref("browser.uitour.enabled", false);
user_pref("browser.shell.checkDefaultBrowser", false);
