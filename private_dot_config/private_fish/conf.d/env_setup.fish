if command -q docker
    # if there is a rootless docker socket for the current user, use it
    set -l docker_socket "/run/user/$(id -u)/docker.sock"
    if ! test -e "$docker_socket"
        # otherwise default to the normal docker socket location
        set docker_socket "/var/run/docker.sock"
    end

    set -gx DOCKER_HOST "unix://$docker_socket"
end

if command -q podman
    set -gx REGISTRY_AUTH_FILE "$HOME/.config/containers/auth.json"
end

# prefer wayland over x11 as GDK backend (helps some java applications under wayland when they use GTK)
set -gx GDK_BACKEND "wayland,x11"
