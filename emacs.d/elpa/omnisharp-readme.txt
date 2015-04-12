omnisharp-emacs is a port of the awesome OmniSharp server to the
Emacs text editor. It provides IDE-like features for editing files
in C# solutions in Emacs, provided by an OmniSharp server instance
that works in the background.

See the project home page for more information.

Work in progress! Judge gently!
(require 'json)
(require 'cl-lib)
(require 'files)
(require 'ido)
(require 'thingatpt)
(require 'dash)
(require 'compile)
(require 'dired)
(require 'popup)
(require 'etags)
(require 'flycheck)

(add-to-list 'load-path (expand-file-name (concat (file-name-directory (or load-file-name buffer-file-name)) "/src/")))
(add-to-list 'load-path (expand-file-name (concat (file-name-directory (or load-file-name buffer-file-name)) "/src/actions")))

(require 'omnisharp-utils)
(require 'omnisharp-server-actions)
(require 'omnisharp-auto-complete-actions)

(defgroup omnisharp ()
  "Omnisharp-emacs is a port of the awesome OmniSharp server to
the Emacs text editor. It provides IDE-like features for editing
files in C# solutions in Emacs, provided by an OmniSharp server
instance that works in the background."
  :group 'external
  :group 'csharp)
