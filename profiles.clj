{:user {:plugins [[venantius/ultra "0.6.0"]
                  [lein-cljfmt "0.6.4"]
                  [cider/cider-nrepl "0.21.1"]]
        :repl-options {:init (require 'cljfmt.core)}
        :dependencies [[lein-cljfmt "0.6.4"
                        :exclusions [org.clojure/clojure]]
                       [vvvvalvalval/scope-capture "0.3.2"
                        :exclusions [org.clojure/clojure]]
                       [criterium "0.4.4"
                        :exclusions [org.clojure/clojure]]
                       [com.clojure-goes-fast/clj-async-profiler "0.3.0"
                        :exclusions [org.clojure/clojure]]
                       [com.clojure-goes-fast/clj-memory-meter "0.1.2"
                        :exclusions [org.clojure/clojure]]
                       [com.clojure-goes-fast/clj-java-decompiler "0.2.0"
                        :exclusions [org.clojure/clojure]]]}}
