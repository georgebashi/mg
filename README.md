# Huh?
mg manages __m__ultiple __g__it repositories, making it easy to work with a team of people sharing a group of repositories.
It's similar to Google's [repo](http://source.android.com/source/version-control.html) tool, but a lot less annoying and complicated.
It's also a bit like [mr](http://kitenet.net/~joey/code/mr/), but doesn't attempt to plaster a layer of abstraction over git.

mg does no "magic" whatsoever. It tells you exactly what commands it's running on your repos so you're always on top of what's happening.

# What's wrong with submodules?
Not a lot – some people like them, and they work well in certain situations. That said, we found that:

* Doing a pull on the parent project detaches the heads of all the child projects, which is irritating.
* You can't pin a submodule to a tag or branch, which makes things confusing.
* After every commit on a child, you have to update the parent for other people to "see" the change, which people forget (or can't be bothered) to do.

mg attempts to fix the above without creating too many problems of its own.

# Install
Run this:
<pre>
wget -q -O - https://raw.github.com/georgebashi/mg/master/install-mg.sh | bash
</pre>

# Usage
Say you've got a directory structure like this:
<pre>
project/
    project-backend/
    project-frontend/
    project-common/
    libraries/
        libAbcde/
        libFghij/
</pre>
Run `mg init` in the `project` dir. mg will find all the children and set up the `.mg/config` file. You might then want to check that file into version control.
