# WARNING
This project is extremely new and lots of fundamental things are changing with each commit. Use at your own peril!

# Huh?
mg manages __m__ultiple __g__it repositories, making it easy to work with a team of people sharing a group of repositories.
It's similar to Google's [repo](http://source.android.com/source/version-control.html) tool, but a lot less annoying and complicated.

mg tries to do as little "magic" as possible, telling you exactly what commands it's running on your repos so you're always on top of what's happening.

# What's wrong with submodules?
Not a lot -- some people like them, and they work well in certain situations. That said, we found that:

* Doing a pull on the parent project detaches the heads of all the child projects, which is irritating.
* You can't pin a submodule to a tag or branch, which makes things confusing.
* After every commit on a child, you have to update the parent for other people to "see" the change, which people forget (or can't be bothered) to do.

mg attempts to fix the above without creating too many problems of its own.

# Install
Run this:
<pre>
wget -q -O - https://raw.github.com/georgebashi/mg/master/install-mg.sh | bash
</pre>
Now write your `.mg/config`:

# .mg/config
This file is in git config format. Here's an example to get you going:
<pre>
[repo "redis"]
  url = git@github.com:antirez/redis
[repo "ack"]
  url = git@github.com:petdance/ack
</pre>

If that didn't help, the format is:
<pre>
[repo "DIRNAME"]
  url = GIT_URL_TO_CLONE_FROM
</pre>
