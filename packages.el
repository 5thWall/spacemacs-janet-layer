;;; packages.el --- janet layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2022 Sylvain Benner & Contributors
;;
;; Author: Andy Arminio <5thWall@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `janet-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `janet/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `janet/pre-init-PACKAGE' and/or
;;   `janet/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst janet-packages
  '(
    ;; major-mode
    (janet-ts-mode :location (recipe
                              :fetcher github
                              :repo "sogaiu/janet-ts-mode"))

    ;; repl
    (ajrepl :location (recipe
                       :fetcher github
                       :repo "sogaiu/ajrepl"))

    ;; ;;netrepl
    ;; (ajsc :location (recipe
    ;;                  :fetcher github
    ;;                  :repo "sogaiu/a-janet-spork-client"))

    ;; linting
    (flycheck-janet (recepie
                     :fetcher github
                     :repo "sogaiu/flycheck-janet"))))

(defun janet/init-janet-ts-mode ()
  "Initialize the major mode"
  (use-package janet-ts-mode
    :init
    (spacemacs/set-leader-keys-for-major-mode "janet-mode"
      "'"  'ajrepl
      "ab" 'ajrepl-send-buffer
      "ar" 'ajrepl-send-region
      "al" 'ajrepl-send-string)
    (with-eval-after-load 'janet-mode
            (define-key janet-mode-map (kbd "C-c M-j") 'ajrepl)
            (define-key janet-mode-map (kbd "C-c C-b") 'ajrepl-send-buffer)
            (define-key janet-mode-map (kbd "C-c C-l") 'ajrepl-send-string)
            (define-key janet-mode-map (kbd "C-c C-r") 'ajrepl-send-region))))

(defun janet/init-ajrepl ()
  "Initialize REPL"
  (use-package ajrepl
    :init (progn
            (spacemacs/register-repl 'ajrepl 'ajrepl "janet")
            ;; (spacemacs/set-leader-keys-for-major-mode "janet-mode"
            ;;  "'" 'ajrepl)
            (add-hook 'janet-ts-mode-hook
                      #'ajrepl-interaction-mode))))

;; (defun janet/init-ajsc ()
;;   "Initialize Netrepl"
;;   (use-package ajsc
;;     :init (progn
;;             (spacemacs/register-repl 'ajsc 'ajsc "janet")
;;             (spacemacs/set-leader-keys-for-major-mode "janet-mode"
;;               "n" 'ajsc)
;;             (add-hook 'janet-ts-mode-hook
;;                       #'ajsc-interaction-mode))))

(defun janet/init-flycheck-janet ()
  "Initialize Flychecking")
