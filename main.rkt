#!/usr/bin/env racket

#lang racket/base

(require racket/cmdline
         racket/runtime-path
         ffi/unsafe
         ffi/cvector)

(define-runtime-path here ".")

(define nixinfo-lib             (ffi-lib (build-path here "libnixinfo_ffi.so")))
(define nixinfo-cpu-fun         (get-ffi-obj "cpu_ffi"         nixinfo-lib (_fun ->      _string)))
(define nixinfo-device-fun      (get-ffi-obj "device_ffi"      nixinfo-lib (_fun ->      _string)))
(define nixinfo-distro-fun      (get-ffi-obj "distro_ffi"      nixinfo-lib (_fun ->      _string)))
(define nixinfo-editor-fun      (get-ffi-obj "editor_ffi"      nixinfo-lib (_fun ->      _string)))
(define nixinfo-environment-fun (get-ffi-obj "environment_ffi" nixinfo-lib (_fun ->      _string)))
(define nixinfo-gpu-fun         (get-ffi-obj "gpu_ffi"         nixinfo-lib (_fun ->      _string)))
(define nixinfo-hostname-fun    (get-ffi-obj "hostname_ffi"    nixinfo-lib (_fun ->      _string)))
(define nixinfo-kernel-fun      (get-ffi-obj "kernel_ffi"      nixinfo-lib (_fun ->      _string)))
(define nixinfo-memory-fun      (get-ffi-obj "memory_ffi"      nixinfo-lib (_fun ->      _string)))
(define nixinfo-packages-fun    (get-ffi-obj "packages_ffi"    nixinfo-lib (_fun _int -> _string)))
(define nixinfo-shell-fun       (get-ffi-obj "shell_ffi"       nixinfo-lib (_fun ->      _string)))
(define nixinfo-terminal-fun    (get-ffi-obj "terminal_ffi"    nixinfo-lib (_fun ->      _string)))
(define nixinfo-uptime-fun      (get-ffi-obj "uptime_ffi"      nixinfo-lib (_fun ->      _string)))
(define nixinfo-user-fun        (get-ffi-obj "user_ffi"        nixinfo-lib (_fun ->      _string)))
(define nixinfo-music-fun       (get-ffi-obj "music_ffi"       nixinfo-lib (_fun ->      _string)))

(define package-manager (make-parameter "portage"))

(command-line
  #:program "kinda sus, rktfetch"
  #:once-each
  [("-p" "--packages") pkgman
    "Display the package counts of the specified package manager." 
    (package-manager pkgman)])

;; To pass the package manager, it needs to be identified with a number.
;; To tell you the truth, I kind gave up on trying to pass a string.
;; An integer was much easier.
(define pm (case (package-manager)
             [("apk") 0]
             [("apt") 1]
             [("dnf") 2]
             [("dpkg") 3]
             [("eopkg") 4]
             [("pacman") 5]
             [("pip") 6]
             [("portage") 7]
             [("rpm") 8]
             [("xbps") 9]))

(define cpu         (nixinfo-cpu-fun))
(define device      (nixinfo-device-fun))
(define distro      (nixinfo-distro-fun))
(define editor      (nixinfo-editor-fun))
(define environment (nixinfo-environment-fun))
(define gpu         (nixinfo-gpu-fun))
(define hostname    (nixinfo-hostname-fun))
(define kernel      (nixinfo-kernel-fun))
(define packages    (nixinfo-packages-fun pm))
(define shell       (nixinfo-shell-fun))
(define terminal    (nixinfo-terminal-fun))
(define uptime      (nixinfo-uptime-fun))
(define user        (nixinfo-user-fun))
(define music       (nixinfo-music-fun))
(display (string-append "CPU:  " cpu         "\n"))
(display (string-append "DEV:  " device      "\n"))
(display (string-append "DIST: " distro      "\n"))
(display (string-append "EDTR: " editor      "\n"))
(display (string-append "ENV:  " environment "\n"))
(display (string-append "GPU:  " gpu         "\n"))
(display (string-append "HOST: " hostname    "\n"))
(display (string-append "KRNL: " kernel      "\n"))
(display (string-append "PKGS: " packages    "\n"))
(display (string-append "SH:   " shell       "\n"))
(display (string-append "TERM: " terminal    "\n"))
(display (string-append "UPTM: " uptime      "\n"))
(display (string-append "USER: " user        "\n"))
(display (string-append "MUS:  " music       "\n"))
