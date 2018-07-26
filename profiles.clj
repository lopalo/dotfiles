{:user {:plugins [[venantius/ultra "0.5.2"]
                  [lein-cljfmt "0.5.7"]
                  [jonase/eastwood "0.2.5"]
                  [lein-kibit "0.1.5"]]
        :repl-options {:init (require 'cljfmt.core)}
        :dependencies [[org.clojure/tools.nrepl "0.2.12"
                        :exclusions [org.clojure/clojure]]
                       [com.bhauman/rebel-readline "0.1.1"
                        :exclusions [org.clojure/clojure]]
                       [lein-cljfmt "0.5.7"
                        :exclusions [org.clojure/clojure]]
                       [jonase/eastwood "0.2.5"
                        :exclusions [org.clojure/clojure]]
                       [lein-kibit "0.1.5"
                        :exclusions [org.clojure/clojure]]
                       [criterium "0.4.4"
                        :exclusions [org.clojure/clojure]]
                       [com.clojure-goes-fast/clj-async-profiler "0.1.3"
                        :exclusions [org.clojure/clojure]]
                       [com.clojure-goes-fast/clj-memory-meter "0.1.1"
                        :exclusions [org.clojure/clojure]]
                       [com.clojure-goes-fast/clj-java-decompiler "0.1.0"
                        :exclusions [org.clojure/clojure]]]
        :aliases {"rebl" ["trampoline" "run" "-m" "rebel-readline.main"]}}}
