# Create a new worktree and branch from within current git directory.
ga() {
  local branch

  if [[ -n "${1:-}" ]]; then
    branch="$1"
  else
    branch="$(python3 -c 'import random, subprocess, sys; names="bulbasaur ivysaur venusaur charmander charmeleon charizard squirtle wartortle blastoise caterpie metapod butterfree weedle kakuna beedrill pidgey pidgeotto pidgeot rattata raticate spearow fearow ekans arbok pikachu raichu sandshrew sandslash nidoran nidorina nidoqueen nidorino nidoking clefairy clefable vulpix ninetales jigglypuff wigglytuff zubat golbat oddish gloom vileplume paras parasect venonat venomoth diglett dugtrio meowth persian psyduck golduck mankey primeape growlithe arcanine poliwag poliwhirl poliwrath abra kadabra alakazam machop machoke machamp bellsprout weepinbell victreebel tentacool tentacruel geodude graveler golem ponyta rapidash slowpoke slowbro magnemite magneton farfetchd doduo dodrio seel dewgong grimer muk shellder cloyster gastly haunter gengar onix drowzee hypno krabby kingler voltorb electrode exeggcute exeggutor cubone marowak hitmonlee hitmonchan lickitung koffing weezing rhyhorn rhydon chansey tangela kangaskhan horsea seadra goldeen seaking staryu starmie mrmime scyther jynx electabuzz magmar pinsir tauros magikarp gyarados lapras ditto eevee vaporeon jolteon flareon porygon omanyte omastar kabuto kabutops aerodactyl snorlax articuno zapdos moltres dratini dragonair dragonite mewtwo mew".split(); used=set(subprocess.check_output(["git", "branch", "--format=%(refname:short)"], text=True).splitlines()); available=[name for name in names if name not in used]; print(random.choice(available) if available else sys.exit("No unused Pokemon names remain"))')" || return 1
  fi

  local directory_branch="${branch//\//-}"
  local base="$(basename "$PWD")"
  local worktree_path="../${base}--${directory_branch}"

  git fetch origin main || return 1
  git worktree add -b "$branch" "$worktree_path" origin/main || return 1
  mise trust "$worktree_path"
  cd "$worktree_path"
}

# Remove worktree and branch from within active worktree directory.
gd() {
  if gum confirm "Remove worktree and branch?"; then
    local cwd worktree branch root

    cwd="$(pwd)"
    worktree="$(basename "$cwd")"
    branch="$(git branch --show-current)"

    # split on first `--`
    root="${worktree%%--*}"

    # Protect against accidentially nuking a non-worktree directory
    if [[ "$root" != "$worktree" ]]; then
      cd "../$root"
      git worktree remove "$worktree" --force
      git branch -D "$branch"
    fi
  fi
}
