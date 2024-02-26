#!/bin/sh

case "$1" in
	"day")
		emacs -batch -eval '(org-batch-agenda-csv "a" org-agenda-files '"'"'("~/uni" "~/documents" "~/todo.org"))'
		;;
	*)
		emacs -batch -eval '(org-batch-agenda-csv "a" org-agenda-files '"'"'("~/uni" "~/documents" "~/todo.org"))'
		;;
esac
