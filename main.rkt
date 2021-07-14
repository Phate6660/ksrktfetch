#!/usr/bin/env racket

#lang racket/base

(require racket/cmdline
         racket/runtime-path
         ffi/unsafe
         ffi/cvector)

(define-runtime-path here ".")

(define nixinfo-lib             (ffi-lib (build-path here "libnixinfo_ffi.so")))
(define nixinfo-cpu-fun         (get-ffi-obj "cpu_ffi"         nixinfo-lib (_fun ->      _void)))
(define nixinfo-device-fun      (get-ffi-obj "device_ffi"      nixinfo-lib (_fun ->      _void)))
(define nixinfo-distro-fun      (get-ffi-obj "distro_ffi"      nixinfo-lib (_fun ->      _void)))
(define nixinfo-editor-fun      (get-ffi-obj "editor_ffi"      nixinfo-lib (_fun ->      _void)))
(define nixinfo-environment-fun (get-ffi-obj "environment_ffi" nixinfo-lib (_fun ->      _void)))
(define nixinfo-gpu-fun         (get-ffi-obj "gpu_ffi"         nixinfo-lib (_fun ->      _void)))
(define nixinfo-hostname-fun    (get-ffi-obj "hostname_ffi"    nixinfo-lib (_fun ->      _void)))
(define nixinfo-kernel-fun      (get-ffi-obj "kernel_ffi"      nixinfo-lib (_fun ->      _void)))
(define nixinfo-memory-fun      (get-ffi-obj "memory_ffi"      nixinfo-lib (_fun ->      _void)))
(define nixinfo-packages-fun    (get-ffi-obj "packages_ffi"    nixinfo-lib (_fun _int -> _void)))
(define nixinfo-shell-fun       (get-ffi-obj "shell_ffi"       nixinfo-lib (_fun ->      _void)))
(define nixinfo-terminal-fun    (get-ffi-obj "terminal_ffi"    nixinfo-lib (_fun ->      _void)))
(define nixinfo-uptime-fun      (get-ffi-obj "uptime_ffi"      nixinfo-lib (_fun ->      _void)))
(define nixinfo-user-fun        (get-ffi-obj "user_ffi"        nixinfo-lib (_fun ->      _void)))
(define nixinfo-music-fun       (get-ffi-obj "music_ffi"       nixinfo-lib (_fun ->      _void)))

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

(nixinfo-cpu-fun)
(nixinfo-device-fun)
(nixinfo-distro-fun)
(nixinfo-editor-fun)
(nixinfo-environment-fun)
(nixinfo-gpu-fun)
(nixinfo-hostname-fun)
(nixinfo-kernel-fun)
(nixinfo-packages-fun pm)
(nixinfo-shell-fun)
(nixinfo-terminal-fun)
(nixinfo-uptime-fun)
(nixinfo-user-fun)
(nixinfo-music-fun)
