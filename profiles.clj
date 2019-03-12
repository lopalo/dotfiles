{:user {:plugins [[venantius/ultra "0.5.4"]
                  [lein-cljfmt "0.6.4"]
                  [jonase/eastwood "0.3.5"]
                  [lein-kibit "0.1.6"]]
        :repl-options {:init (require 'cljfmt.core)}
        :dependencies [[lein-cljfmt "0.6.4"
                        :exclusions [org.clojure/clojure]]
                       [jonase/eastwood "0.3.3" ;the highest version that works with Syntastic
                        :exclusions [org.clojure/clojure]]
                       [lein-kibit "0.1.6"
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
