#!/usr/bin/env bash
# Modded from https://gitlab.com/racy/swayshot/blob/master/swayshot.sh

if [[ -z $WAYLAND_DISPLAY ]]; then
	(>&2 echo Wayland is not running)
	exit 1
fi

if [[ -z $SCREENSHOTS_FOLDER ]]; then
	SCREENSHOTS_FOLDER=$(xdg-user-dir PICTURES)
fi

SCREENSHOT_FILENAME=$SCREENSHOTS_FOLDER/Screenshot-$(date +'%Y-%m-%d-%H%M%S').png

declare -r filter='
# returns the focused node by recursively traversing the node tree
def find_focused_node:
    if .focused then .
	else (
			if .nodes then (.nodes | .[] | find_focused_node)
			else empty
			end
		)
	end;
# returns a string in the format that grim expects
def format_rect:
    "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)";
find_focused_node | format_rect
'

COPY_COMMAND="wl-copy"

# ppm/png/jpg
CAPTURE_FORMAT=png

case "$1" in
	foobar)
		$(swaymsg --type get_tree --raw| jq --raw-output "${filter}")
		;;

	region-to-file)
		grim -t ${CAPTURE_FORMAT} -g "$(slurp -b '#AFAFAFAF' -c '#FF3F3FAF' -s '#00000000' -w 3 -d)" "$SCREENSHOT_FILENAME"
        notify-send.sh "Region screenshot saved at ${SCREENSHOT_FILENAME}"
		echo -n ${SCREENSHOT_FILENAME}
		;;

	region-to-clipboard)
		grim -t ${CAPTURE_FORMAT} -g "$(slurp -b '#AFAFAFAF' -c '#FF3F3FAF' -s '#00000000' -w 3 -d)" - | ${COPY_COMMAND}
        notify-send.sh "Region screenshot copied to clipboard"
		;;

	window-to-file)
		grim -t ${CAPTURE_FORMAT} -g "$(swaymsg --type get_tree --raw | jq --raw-output "${filter}")" "$SCREENSHOT_FILENAME"
        notify-send.sh "Active window screenshot saved at ${SCREENSHOT_FILENAME}"
		echo -n ${SCREENSHOT_FILENAME}
		;;

	window-to-clipboard)
		grim -t ${CAPTURE_FORMAT} -g "$(swaymsg --type get_tree --raw | jq --raw-output "${filter}")" - | ${COPY_COMMAND}
        notify-send.sh "Active window screenshot copied to clipboard"
		;;

	active-display-to-clipboard)
		grim -t ${CAPTURE_FORMAT} -o "$(swaymsg --type get_outputs --raw | jq --raw-output '.[] | select(.focused) | .name')" - | ${COPY_COMMAND}
        notify-send.sh "Active display screenshot copied to clipboard"
		;;

	active-display-to-file)
		grim -t ${CAPTURE_FORMAT} -o "$(swaymsg --type get_outputs --raw | jq --raw-output '.[] | select(.focused) | .name')" "$SCREENSHOT_FILENAME"
        notify-send.sh "Active display screenshot saved at ${SCREENSHOT_FILENAME}"
		echo -n ${SCREENSHOT_FILENAME}
		;;

    all-to-file)
        grim -t ${CAPTURE_FORMAT} $(xdg-user-dir PICTURES)/Screenshot-all-$(date +'%Y-%m-%d-%H%M%S.png')
		notify-send.sh "Whole-screen screenshot saved at ${SCREENSHOT_FILENAME}"
        echo -n ${SCREENSHOT_FILENAME}
        ;;

    all-to-clipboard)
        grim -t ${CAPTURE_FORMAT} - | ${COPY_COMMAND}
		notify-send.sh "Whole-screen screenshot copied to clipboard"
        ;;

	*)
		echo 'Usage: screenshots [all-to-file|all-to-clipboard|active-display-to-clipboard|active-display-to-file|window-to-file|window-to-clipboard|region-to-file|region-to-clipboard]'
		exit 0
		;;
esac
