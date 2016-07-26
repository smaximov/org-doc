;;; org-doc.el --- generate or update conventional library headers using Org mode files -*- lexical-binding: t; -*-

;; Copyright (C) 2016 Sergei Maximov

;; Author: Sergei Maximov <s.b.maximov@gmail.com>
;; Created: 20 Jul 2016
;; Version: 0.2.1
;; Package-Requires: ((dash "2.0") (emacs "24.4") (org "8.0"))
;; Keywords: convenience, docs, tools
;; URL: https://github.com/smaximov/org-doc

;; This file is not part of GNU Emacs.

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

;; Table of Contents
;; ─────────────────

;; 1 org-doc
;; .. 1.1 Why?
;; .. 1.2 Getting started
;; .. 1.3 API
;; ..... 1.3.1 Command line interface
;; .. 1.4 Customization
;; ..... 1.4.1 Inclusion of the table of contents (TOC)
;; ..... 1.4.2 Inclusion of subtrees
;; ..... 1.4.3 Inclusion of drawers
;; ..... 1.4.4 Inclusion of tags
;; ..... 1.4.5 Export charset
;; .. 1.5 Similar projects


;; 1 org-doc
;; ═════════

;;   `org-doc' — generate or update conventional [library headers] using
;;   Org mode files.


;;   [library headers]
;;   https://www.gnu.org/software/emacs/manual/html_node/elisp/Library-Headers.html


;; 1.1 Why?
;; ────────

;;   If you have a README file with the description of your Emacs Lisp
;;   package (which you definetely should have), you may as well want to
;;   use that file as the canonical source of the documentation for the
;;   package. However, there is another place which needs this
;;   documentation: the commentary section of your main library file; you
;;   can update it manually, but it's tedious and error prone (not to
;;   mention it's a violation of the [DRY] principle).

;;   Org mode has built-in export facilities which can be used to convert
;;   Org documents into various formats, including a simple plain text
;;   format (`ascii' backend).

;;   This package employs these facilities to generate library headers from
;;   Org files automatically; it may be used either from inside of Emacs or
;;   from the command line.


;;   [DRY] https://en.wikipedia.org/wiki/Don't_repeat_yourself


;; 1.2 Getting started
;; ───────────────────

;;   /Note/: these steps are written with assumption you're using [Cask]
;;   for project management.

;;   1. [Optional] If you have installed `org-doc' manually (the only
;;      option at the moment), create a link to `org-doc':

;;      ┌────
;;      │ $ cask link org-doc path/to/org-doc/installation
;;      └────

;;   2. Add `org-doc' to the development dependencies of your library:

;;      ┌────
;;      │ (development
;;      │  (depends-on "org-doc"))
;;      └────

;;      Fetch dependencies:

;;      ┌────
;;      │ $ cask install
;;      └────

;;   3. Put the [library header] boilerplate in your ELisp file.

;;   4. Generate /Commentary/ section of the library headers:

;;      ┌────
;;      │ $ cask exec org-doc README.org your-package.el
;;      └────

;;   5. [Optional] Generate /Change Log/ section of the library headers:

;;      ┌────
;;      │ $ cask exec org-doc --section changelog CHANGELOG.org your-package.el
;;      └────

;;   6. Commit.


;;   [Cask] https://github.com/cask/cask

;;   [library header]
;;   https://www.gnu.org/software/emacs/manual/html_node/elisp/Library-Headers.html


;; 1.3 API
;; ───────

;;   Use `M-x describe-function <NAME>' for details.

;;   • *command* `org-doc:update'

;;     Update library headers using the content of an Org document.

;;   • *function* `org-doc:export-buffer-as-string'.

;;     Export the Org document opened in the current buffer as a string.

;;   • *function* `org-doc:export-file-as-string'.

;;     Export an Org document as a string.


;; 1.3.1 Command line interface
;; ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

;;   `org-doc' provides an executable script which can be invoked like
;;   this:

;;   ┌────
;;   │ $ cask exec org-doc [OPTION]... ORG-FILE ELISP-FILE
;;   └────

;;   Run `cask exec org-doc --help' to see available options.


;; 1.4 Customization
;; ─────────────────

;;   The user can set a number of options which affect the exporting
;;   process.

;;   Each option can be set in several ways:

;;   • *in-file keyword*

;;     A line which starts with a `#+' followed by a keyword, a colon and
;;     then individual words defining a setting. Example:

;;     ┌────
;;     │ #+TITLE: the title of the document
;;     └────

;;   • *in-file option*

;;     An option in compact form using the `#+OPTIONS' keyword:

;;     ┌────
;;     │ #+OPTIONS: opt1 opt2 opt3 ... optN
;;     └────

;;     `opt' consists of a short key followed by a value. For example,
;;     option `toc:' toggles inclusion of the table of contents; the
;;     following setting excludes the table of contens from export:

;;     ┌────
;;     │ #+OPTIONS: toc:nil
;;     └────

;;     Accepted values vary from option to option.

;;     To specify a rather long list if such options, one can use several
;;     `#+OPTIONS' lines.

;;   • *property*

;;     An option specified via the optional property list `EXT-PLIST'
;;     passed as the last argument of the public functions (see the *API*
;;     section). For example, to enable export using UTF-8 characters, pass
;;     `(list :ascii-charset 'utf-8)' as the last argument of an export
;;     function.

;;   • *variable*

;;     A global variable.

;;   This package also enables setting the options via command line
;;   arguments, which are mapped to the corresponding *properties*.

;;   In-file settings take precedence over keyword properties, which in
;;   turn override global variables.

;;   This section gives a brief description of common options; for more
;;   details, see the dedicated sections ([Export settings], [Publishing
;;   options]) of the Org mode manual.


;;   [Export settings] http://orgmode.org/manual/Export-settings.html

;;   [Publishing options] http://orgmode.org/manual/Publishing-options.html


;; 1.4.1 Inclusion of the table of contents (TOC)
;; ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

;;   The table of content is normally inserted before the first headline of
;;   the file.

;;   • *in-file option* `toc:'

;;     If this options is a number, use this number as the depth of the
;;     generated TOC.  Setting this option to `nil' disables default TOC.

;;     Synonyms:

;;     ⁃ *property* `:toc'
;;     ⁃ *variable* `org-doc-with-toc'

;;   • *in-file keyword* `#+TOC'

;;     Insert TOC at the current position.

;;   See [Table of contents] for more details.


;;   [Table of contents] http://orgmode.org/manual/Table-of-contents.html


;; 1.4.2 Inclusion of subtrees
;; ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

;;   • *in-file keyword* `#+EXCLUDE_TAGS'

;;     The tags that exclude a tree from export (the default value is
;;     `:noexport:').

;;     Alternatives:

;;     ⁃ *in-file option* `exclude-tags:'
;;     ⁃ *property* `:exclude-tags'
;;     ⁃ *variable* `org-export-exclude-tags'

;;   • *in-file keyword* `#+INCLUDE_TAGS'

;;     The tags that select a tree for export (the default value is
;;     `:export:'). This setting takes precedence over `#+EXCLUDE_TAGS'.

;;     Alternatives:

;;     ⁃ *in-file option* `select-tags:'
;;     ⁃ *property* `:select-tags'
;;     ⁃ *variable* `org-export-select-tags'


;; 1.4.3 Inclusion of drawers
;; ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

;;   /Note/: you need to specify custom drawers using the `#+DRAWERS'
;;   keyword for Org mode versions prior to 8.3.

;;   • *in-file optons* `d:'

;;     A list of drawers to include. If the first element is the atom
;;     `not', specify drawers to exclude instead.

;;     Alternatives:

;;     ⁃ *property* `:with-drawers'
;;     ⁃ *variable* `org-export-with-drawers'


;; 1.4.4 Inclusion of tags
;; ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

;;   • *in-file option* `tags:'

;;     Toggles inclusion of tags.

;;     Alternatives:

;;     ⁃ *property* `:with-tags'
;;     ⁃ *variable* `org-export-with-tags'


;; 1.4.5 Export charset
;; ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

;;   • *property* `:ascii-charset'

;;     The charset allowed to represent various elements and objects during
;;     export (the default value is `ascii').

;;     Alternatives:

;;     ⁃ *variable* `org-ascii-charset',
;;     ⁃ *command-line argument* `--charset' (`-c')


;; 1.5 Similar projects
;; ────────────────────

;;   • [org2elcomment] - provides an interactive function to update the
;;     commentary section of an Emacs Lisp file using the contents of an
;;     Org file opened in the current buffer.
;;   • [make-readme-markdown] - in contrast to `org-doc', this package
;;     treats an Emacs Lisp file as the canonical source of
;;     documentation. That file is used to generate `README' in the
;;     Markdown format. The package provides additional features like
;;     auto-detected badges and API documentation of public functions.


;;   [org2elcomment] https://github.com/cute-jumper/org2elcomment

;;   [make-readme-markdown] https://github.com/mgalgs/make-readme-markdown

;;; Change Log:

;; v0.2.1
;; ══════

;;   • initial release.

;;; Code:

(require 'org-doc-export)
(require 'org-doc-headers)
(require 'org-doc-util)

(defconst org-doc:version "0.2.1")

(defun org-doc:update (section-name org elisp &optional ext-plist)
  "Update library headers using the content of an Org document.

SECTION-NAME is a string indicating which section of the header to update.
Valid values are defined in `org-doc::section-names'.

ORG is a name of Org document which contents will be exported.

ELISP is a name of the Emacs Lisp file which comment header will be updated.

Optional argument EXT-PLIST, when provided, is a property list
with external parameters overriding Org default settings, but
still inferior to file-local settings.

Function returns the converted content of the ORG file."
  (interactive
   (list (completing-read "Section [commentary, changelog, or history]: "
                          org-doc::section-names)
         (read-file-name "Org document: " nil nil 'confirm)
         (read-file-name "ELisp file: " nil nil 'confirm)))

  (unless (org-doc::valid-section-name? section-name)
    (error "Invalid section name: `%s'" section-name))

  (let* ((export-result
          (org-doc:export-file-as-string org ext-plist))

         ;; the buffer associated with the `elisp' file;
         ;; nil if no buffers visit that file:
         (elisp-buffer-visited? (get-file-buffer elisp))

         ;; create a new buffer if necessary
         (elisp-buffer (or elisp-buffer-visited?
                           (find-file-noselect (expand-file-name elisp)))))

    (unwind-protect
        (with-current-buffer elisp-buffer
          (org-doc::update-comment-header (org-doc::section-symbol section-name)
                                          export-result)
          (basic-save-buffer)
          export-result)

      ;; kill the buffer associated with the `elisp' file
      ;; if we created it manually.
      (unless elisp-buffer-visited?
        (kill-buffer elisp-buffer)))))

(provide 'org-doc)
;;; org-doc.el ends here
