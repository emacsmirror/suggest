(require 'suggest)

(ert-deftest suggest--safe-p ()
  (should (not (suggest--safe-p 'upcase '(-1))))
  (should (suggest--safe-p 'upcase '(1)))
  (should (not (suggest--safe-p 'read '(nil))))
  (should (suggest--safe-p 'read '(1 1)))
  (should (not (suggest--safe-p '-interleave '())))
  (should (not (suggest--safe-p '-zip '())))
  (should (suggest--safe-p '-interleave '(1 1)))
  (should (not (suggest--safe-p #'mapcar (list 'unknown-function))))
  (should (not (suggest--safe-p #'mapcar (list (lambda (x) (unknown-function))))))
  (should (suggest--safe-p 'mapcar (list #'identity '(1 2 3)))))

(ert-deftest suggest--unread ()
  (should (equal (suggest--unread 'foo) "'foo"))
  (should (equal (suggest--unread nil) "nil"))
  (should (equal (suggest--unread '(1 2)) "'(1 2)"))
  (should (equal (suggest--unread :foo) ":foo"))
  (should (equal (suggest--unread 42) "42"))
  (should (equal (suggest--unread "foo") "\"foo\""))
  (should (equal (suggest--unread "\n") "\"\\n\""))
  (should (equal (suggest--unread '1+) "#'1+")))
