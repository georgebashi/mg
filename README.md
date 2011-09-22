# Install
In a new directory:
<pre>
mkdir .mg
git clone git@github.com:georgebashi/mg .mg/mg
cp .mg/mg/mghelper.sh /usr/local/bin/mg
</pre>
Now write your .mg/config

# `.mg/config`
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
