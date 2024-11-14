# My dear dotfiles

`$ node link-config.js` to link all the dotfiles to the home directory.

`$ brew bundle install --file=./brew/Brewfile` to install my brew packages.

```bash
chmod +x ~/git/dotfiles/update_brewfile.sh; (crontab -l 2>/dev/null; echo "0 2 * * * /bin/bash ~/git/dotfiles/update_brewfile.sh >> ~/brewfile_update.log 2>&1") | crontab -
```
to update the Brewfile every day at 2am.
