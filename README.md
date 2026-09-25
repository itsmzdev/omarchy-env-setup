# Omarchy Environment Setup

These scripts help me set up a fresh Omarchy installation. The main script installs the apps I select, removes configured apps and web apps, backs up existing config files before stow my dotfiles, and then stows them. I created them to automate the steps I used to do manually whenever I reinstalled Omarchy. Thanks AI...

## If you want to customize for your like before running

Clone this repository into the expected location. HTTPS works for public repositories without an SSH key; use your fork URL if you want to save your changes:

```bash
mkdir -p ~/repos
git clone https://github.com/<your-username>/omarchy-env-setup.git ~/repos/omarchy-env-setup
cd ~/repos/omarchy-env-setup
```

Edit the app selections before running setup:

- In `install-apps.sh`, add or remove entries in the `installers` array. Each listed installer must exist under `apps/`. To add an app, create `apps/install-<app>.sh`, then add its path (for example, `./apps/install-example.sh`) to the array.
- In `remove-apps.sh`, edit the `webapps` array, the `omarchy pkg drop` list, and any `omarchy remove` commands to match what you want removed.
- Review the matching script in `apps/` if you want to change how an app is installed.

If you want to use your own dotfiles, fork that repository too and change `DOTFILES_REPO_SSH` and `DOTFILES_REPO_HTTPS` in `setup-env.sh` to your fork's URLs. Otherwise, setup will clone the dotfiles repository currently configured there.

When your selections are ready, run the setup once:

```bash
bash ./setup-env.sh
```

It runs the installers first, then removes the selected apps, and finally runs `~/repos/dotfiles/dotSync.sh` to back up existing configuration files and stow the dotfiles. Review all selected scripts and dotfile packages before starting; setup changes installed software and user configuration.

## Quick Install

For a fresh system where no customization is needed. It is my custom version so obviously I don't recommend you to do this.

```bash
curl -fsSL https://raw.githubusercontent.com/itsmzdev/omarchy-env-setup/main/setup-env.sh | bash
```

The clone logic tries SSH first and falls back to HTTPS. SSH requires a working GitHub key; HTTPS works without one for publicly accessible repositories. This command runs the version currently on GitHub, so commit and push changes first.

## Repository Layout

- `setup-env.sh` — entry point, repository clone logic, and execution order.
- `install-apps.sh` — ordered selection of app installer scripts.
- `apps/` — individual `install-<app>.sh` scripts.
- `remove-apps.sh` — web app, package, and system component removal selections.
- Dotfiles and Stow packages are maintained in the separate `dotfiles` repository.
