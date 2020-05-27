#!/usr/bin/env bash


case "$@" in
	forward )
		swaymsg seat seat0 cursor press BTN_EXTRA
		swaymsg seat seat0 cursor release BTN_EXTRA
		;;
	backward )
		swaymsg seat seat0 cursor press BTN_SIDE
		swaymsg seat seat0 cursor release BTN_SIDE
		;;
esac
