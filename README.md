api-ror-client
==============

Example Ruby on Rails (3.2.12) Client for Ackroo API v1. 

Get started at https://developer.ackroo.com.

---

Setup
-----
*   note that sudo may be required on Linux, but not necessarily for OSX

#####Ruby 2.3.0:
1. Input the following into the terminal:

        git clone https://github.com/ackroo/api-ror-client.git
        cd api-ror-client
        bundle
        bundle install
        gem install json    # required if running 2.*.* versions of ruby
        get install sqlite3 # required if running 2.*.* versions of ruby

2. Open a web browser
3. Navigate to the Ackroo Developer Portal and log in
4. Go to Dashboard tab
5. If you haven't already, create an application via New Application button
6. Click the application name in the list
7. Make note of the keys in the list that appears
8. Within the code base again, open config/environments/development.rb. Make the following changes (note that all 3 items below have the configuration option already defined in the file, but containing an empty or dummy string):
  1. Assign your Client Id  (from the application list in the developer page) to config.client_id. e.g.<br/>
        `config.client_id = 'f348yfh23239304ti9304tk039gk30t94g39s1jd21983rj3t0jf3409394fk43'`
  2. Assign your Client Secret to config.client_secret. e.g.<br/>
        `config.client_secret = '34ij43g390gj34g023jgd290j13f0j24g6yjhg40gj8d2901kjf2894gj4930493'`
  3. assign your Callback URI to config.redirect_uri. e.g.<br/>
        `config.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"`
9. return to the terminal, and within the root of the app, type `rails server`
10. navigate to http://localhost:3000. The application should now load.
    *   If it doesn't, try running `bundle install` again in the command line, then repeat `rails server`
