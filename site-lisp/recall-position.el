;;; recall-position.el --- 

;; Copyright (C) 2011  Christian Johansen

;; Author: Christian Johansen <christian@cjohansen.no>
;; Author: August Lilleaas <august@augustl.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Start a manual "transaction" for buffer navigation by calling
;; remember-buffer-pos, restore point and window scroll after looking around
;; with recall-buffer-pos. Even better, use toggle-buffer-pos for a one-stop
;; remember/recall.
;;
;; Suggested key-bindings: 
;;
;; (global-set-key (kbd "C-c C-r") 'remember-buffer-pos)
;; (global-set-key (kbd "C-c C-s") 'recall-buffer-pos)
;;
;; Or:
;; (global-set-key (kbd "C-c C-s") 'toggle-buffer-pos)
;;
;; toggle-buffer-pos will remember the position the first time it's called and
;; recall it the second time.

(defvar remembered-buffer-pos nil
  "Saved buffer position. Used by remember-buffer-pos and
recall-buffer-pos.")

(make-local-variable 'remembered-buffer-pos)

(defun remember-buffer-pos ()
  "Remembers the current buffer position and window scroll for
later retrieval by recall-buffer-pos."
  (interactive)
  (setq remembered-buffer-pos `(,(point) ,(window-start))))

(defun recall-buffer-pos ()
  "Repositions point and window as saved previously by
remember-buffer-pos"
  (interactive)
  (goto-char (car remembered-buffer-pos))
  (set-window-start (selected-window) (car (cdr remembered-buffer-pos))))

(defun toggle-buffer-pos ()
  "Cycle Remember or recall buffer position."
  (interactive)
  (if (not remembered-buffer-pos)
      (progn
        (remember-buffer-pos)
        (message "Remembered position"))
    (recall-buffer-pos)
    (setq remembered-buffer-pos nil)
    (message "Restored position")))

(provide 'recall-position)
;;; recall-position.el ends here
