const fs = require('fs');
const path = require('path');
const os = require('os');

// Define the base directory for dotfiles and the home directory
const dotfilesRepo = path.join(os.homedir(), 'git/dotfiles');
const homeDir = os.homedir();
const configDir = path.join(homeDir, '.config');
const gnuPgDir = path.join(homeDir, '.gnupg');

// Utility function to handle symlink creation with backup
function createSymlink(src, dest) {
  try {
    // If a file or symlink already exists skip, otherwise rename it to .backup
    if (fs.existsSync(dest)) {
      if (fs.lstatSync(dest).isSymbolicLink()) {
        console.log(`Symlink already exists at ${dest}`);
        return;
      }
      fs.renameSync(dest, `${dest}.backup`);
      console.log(`Renamed existing ${dest} to ${dest}.backup`);
    }
    // Create the symlink
    fs.symlinkSync(src, dest);
    console.log(`Linked ${src} to ${dest}`);
  } catch (err) {
    console.error(`Error linking ${src} to ${dest}:`, err);
  }
}

// Recursive function to process each item in the dotfiles directory
function linkDotfiles(srcDir, destDir) {
  const items = fs.readdirSync(srcDir);

  items.forEach((item) => {
    // Skip .DS_Store files
    if (item === '.DS_Store') {
      console.log(`Skipping ${item}`);
      return;
    }

    const srcPath = path.join(srcDir, item);
    let destPath;

    // Special handling for files within system/.config
    if (srcDir.endsWith('system/.config')) {
      // For system/.config, only link directories directly into ~/.config
        destPath = path.join(configDir, item);
        createSymlink(srcPath, destPath);
    } else if (srcDir.endsWith('system/.gnupg')) {
      // For system/.gnupg, only link files directly into ~/.gnupg
        destPath = path.join(gnuPgDir, item);
        createSymlink(srcPath, destPath);
    }

    // Otherwise, link files and directories relative to the home directory
    destPath = path.join(destDir, item.startsWith('.') ? item : `.${item}`);

    if (fs.statSync(srcPath).isDirectory()) {
      // Ensure directory exists in the destination and recurse
      if (!fs.existsSync(destPath)) {
        fs.mkdirSync(destPath, { recursive: true });
        console.log(`Created directory ${destPath}`);
      }
      linkDotfiles(srcPath, destPath);
    } else {
      // If it's a file, create a symlink
      createSymlink(srcPath, destPath);
    }
  });
}

// Process each top-level folder in dotfiles directory
fs.readdirSync(dotfilesRepo).forEach((category) => {
  const categoryPath = path.join(dotfilesRepo, category);
  // Ignore top level dotfolders
  if (category.startsWith('.')) {
    return;
  }
  if (fs.statSync(categoryPath).isDirectory()) {
    linkDotfiles(categoryPath, homeDir);
  }
});

console.log('Symlink creation completed.');
