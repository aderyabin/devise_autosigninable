Devise Autosigninable
=============
Devise Autosigninable adds functionality of auto sign in to your [devise][1] app.
Devise Autosigninable is compatibile with all default Devise modules.
If Lockable module is activated Devise Autosigninable uses Lockable functionality for failed attempts.
If user is blocked or not confirmed he can't sign in with Devise Autosigninable too.

Devise Autosigninable signs in a user based on an autosignin token (random hash with length 32).
If signed in user try to sign in with Devise Autosigninable he will be sign out firstly and than go to sign in.
So if token is incorrect user will be signed out anyway.

It requires  Devise 1.0 and ONLY works with Rails 2.


Installation
-----------

* Add :autosigninable to your Devise modules in model, for example:

    `devise :registerable, :authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :autosigninable`

* Add devise_autosigninable plugin to your Rails app:

    `script/plugin install https://github.com/aderyabin/devise_autosigninable`

* Generate migration for autosigninable. It creates neccessary fields and fill already existed records.

    `script/generate devise_autosigninable MODEL`

Replace MODEL by the class name you want to add devise, like User, Admin, etc

* Run rake command for generation autosignin tokens

   `rake devise:autosigninable:ensure[MODEL]`

Route and Helpers
-----------
Devise Autosigninable has two methods which help to generate url and link to auto sign in

    auto_signin_url_for(object)

and

    link_to_autosignin(object, title, options)


By default Devise Autosigninable uses `'/:object_id/autosignin/:autosignin_token'` route. For example, for User model:

    /users/1/autosignin/c6718d1a2ebea0f716cb62ad2375af64

Also route understand optional parameter "return_to" to redirect after sign in.

Tests
-----------
All test cases are stored in test/rails_app/tests


[1]:http://github.com/plataformatec/devise
