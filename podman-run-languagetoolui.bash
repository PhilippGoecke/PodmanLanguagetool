podman build --no-cache --rm --file Containerfile.LanguagetoolUi --tag languagetool:ui .
podman run --interactive --tty --read-only --cap-drop=ALL --security-opt=no-new-privileges:true --tmpfs /tmp:rw,noexec,nosuid --pids-limit 256 --memory 512m --cpus 1 --publish 3007:3000 languagetool:ui
echo "browse http://localhost:3007/?name=test"
