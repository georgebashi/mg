# Huh?
mg manages __m__ultiple __g__it repositories, making it easy to work with a team of people sharing a group of repositories.
It's similar to Google's [repo](http://source.android.com/source/version-control.html) tool, but a lot less annoying and complicated.

mg tries to do as little "magic" as possible, telling you exactly what commands it's running on your repos so you're always on top of what's happening.

# Install
In a new directory:
<pre>
mkdir .mg
git clone git@github.com:georgebashi/mg .mg/mg
cp .mg/mg/mghelper.sh /usr/local/bin/mg
</pre>
Now write your .mg/config

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
